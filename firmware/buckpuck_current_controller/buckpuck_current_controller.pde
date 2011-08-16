#include <SoftwareSerial.h>
#include <Streaming.h>
#include "SerialLCD.h"
#include <SPI.h>
#include "ad57x4r.h"
#include <mcp23sxx.h>
#include <EEPROM.h>

#define MSG_SIZE 20
#define DAC_CS 10
#define IO_CS  3

SoftwareSerial softSerial(8,9);
SerialLCD lcd(softSerial);

const byte ON = 0;
const byte OFF = 1;
const int channelCount = 4;
char* channelNames[] = {"A","B","C","D"};
char* channelStateNames[] = {"ON ","OFF","SET"};
byte channelStateValue[] = {1,1,1,1};
char* channelStateName = channelStateNames[channelStateValue[0]];
const byte channelEnablePins[] = {7,6,5,4};
const byte channelSwitchPins[] = {0,1,2,3};
byte channelSwitchState = LOW;

const int potentiometerValueMin = 0;
const int potentiometerValueMax = 1023;
const int potentiometerDisplayMin = 0;
const int potentiometerDisplayMax = 100;
const byte potentiometerPins[] = {A0,A1,A2,A3};
int potentiometerValue;
int potentiometerDisplay;

const int currentValueMin = 0;
const int currentValueMax = 1000;
int currentValue;
int currentValueMaxSetting[] = {currentValueMax,currentValueMax,currentValueMax,currentValueMax};
int currentValueMaxSettingValue;

int lightValue;
const int lightValueLow = 0;
const int lightValueHigh = 50;
byte lightSwitchState = HIGH;
byte lightSwitchStatePrevious = HIGH;
byte lightState = LOW;
const byte lightSwitchPin = 5;

/* Measured current vs. DAC values */
const unsigned int dacValueMin = 3205;
const unsigned int dacValueMax = 1067;
const unsigned int dacValueOff = 4095;
unsigned int dacValue;
/* External DAC */
AD57X4R dac = AD57X4R(DAC_CS);
AD57X4R::channels dacChannels[] = {AD57X4R::A,AD57X4R::B,AD57X4R::C,AD57X4R::D};

/* External IO */
MCP23SXX io = MCP23SXX(IO_CS);
byte ioPortValues;

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

const byte setSwitchPin = 4;
byte setSwitchState = HIGH;
bool setMode[] = {false,false,false,false};
bool setModeDeadbandExceeded[] = {false,false,false,false};
int setModeInitialValues[channelCount];
const int setModeValueDeadband = 10;
int setModeValueDifference;


void setup() {
  // Setup SPI communications
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV8);
  SPI.begin();

  // Initialize DAC
  SPI.setDataMode(SPI_MODE2);
  dac.init(AD57X4R::AD5724R, AD57X4R::UNIPOLAR_5V, AD57X4R::ALL);
  dac.analogWrite(AD57X4R::ALL,dacValueMax);

  // Initialize IO
  SPI.setDataMode(SPI_MODE0);
  io.init(MCP23SXX::MCP23S08);

  // initialize channel enable pins and set LOW
  for (int channel = 0; channel < channelCount; channel++) {
    pinMode(channelEnablePins[channel], OUTPUT);
    digitalWrite(channelEnablePins[channel], LOW);
  }

  // initialize the channel switch pins as input and turn on pullup resistors
  for (int channel = 0; channel < channelCount; channel++) {
    io.pinMode(channelSwitchPins[channel], INPUT);
    io.digitalWrite(channelSwitchPins[channel], HIGH);
  }

  // initialize the light switch pin as input and turn on pullup resistor
  io.pinMode(lightSwitchPin, INPUT);
  io.digitalWrite(lightSwitchPin, HIGH);

  // initialize the set switch pin as input and turn on pullup resistor
  io.pinMode(setSwitchPin, INPUT);
  io.digitalWrite(setSwitchPin, HIGH);

  /* Initalize currentValueMaxSetting */
  for (int channel = 0; channel < channelCount; channel++) {
    EEPROM_currentValueMaxSettingValue = EEPROM.read(EEPROMAddress_CurrentValueMaxSetting[channel]);
    currentValueMaxSettingValue = map(EEPROM_currentValueMaxSettingValue,EEPROM_currentValueMin,EEPROM_currentValueMax,currentValueMin,currentValueMax);
    currentValueMaxSetting[channel] = currentValueMaxSettingValue;
  }

  Serial.begin(9600);
  softSerial.begin(115200);
  delay(2500);
  lcd.clearScreen();
  if (lightState == LOW) {
    lightValue = lightValueLow;
  } else if (lightState == HIGH) {
    lightValue = lightValueHigh;
  }
  lcd.setBrightness(lightValue);

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
  SPI.setDataMode(SPI_MODE0);
  lightSwitchState = io.digitalRead(lightSwitchPin);
  if (lightSwitchState != lightSwitchStatePrevious) {
    lightSwitchStatePrevious = lightSwitchState;
    if (lightSwitchState == LOW) {
      if (lightState == LOW) {
        lightState = HIGH;
        lightValue = lightValueHigh;
      } else if (lightState == HIGH) {
        lightState = LOW;
        lightValue = lightValueLow;
      }
      lcd.setBrightness(lightValue);
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
    SPI.setDataMode(SPI_MODE0);
    setSwitchState = io.digitalRead(setSwitchPin);
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
      SPI.setDataMode(SPI_MODE0);
      channelSwitchState = io.digitalRead(channelSwitchPins[channel]);
      if (channelSwitchState == HIGH) {
        channelStateValue[channel] = OFF;
        /* digitalWrite(channelEnablePins[channel],LOW); */
      } else {
        channelStateValue[channel] = ON;
        /* digitalWrite(channelEnablePins[channel],HIGH); */
      }
    }
    channelStateName = channelStateNames[channelStateValue[channel]];

    if (channelStateValue[channel] == ON) {
      /* digiPotValue = lookup.getValue(currentValue); */
      dacValue = map(currentValue,currentValueMin,currentValueMax,dacValueMin,dacValueMax);
    } else {
      dacValue = dacValueOff;
      currentValue = currentValueMin;
    }
    SPI.setDataMode(SPI_MODE2);
    dac.analogWrite(dacChannels[channel],dacValue);

    if (channelStateValue[channel] == OFF) {
      digitalWrite(channelEnablePins[channel],LOW);
    } else {
      digitalWrite(channelEnablePins[channel],HIGH);
    }

    if (updateLCD) {
      lcd.setPos(5,5+12*(channel+1));
      snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],channelStateName,currentValue,currentValueMaxSetting[channel],potentiometerDisplay);
      /* snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],channelStateName,currentValue,dacValue,potentiometerDisplay); */
      lcd.print(msg);
    }
  }
  Serial << endl;
  updateLCD = false;
}
