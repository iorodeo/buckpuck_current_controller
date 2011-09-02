// ----------------------------------------------------------------------------
// channel.h
//
// Object to control each channel of the current controller.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------

#ifndef CHANNEL_H_
#define CHANNEL_H_

class Channel {
 public:
  enum modes {ON,OFF,SET,CC};

  Channel(char* name, IO onOffSwitch, IO potentiometer, IO relayEnable, int EEPROMAddress);

  void setMode(modes mode);
  modes getMode();
  void setCurrentValue(int currentValue);
  int getCurrentValue();
  void setCurrentLimit(int currentLimit);
  int getCurrentLimit();
  int getPotentiometerValue();
  byte getOnOffSwitchValue();
  void setName(char* name);
  char* getName();

 private:
  modes mode;
  char* name;
};

#endif // CHANNEL_H



