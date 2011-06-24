#include <SoftwareSerial.h>
#include <Streaming.h>
#include "SerialLCD.h"
#include <SPI.h>
#include "mcp4261.h"
#include "DigiPot.h"

#define MSG_SIZE 20
#define DIGIPOT_CS 10

SoftwareSerial softSerial(8,9);
SerialLCD lcd(softSerial);

const int channelCount = 4;
char* channelNames[] = {"A","B","C","D"};
char* channelStateNames[] = {"ON ","OFF","SET"};
int channelStateValue = 1;
char* channelStateName = channelStateNames[channelStateValue];
byte channelSwitchPins[] = {7,6,5,4};
byte channelSwitchState = LOW;

int potentiometerValueMin = 0;
int potentiometerValueMax = 1023;
int potentiometerDisplayMin = 0;
int potentiometerDisplayMax = 100;
byte potentiometerPins[] = {A1,A3,A5,A7};
int potentiometerValue;
int potentiometerDisplay;

int currentValueMax[] = {1000,1000,1000,1000};
int currentSenseValueMin = 0;
int currentSenseValueMax = 1023;
byte currentSensePins[] = {A0,A2,A4,A6};
int currentSenseValueRaw;
int currentSenseDisplay;

/* int currentSenseValueFiltered; */
/* const int filterSamples = 13; */
/* int currentSenseSmoothArrays[channelCount][filterSamples];   // arrays for holding raw sensor values for sensors */

int brightnessValue;
int brightnessValueLow = 0;
int brightnessValueHigh = 50;
byte brightnessSwitchState = HIGH;
byte brightnessSwitchStatePrevious = HIGH;
byte brightnessState = LOW;
byte brightnessSwitchPin = 2;

int digiPotValue;
int digiPotValueMin = 256;
int digiPotValueMax = 0;
DigiPot digiPot = DigiPot(DIGIPOT_CS);

uint16_t cnt = 0;
char msg[MSG_SIZE];


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

  // initialize the channel switch pins as input and turn on pullup resistors
  for (int channel = 0; channel < channelCount; channel++) {
    pinMode(channelSwitchPins[channel], INPUT);
    digitalWrite(channelSwitchPins[channel], HIGH);
  }

  // initialize the brightness switch pin as input and turn on pullup resistor
  pinMode(brightnessSwitchPin, INPUT);
  digitalWrite(brightnessSwitchPin, HIGH);
}


