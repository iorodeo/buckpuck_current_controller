// ----------------------------------------------------------------------------
// display.h
//
// Object to control the current controller display.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#ifndef DISPLAY_H_
#define DISPLAY_H_

#include "WProgram.h"
#include "SerialLCD.h"
#include "ControllerDefines.h"

class Display {
 public:
  Display(Print &port);

  void init();
  void clearScreen();
  void setLightLow();
  void setLightHigh();
  void update(char * channelNames[], char * channelModes[], unsigned int currentValues[], unsigned int currentValueMaxSettings[], unsigned int potentiometerValues[]);

 private:
  Print * port;
  SerialLCD lcd;
  char msg[MSG_SIZE];
  unsigned int potentiometerValue;
  unsigned int potentiometerDisplay;
};

#endif // DISPLAY_H
