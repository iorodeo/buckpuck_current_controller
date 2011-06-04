#include <SoftwareSerial.h>
#include <Streaming.h>
#include "SerialLCD.h"

#define MSG_SIZE 20

SoftwareSerial softSerial(8,9);
SerialLCD lcd(softSerial);

byte potentiometerValueMax = 1023;
byte potentiometerPins[] = {A1,A3,A5,A7};
char* channelNames[] = {"A","B","C","D"};
char* channelStateNames[] = {"ON ","OFF","SET"};
byte currentMax[] = {1000,1000,1000,1000};

uint16_t cnt = 0;
int brightness;
char msg[MSG_SIZE];
int potentiometerValue;
int potentiometerPercent;

void setup() {
  Serial.begin(9600);
  softSerial.begin(115200);
  delay(2500);
  lcd.clearScreen();
  brightness = 50;
  lcd.setBrightness(brightness);
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
 
  /* Header row */
  lcd.setPos(5,5);
  snprintf(msg, MSG_SIZE, "        mA  MAX POT ");
  lcd.print(msg);

  for (int i = 0; i < 4; i++) {
    potentiometerValue = analogRead(potentiometerPins[i]);
    potentiometerPercent = map(potentiometerValue,0,1023,0,100);
    Serial << channelNames[i] << " " << _DEC(potentiometerValue) << " " << _DEC(potentiometerPercent) << " ";
    lcd.setPos(5,5+12*(i+1));
    snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[i], channelStateNames[1],1000,1000,potentiometerPercent);
    lcd.print(msg);
  }
  /* brightness = map(potentiometerValues[0],0,1024,0,100); */
  /* brightness = 60; */
  /* lcd.setBrightness(brightness); */
  Serial << endl;
  delay(100);
}
