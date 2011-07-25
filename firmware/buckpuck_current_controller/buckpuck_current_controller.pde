#include <SoftwareSerial.h>
#include <Streaming.h>
#include "SerialLCD.h"
#include <SPI.h>
#include "mcp4261.h"
#include "DigiPot.h"
#include "LookupTable.h"
#include <EEPROM.h>

#define MSG_SIZE 20
#define DIGIPOT_CS 10

SoftwareSerial softSerial(8,9);
SerialLCD lcd(softSerial);

const int channelCount = 4;
char* channelNames[] = {"A","B","C","D"};
char* channelStateNames[] = {"ON ","OFF","SET"};
byte channelStateValue[] = {1,1,1,1};
char* channelStateName = channelStateNames[channelStateValue[0]];
const byte channelSwitchPins[] = {7,6,5,4};
byte channelSwitchState = LOW;

const int potentiometerValueMin = 0;
const int potentiometerValueMax = 1023;
const int potentiometerDisplayMin = 0;
const int potentiometerDisplayMax = 100;
const byte potentiometerPins[] = {A0,A1,A6,A7};
int potentiometerValue;
int potentiometerDisplay;

const int currentValueMin = 0;
const int currentValueMax = 1000;
int currentValueMaxSetting[] = {1000,1000,1000,1000};
int currentValueMaxSettingValue;
int currentValue;

int brightnessValue;
const int brightnessValueLow = 0;
const int brightnessValueHigh = 50;
byte brightnessSwitchState = HIGH;
byte brightnessSwitchStatePrevious = HIGH;
byte brightnessState = LOW;
const byte brightnessSwitchPin = 2;

int digiPotValue;
const int digiPotValueMin = 256;
const int digiPotValueMax = 0;
DigiPot digiPot = DigiPot(DIGIPOT_CS);

int EEPROMAddress_DigiPotInitialized = 0;
byte EEPROM_DigiPotInitializedValueTrue = 123;
byte EEPROM_DigiPotInitializedValue;

int EEPROMAddress_CurrentValueMaxSetting[] = {1,2,3,4};
byte EEPROM_currentValueMin = 0;
byte EEPROM_currentValueMax = 255;
byte EEPROM_currentValueMaxSetting[] = {EEPROM_currentValueMax,EEPROM_currentValueMax,EEPROM_currentValueMax,EEPROM_currentValueMax};
bool EEPROM_currentValueMaxSettingSaved[] = {true,true,true,true};
byte EEPROM_currentValueMaxSettingValue;

char msg[MSG_SIZE];

long previousMillisClearLCD = 0;
const long intervalClearLCD = 1000000;
long previousMillisUpdateLCD = 0;
const long intervalUpdateLCD = 200;
bool updateLCD = false;

const byte setSwitchPin = 3;
byte setSwitchState = HIGH;
bool setMode[] = {false,false,false,false};
bool setModeDeadbandExceeded[] = {false,false,false,false};
int setModeInitialValues[channelCount];
const int setModeValueDeadband = 10;
int setModeValueDifference;

/* x = measured current in mA, y = digiPotValue */
#define TABLE_SIZE 27
int table[TABLE_SIZE][2] = {
  {0, 256},
  {1, 243},
  {5, 240},
  {153, 230},
  {269, 220},
  {370, 210},
  {448, 200},
  {517, 190},
  {576, 180},
  {627, 170},
  {672, 160},
  {711, 150},
  {746, 140},
  {779, 130},
  {806, 120},
  {831, 110},
  {857, 100},
  {875, 90},
  {890, 80},
  {898, 70},
  {904, 60},
  {905, 50},
  {907, 40},
  {909, 30},
  {911, 20},
  {912, 10},
  {914, 0},
};
LookupTable lookup;


void setup() {
  Serial.begin(9600);
  softSerial.begin(115200);
  delay(2500);
  lcd.clearScreen();
  if (brightnessState == LOW) {
    brightnessValue = brightnessValueLow;
  } else if (brightnessState == HIGH) {
    brightnessValue = brightnessValueHigh;
  }
  lcd.setBrightness(brightnessValue);

  // Setup SPI communications
  SPI.setDataMode(SPI_MODE0);
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV8);
  SPI.begin();

  // Initialize digital pot
  digiPot.initialize();
  EEPROM_DigiPotInitializedValue = EEPROM.read(EEPROMAddress_DigiPotInitialized);
  if (EEPROM_DigiPotInitializedValue != EEPROM_DigiPotInitializedValueTrue) {
    EEPROM.write(EEPROMAddress_DigiPotInitialized,EEPROM_DigiPotInitializedValueTrue);
    delay(100);
    for (int channel = 0; channel < channelCount; channel++) {
      digiPot.setWiper_NonVolatile(channel,digiPotValueMin);
      delay(250);
    }
  }

  // initialize the channel switch pins as input and turn on pullup resistors
  for (int channel = 0; channel < channelCount; channel++) {
    pinMode(channelSwitchPins[channel], INPUT);
    digitalWrite(channelSwitchPins[channel], HIGH);
  }

  // initialize the brightness switch pin as input and turn on pullup resistor
  pinMode(brightnessSwitchPin, INPUT);
  digitalWrite(brightnessSwitchPin, HIGH);

  // initialize the set switch pin as input and turn on pullup resistor
  pinMode(setSwitchPin, INPUT);
  digitalWrite(setSwitchPin, HIGH);

  /* Setup lookup table */
  bool rtnVal;
  rtnVal = lookup.setTable(table,TABLE_SIZE);

  /* Initalize currentValueMaxSetting */
  for (int channel = 0; channel < channelCount; channel++) {
    EEPROM_currentValueMaxSettingValue = EEPROM.read(EEPROMAddress_CurrentValueMaxSetting[channel]);
    currentValueMaxSettingValue = map(EEPROM_currentValueMaxSettingValue,EEPROM_currentValueMin,EEPROM_currentValueMax,currentValueMin,currentValueMax);
    currentValueMaxSetting[channel] = currentValueMaxSettingValue;
  }

}


