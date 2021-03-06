// ----------------------------------------------------------------------------
// ioPin.h
//
// Object to control each IO pin of the current controller,
// digital or analog, input or output, internal or external.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------

#ifndef IOPIN_H_
#define IOPIN_H_

#include "WProgram.h"
#include <SPI.h>
#include "ad57x4r.h"
#include "mcp23sxx.h"

class IOPin {
 public:
  enum locations {INTERNAL_PIN,EXTERNAL_PIN};
  enum types {DIGITAL_PIN,ANALOG_PIN};
  /* IOPin(); */
  IOPin(int pinNumber, locations location, types type, int direction, MCP23SXX & extDigital, AD57X4R & extAnalogOutput);

  void init();
  int read();
  void write(unsigned int value);
  void enablePullup();
  void enableInterrupt();
  void enableInterrupt(bool defaultValue);

 private:
  int pinNumber;
  locations location;
  types type;
  int direction;
  MCP23SXX & extDigital;
  AD57X4R & extAnalogOutput;
};

#endif // IOPIN_H



