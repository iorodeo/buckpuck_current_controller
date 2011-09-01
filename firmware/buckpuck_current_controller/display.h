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
#include "SoftwareSerial.h"
#include "SerialLCD.h"

class DISPLAY {
 public:
  DISPLAY(byte rx, byte tx);

  void clearScreen();
  void setLightLow();
  void setLightHigh();

 private:
  SoftwareSerial softSerial;
  SerialLCD lcd;
  const int lightValueLow = 0;
  const int lightValueHigh = 50;
}

#endif // DISPLAY_H