void loop() {
  unsigned long currentMillis = millis();

  /* Clear LCD every once in a while to remove potential artifacts */
  if(intervalClearLCD < (currentMillis - previousMillisClearLCD)) {
    previousMillisClearLCD = currentMillis;
    lcd.clearScreen();
  }

  /* Update LCD? */
  if(intervalUpdateLCD < (currentMillis - previousMillisUpdateLCD)) {
    previousMillisUpdateLCD = currentMillis;
    updateLCD = true;
  }

  /* Check display button status */
  brightnessSwitchState = digitalRead(brightnessSwitchPin);
  if (brightnessSwitchState != brightnessSwitchStatePrevious) {
    brightnessSwitchStatePrevious = brightnessSwitchState;
    if (brightnessSwitchState == LOW) {
      if (brightnessState == LOW) {
        brightnessState = HIGH;
        brightnessValue = brightnessValueHigh;
      } else if (brightnessState == HIGH) {
        brightnessState = LOW;
        brightnessValue = brightnessValueLow;
      }
      lcd.setBrightness(brightnessValue);
    }
  }

  /* Display header row */
  if (updateLCD) {
    lcd.setPos(5,5);
    snprintf(msg, MSG_SIZE, "        mA  MAX POT ");
    lcd.print(msg);
  }

  for (int channel = 0; channel < channelCount; channel++) {
    potentiometerValue = analogRead(potentiometerPins[channel]);
    potentiometerDisplay = map(potentiometerValue,potentiometerValueMin,potentiometerValueMax,potentiometerDisplayMin,potentiometerDisplayMax);
    currentValue = map(potentiometerValue,potentiometerValueMin,potentiometerValueMax,currentValueMin,currentValueMaxSetting[channel]);

    /* Find channel state */
    setSwitchState = digitalRead(setSwitchPin);
    if (setSwitchState == LOW) {
      channelStateValue[channel] = 2;
      if (!setMode[channel]) {
        setMode[channel] = true;
        setModeDeadbandExceeded[channel] = false;
        setModeInitialValues[channel] = potentiometerValue;
      } else {
        setModeValueDifference = potentiometerValue - setModeInitialValues[channel];
        if (setModeValueDeadband < abs(setModeValueDifference)) {
          setModeDeadbandExceeded[channel] = true;
          EEPROM_currentValueMaxSettingSaved[channel] = false;
        }
        if (setModeDeadbandExceeded[channel]) {
          currentValueMaxSetting[channel] = map(potentiometerValue,potentiometerValueMin,potentiometerValueMax,currentValueMin,currentValueMax);
          /* Serial << "channel: " << channelNames[channel] << "potentiometerValue: " << _DEC(potentiometerValue) << "potentiometerValueMin: " << _DEC(potentiometerValueMin) <<  "potentiometerValueMax: " << _DEC(potentiometerValueMax) <<  "currentValueMin: " << _DEC(currentValueMin) << "currentValueMax: " << _DEC(currentValueMax); */
        }
      }
    } else {
      if (setMode[channel]) {
        setMode[channel] = false;
        if (!EEPROM_currentValueMaxSettingSaved[channel]) {
          EEPROM_currentValueMaxSettingSaved[channel] = true;
          EEPROM_currentValueMaxSetting[channel] = map(currentValueMaxSetting[channel],currentValueMin,currentValueMax,EEPROM_currentValueMin,EEPROM_currentValueMax);
          EEPROM.write(EEPROMAddress_CurrentValueMaxSetting[channel],EEPROM_currentValueMaxSetting[channel]);
        }
      }

      // read the state of the On/Off switch
      channelSwitchState = digitalRead(channelSwitchPins[channel]);
      if (channelSwitchState == HIGH) {
        channelStateValue[channel] = 1;
      } else {
        channelStateValue[channel] = 0;
      }
    }
    channelStateName = channelStateNames[channelStateValue[channel]];

    if (channelStateValue[channel] == 0) {
      digiPotValue = lookup.getValue(currentValue);
    } else {
      digiPotValue = digiPotValueMin;
      currentValue = currentValueMin;
    }
    digiPot.setWiper(channel,digiPotValue);

    if (updateLCD) {
      lcd.setPos(5,5+12*(channel+1));
      snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],channelStateName,currentValue,currentValueMaxSetting[channel],potentiometerDisplay);
      lcd.print(msg);
    }
  }
  Serial << endl;
  updateLCD = false;
}
