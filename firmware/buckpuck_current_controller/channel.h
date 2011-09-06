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
#include <EEPROM.h>
#include "ControllerDefines.h"

class Channel {
 public:
  enum modes {ON_MODE,OFF_MODE,SET_MODE,CC_MODE};

  /* Channel(); */
  Channel(IOPin & onOffSwitch, IOPin & relayEnable, IOPin & potentiometer, IOPin & dac, int EEPROMAddress);

  void setMode(modes mode);
  Channel::modes getMode();
  void setCurrentValue(int currentValue);
  int getCurrentValue();
  void setCurrentLimit(int currentLimit);
  int getCurrentLimit();
  int getPotentiometerValue();
  byte getOnOffSwitchValue();
  void update(int updateValue);

 private:
  modes mode;
  IOPin & onOffSwitch;
  IOPin & relayEnable;
  IOPin & potentiometer;
  IOPin & dac;
  int EEPROMAddress;

  int currentValue;
  int currentLimit;
  int updateValue;
  int initialSetValue;
  bool currentLimitNeedsSaving;

  void setModeOn();
  void setModeOff();
  void setModeSet();
  void setModeCC();
  void enableRelay();
  void disableRelay();
  void setDacValue();
  void setDacOff();
  void setSavedCurrentLimit();
  void getSavedCurrentLimit();
};

#endif // CHANNEL_H



