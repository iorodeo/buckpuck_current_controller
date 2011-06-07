#include <SoftwareSerial.h>
#include <Streaming.h>
#include "SerialLCD.h"

#define MSG_SIZE 20

SoftwareSerial softSerial(8,9);
SerialLCD lcd(softSerial);

byte potentiometerValueMax = 1023;
byte potentiometerPins[] = {A1,A3,A5,A7};
byte onOffSwitchPins[] = {7,4,10,2};
byte numberOfChannels = 4;
char* channelNames[] = {"A","B","C","D"};
char* channelStateNames[] = {"OFF","ON ","SET"};
/* char* channelStates[] = {"ON ","OFF","SET"}; */
byte currentMax[] = {1000,1000,1000,1000};
byte analogOutputPins[] = {6,5,11,3};
byte currentSensorPins[] = {A0,A2,A4,A6};

uint16_t cnt = 0;
int brightness;
char msg[MSG_SIZE];
int potentiometerValue;
int potentiometerValueDisplay;
int onOffSwitchValue;
char* channelStateName;
int analogOutputValue;
int analogOutputValueDisplay;
int currentSensorValue;
int currentSensorValueDisplay;

void setup() {
  Serial.begin(9600);
  softSerial.begin(115200);
  delay(2500);
  lcd.clearScreen();
  brightness = 50;
  lcd.setBrightness(brightness);

  // initialize the On/Off switch pins as input:
  for (int channelNumber = 0; channelNumber < numberOfChannels; channelNumber++) {
    pinMode(onOffSwitchPins[channelNumber], INPUT);
    digitalWrite(onOffSwitchPins[channelNumber], HIGH);
  }

  /* Set PWM output frequency to 62500 for timer 0 (pins 5 and 6) */
  TCCR0B = TCCR0B & 0b11111000 | 0x01;
  /* Set PWM output frequency to 62500 for timer 2 (pins 3 and 11) */
  TCCR2B = TCCR2B & 0b11111000 | 0x01;
}


void loop() {
  if (cnt < 60000) {
    cnt++;
  } 
  else {
    cnt = 0;
    /* Clear screen every once in a while to remove potential artifacts */
    lcd.clearScreen();
  }
 
  /* Header */
  lcd.setPos(5,5);
  snprintf(msg, MSG_SIZE, "        mA  MAX POT ");
  lcd.print(msg);
  /* lcd.drawLine(1,13,126,13,1); */

  for (int channelNumber = 0; channelNumber < numberOfChannels; channelNumber++) {
    potentiometerValue = analogRead(potentiometerPins[channelNumber]);
    potentiometerValueDisplay = map(potentiometerValue,0,1023,0,100);

    onOffSwitchValue = digitalRead(onOffSwitchPins[channelNumber]);
    if (onOffSwitchValue == HIGH) {
      digitalWrite(analogOutputPins[channelNumber],HIGH);
      channelStateName = channelStateNames[0];
    }
    else {
      channelStateName = channelStateNames[1];
      analogOutputValue = map(potentiometerValue,0,1023,0,255);
      analogOutputValueDisplay = map(potentiometerValue,0,1023,0,1000);
      analogWrite(analogOutputPins[channelNumber], analogOutputValue);
    }

    // read the value from the current sensors
    currentSensorValue = analogRead(currentSensorPins[channelNumber]);
    currentSensorValueDisplay = map(currentSensorValue,0,1023,0,1000);

    Serial << channelNames[channelNumber] << ", potentiometerValue: " << _DEC(potentiometerValue) << ", currentSensorValue: " << _DEC(currentSensorValue) << " ";
    lcd.setPos(5,5+12*(channelNumber+1));
    snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channelNumber], channelStateName, currentSensorValueDisplay, 1000, potentiometerValueDisplay);
    lcd.print(msg);
  }
  /* brightness = map(potentiometerValues[0],0,1024,0,100); */
  /* brightness = 60; */
  /* lcd.setBrightness(brightness); */
  Serial << endl;

  delay(6400);
}
