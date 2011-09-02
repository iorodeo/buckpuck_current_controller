// ----------------------------------------------------------------------------
// display.h
//
// Object to control the current controller display.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "display.h"
#include <Streaming.h>

//---------- constructor ----------------------------------------------------

Display::Display(Print &port) {
  lcd = SerialLCD(port);
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// Display::init
//
// Initialize softSerial and the lcd.
// ----------------------------------------------------------------------------
void Display::init() {
  clearScreen();
  setLightLow();
}

// ----------------------------------------------------------------------------
// Display::clearScreen
//
// Clears the display screen.
// ----------------------------------------------------------------------------
void Display::clearScreen() {
  lcd.clearScreen();
}

// ----------------------------------------------------------------------------
// Display::setLightLow
//
// Set the display light to the low value.
// ----------------------------------------------------------------------------
void Display::setLightLow() {
  lcd.setBrightness(LIGHT_VALUE_LOW);
}

// ----------------------------------------------------------------------------
// Display::setLightHigh
//
// Set the display light to the high value.
// ----------------------------------------------------------------------------
void Display::setLightHigh() {
  lcd.setBrightness(LIGHT_VALUE_HIGH);
}

// ----------------------------------------------------------------------------
// Display::update
//
// Updates the display.
// ----------------------------------------------------------------------------
void Display::update(char * channelNames[], char * channelModes[], unsigned int currentValues[], unsigned int currentValueMaxSettings[], unsigned int potentiometerValues[]) {
  // Write header
  lcd.setPos(5,5);
  snprintf(msg, MSG_SIZE, "        mA  MAX POT ");
  lcd.print(msg);

  for (int channel = 0; channel < CHANNEL_COUNT; channel++) {
    potentiometerValue = potentiometerValues[channel];
    potentiometerDisplay = map(potentiometerValue,POTENTIOMETER_VALUE_MIN,POTENTIOMETER_VALUE_MAX,POTENTIOMETER_DISPLAY_MIN,POTENTIOMETER_DISPLAY_MAX);
    lcd.setPos(5,5+12*(channel+1));
    snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],channelModes[channel],currentValues[channel],currentValueMaxSettings[channel],potentiometerDisplay);
    lcd.print(msg);
  }
}

//------------------ private -----------------------------------------------