void loop() {
  /* Clear screen every once in a while to remove potential artifacts */
  if (cnt < 100) {
    cnt++;
  }
  else {
    cnt = 0;
    /* lcd.clearScreen(); */
  }

  /* Check display button status */
  brightnessSwitchState = digitalRead(brightnessSwitchPin);
  Serial << "LOW = " << _DEC(LOW) << " brightnessSwitchState: " << _DEC(brightnessSwitchState) << " brightnessSwitchStatePrevious: " << _DEC(brightnessSwitchStatePrevious);
  if (brightnessSwitchState != brightnessSwitchStatePrevious) {
    Serial << " switched!!!! ";
    brightnessSwitchStatePrevious = brightnessSwitchState;
    if (brightnessSwitchState == LOW) {
      Serial << " SwitchLOW!! ";
      if (brightnessState == LOW) {
        Serial << " BrightnessLOW!! ";
        brightnessState = HIGH;
        brightnessValue = brightnessValueHigh;
      } else if (brightnessState == HIGH) {
        Serial << " BrightnessHIGH!! ";
        brightnessState = LOW;
        brightnessValue = brightnessValueLow;
      }
      lcd.setBrightness(brightnessValue);
    } else {
      Serial << " SwitchHIGH!! ";
    }
  }
  Serial << " brightnessState: " << _DEC(brightnessState) << " brightnessValue: " << _DEC(brightnessValue);

  /* Header row */
  lcd.setPos(5,5);
  snprintf(msg, MSG_SIZE, "        mA  MAX POT ");
  lcd.print(msg);


  for (int channel = 0; channel < channelCount; channel++) {
    // read the state of the On/Off switch
    channelSwitchState = digitalRead(channelSwitchPins[channel]);
    if (channelSwitchState == HIGH) {
      channelStateValue = 1;
    } else {
      channelStateValue = 0;
    }
    channelStateName = channelStateNames[channelStateValue];

    potentiometerValue = analogRead(potentiometerPins[channel]);
    potentiometerDisplay = map(potentiometerValue,potentiometerValueMin,potentiometerValueMax,potentiometerDisplayMin,potentiometerDisplayMax);
    Serial << channelNames[channel] << " pot: " << _DEC(potentiometerDisplay) << " channelSwitchState: " << _DEC(channelSwitchState);
    lcd.setPos(5,5+12*(channel+1));

    if (channelStateValue == 0){
      digiPotValue = map(potentiometerValue,potentiometerValueMin,potentiometerValueMax,digiPotValueMin,digiPotValueMax);
    } else {
      digiPotValue = digiPotValueMin;
    }
    digiPot.setWiper(channel,digiPotValue);


    currentSenseValueRaw = analogRead(currentSensePins[channel]);
    /* currentSenseValueFiltered = digitalSmooth(currentSenseValueRaw,currentSenseSmoothArrays[channel]); */
    currentSenseDisplay = map(currentSenseValueFiltered,currentSenseValueMin,currentSenseValueMax,0,currentValueMax[channel]);

    snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],channelStateName,currentSenseValueRaw,digiPotValue,potentiometerDisplay);
    lcd.print(msg);
  }
  /* brightnessValue = map(potentiometerValues[0],0,1024,0,100); */
  /* brightnessValue = 60; */
  /* lcd.setBrightness(brightnessValue); */
  Serial << endl;

  delay(50);
}

/* int digitalSmooth(int rawIn, int *sensSmoothArray){     // "int *sensSmoothArray" passes an array to the function - the asterisk indicates the array name is a pointer */
/*   int j, k, temp, top, bottom; */
/*   long total; */
/*   static int i; */
/*   // static int raw[filterSamples]; */
/*   static int sorted[filterSamples]; */
/*   boolean done; */

/*   i = (i + 1) % filterSamples;    // increment counter and roll over if necc. -  % (modulo operator) rolls over variable */
/*   sensSmoothArray[i] = rawIn;                 // input new data into the oldest slot */

/*   // Serial.print("raw = "); */

/*   for (j=0; j<filterSamples; j++){     // transfer data array into anther array for sorting and averaging */
/*     sorted[j] = sensSmoothArray[j]; */
/*   } */

/*   done = 0;                // flag to know when we're done sorting */
/*   while(done != 1){        // simple swap sort, sorts numbers from lowest to highest */
/*     done = 1; */
/*     for (j = 0; j < (filterSamples - 1); j++){ */
/*       if (sorted[j] > sorted[j + 1]){     // numbers are out of order - swap */
/*         temp = sorted[j + 1]; */
/*         sorted [j+1] =  sorted[j] ; */
/*         sorted [j] = temp; */
/*         done = 0; */
/*       } */
/*     } */
/*   } */

/*   /\* */
/*     for (j = 0; j < (filterSamples); j++){    // print the array to debug */
/*     Serial.print(sorted[j]); */
/*     Serial.print("   "); */
/*     } */
/*     Serial.println(); */
/*   *\/ */

/*   // throw out top and bottom 15% of samples - limit to throw out at least one from top and bottom */
/*   bottom = max(((filterSamples * 15)  / 100), 1); */
/*   top = min((((filterSamples * 85) / 100) + 1  ), (filterSamples - 1));   // the + 1 is to make up for asymmetry caused by integer rounding */
/*   k = 0; */
/*   total = 0; */
/*   for ( j = bottom; j< top; j++){ */
/*     total += sorted[j];  // total remaining indices */
/*     k++; */
/*     // Serial.print(sorted[j]); */
/*     // Serial.print("   "); */
/*   } */

/*   //  Serial.println(); */
/*   //  Serial.print("average = "); */
/*   //  Serial.println(total/k); */
/*   return total / k;    // divide by number of samples */
/* } */
