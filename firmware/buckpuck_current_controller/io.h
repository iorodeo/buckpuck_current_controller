// ----------------------------------------------------------------------------
// io.h
//
// Object to control each IO pin of the current controller,
// digital or analog, input or output, internal or external.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------

#ifndef IO_H_
#define IO_H_

class IO {
 public:
  enum modes {ON,OFF,SET};

  IO(char* name, IO onOffSwitch, IO potentiometer, IO relayEnable, int EEPROMAddress);

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

#endif // IO_H



