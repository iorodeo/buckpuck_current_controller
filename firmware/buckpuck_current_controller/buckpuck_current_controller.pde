#include "WProgram.h"
#include <Streaming.h>
#include <SoftwareSerial.h>
#include "SerialLCD.h"
#include "TimerOne.h"
#include "ControllerDefines.h"
#include "display.h"

SoftwareSerial softSerial(DISPLAY_RX,DISPLAY_TX);
Display display(softSerial);

char * channelNames[] = {"A","B","C","D"};
char* channelModes[CHANNEL_COUNT];
unsigned int currentValues[CHANNEL_COUNT];
unsigned int currentValueMaxSettings[CHANNEL_COUNT];
unsigned int potentiometerValues[CHANNEL_COUNT];

unsigned long clearDisplayPeriodCount = 0;
void updateDisplayCallback() {
  display.update(channelNames,channelModes,currentValues,currentValueMaxSettings,potentiometerValues);
  clearDisplayPeriodCount++;
  if (CLEAR_DISPLAY_PERIOD_RATIO <= clearDisplayPeriodCount) {
    clearDisplayPeriodCount = 0;
    display.clearScreen();
  }
}

void setup() {
  softSerial.begin(115200);
  display.init();

  Timer1.initialize(1000);
  Timer1.attachInterrupt(updateDisplayCallback,UPDATE_DISPLAY_PERIOD);
}

void loop() {
  for (int channel = 0; channel < CHANNEL_COUNT; channel++) {
    if (potentiometerValues[channel] < 1111) {
      potentiometerValues[channel] = potentiometerValues[channel] + channel;
    } else {
      potentiometerValues[channel] = 0;
    }
  }
  delay(100);
}
