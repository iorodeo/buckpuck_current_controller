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
  channelNames[0] = "A";
  channelNames[1] = "B";
  channelNames[2] = "C";
  channelNames[3] = "D";
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
// Display::setLightLevel
//
// Set the display light to the level value.
// ----------------------------------------------------------------------------
void Display::setLightLevel(byte level) {
  if (level == HIGH) {
    setLightHigh();
  } else {
    setLightLow();
  }
}

// ----------------------------------------------------------------------------
// Display::update
//
// Updates the display.
// ----------------------------------------------------------------------------
void Display::update(Channel::modes channelModes[], int currentValues[], int currentValueMaxSettings[], int updateValues[]) {
  // Write header
  lcd.setPos(5,5);
  snprintf(msg, MSG_SIZE, "        mA  MAX o/o ");
  lcd.print(msg);

  for (int channel = 0; channel < CHANNEL_COUNT; channel++) {
    modeString = getModeString(channelModes[channel]);
    updateValue = updateValues[channel];
    percentDisplay = map(updateValue,UPDATE_VALUE_MIN,UPDATE_VALUE_MAX,PERCENT_DISPLAY_MIN,PERCENT_DISPLAY_MAX);
    lcd.setPos(5,5+12*(channel+1));
    snprintf(msg, MSG_SIZE, "%s %s %4d %4d %3d ", channelNames[channel],modeString,currentValues[channel],currentValueMaxSettings[channel],percentDisplay);
    lcd.print(msg);
  }
}

//------------------ private -----------------------------------------------
// ----------------------------------------------------------------------------
// Display::getModeString
//
// Returns the displayable string for each mode.
// ----------------------------------------------------------------------------
char* Display::getModeString(Channel::modes mode) {
  if (mode == Channel::ON_MODE) {
    return "ON ";
  } else if (mode == Channel::OFF_MODE) {
    return "OFF";
  } else if (mode == Channel::SET_MODE) {
    return "SET";
  } else if (mode == Channel::CC_MODE) {
    return "CC ";
  } else if (mode == Channel::BNC_MODE) {
    return "BNC";
  }
}

