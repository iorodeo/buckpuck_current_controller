// ----------------------------------------------------------------------------
// channel.h
//
// Object to control each channel of the current controller.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------

#ifndef CHANNEL_H_
#define CHANNEL_H_

#include "ioPin.h"

class Channel {
 public:
  enum modes {ON_MODE,OFF_MODE,SET_MODE,CC_MODE};

  Channel();
  Channel(IOPin onOffSwitch, IOPin potentiometer, IOPin relayEnable, int EEPROMAddress);

  void setMode(modes mode);
  /* modes getMode(); */
  /* void setCurrentValue(int currentValue); */
  /* int getCurrentValue(); */
  /* void setCurrentLimit(int currentLimit); */
  /* int getCurrentLimit(); */
  /* int getPotentiometerValue(); */
  /* byte getOnOffSwitchValue(); */

 private:
  modes mode;
};

#endif // CHANNEL_H



