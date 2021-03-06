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
#include "channel.h"

class Display {
 public:
  Display(Print &port);

  void init();
  void clearScreen();
  void setLightLow();
  void setLightHigh();
  void setLightLevel(byte level);
  void update(Channel::modes channelModes[], int currentValues[], int currentValueMaxSettings[], int updateValues[]);
  void computerControlMsg();

 private:
  Print * port;
  SerialLCD lcd;
  char msg[MSG_SIZE];
  int updateValue;
  int percentDisplay;
  char* channelNames[CHANNEL_COUNT];
  char* modeString;

  char* getModeString(Channel::modes mode);
};

#endif // DISPLAY_H
