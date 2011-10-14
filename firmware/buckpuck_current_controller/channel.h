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
  enum modes {ON_MODE,OFF_MODE,SET_MODE,CC_MODE,BNC_MODE};

  /* Channel(); */
  Channel(IOPin & onOffSwitch, IOPin & relayEnable, IOPin & potentiometer, IOPin & dac, IOPin & bnc, int eepromAddressCurrentLimit, int eepromAddressBncMode);

  void setMode(modes mode);
  Channel::modes getMode();
  void setCurrentValue(int currentValue);
  int getCurrentValue();
  void setCurrentLimit(int currentLimit);
  int getCurrentLimit();
  int getPotentiometerValue();
  int getBncValue();
  byte getOnOffSwitchValue();
  void update(int updateValue);
  void setSavedBncMode(bool bncMode);
  bool getSavedBncMode();

 private:
  modes mode;
  IOPin & onOffSwitch;
  IOPin & relayEnable;
  IOPin & potentiometer;
  IOPin & dac;
  IOPin & bnc;
  int eepromAddressCurrentLimit;
  int eepromAddressBncMode;

  int currentValue;
  int currentLimit;
  int updateValue;
  int initialSetValue;
  bool currentLimitNeedsSaving;
  bool bncMode;
  bool initialized;

  void setModeOn();
  void setModeOff();
  void setModeSet();
  void setModeCC();
  void setModeBnc();
  void enableRelay();
  void disableRelay();
  void setDacValue();
  void setDacOff();
  void setSavedCurrentLimit();
  int getSavedCurrentLimit();
};

#endif // CHANNEL_H



