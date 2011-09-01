// ----------------------------------------------------------------------------
// display.h
//
// Object to control the current controller display.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "display.h"
#include "Streaming.h"

//---------- constructor ----------------------------------------------------

DISPLAY::DISPLAY(byte rx, byte tx) {
  softSerial = SoftwareSerial(rx,tx);
  softSerial.begin(115200);
  lcd = SerialLCD(softSerial);
  clearScreen();
  setLightLow();
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// DISPLAY::clearScreen
//
// Clears the display screen.
// ----------------------------------------------------------------------------
void DISPLAY::clearScreen() {
  lcd.clearScreen();
}

// ----------------------------------------------------------------------------
// DISPLAY::setLightLow
//
// Set the display light to the low value.
// ----------------------------------------------------------------------------
void DISPLAY::setLightLow() {
  lcd.setBrightness(lightValueLow);
}

// ----------------------------------------------------------------------------
// DISPLAY::setLightHigh
//
// Set the display light to the high value.
// ----------------------------------------------------------------------------
void DISPLAY::setLightHigh() {
  lcd.setBrightness(lightValueHigh);
}

//------------------ private -----------------------------------------------
