// ----------------------------------------------------------------------------
// ioPin.h
//
// Object to control each IO pin of the current controller,
// digital or analog, input or output, internal or external.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "ioPin.h"
#include <Streaming.h>


//---------- constructor ----------------------------------------------------
// IOPin::IOPin() {
// }

IOPin::IOPin(int pinNumber, locations location, types type, int direction, MCP23SXX & extDigital, AD57X4R & extAnalogOutput):
  pinNumber(pinNumber), location(location), type(type), direction(direction), extDigital(extDigital), extAnalogOutput(extAnalogOutput)
{
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// IOPin::init
//
// Initialize the IOPin
// ----------------------------------------------------------------------------
void IOPin::init() {
  if (direction == INPUT) {
    if (type == DIGITAL_PIN) {
      if (location == INTERNAL_PIN) {
        pinMode(pinNumber,INPUT);
      } else {
        SPI.setDataMode(SPI_MODE0);
        extDigital.pinMode(pinNumber,INPUT);
      }
    }
  } else {
    if (type == DIGITAL_PIN) {
      if (location == INTERNAL_PIN) {
        pinMode(pinNumber,OUTPUT);
      } else {
        SPI.setDataMode(SPI_MODE0);
        extDigital.pinMode(pinNumber,OUTPUT);
      }
    }
  }
}

// ----------------------------------------------------------------------------
// IOPin::read
//
// Return the value of the IOPin
// ----------------------------------------------------------------------------
int IOPin::read() {
  int pinValue;
  // Serial << "read from pinNumber " << pinNumber << endl;
  if (direction == INPUT) {
    // Serial << "direction = INPUT" << endl;
    if (type == DIGITAL_PIN) {
      // Serial << "type = DIGITAL_PIN" << endl;
      if (location == INTERNAL_PIN) {
        // Serial << "location = INTERNAL_PIN" << endl;
        return digitalRead(pinNumber);
      } else {
        // Serial << "location = EXTERNAL_PIN" << endl;
        SPI.setDataMode(SPI_MODE0);
        return extDigital.digitalRead(pinNumber);
      }
    } else {
      // Serial << "type = ANALOG_PIN" << endl;
      if (location == INTERNAL_PIN) {
        // Serial << "location = INTERNAL_PIN" << endl;
        return analogRead(pinNumber);
      } else {
        // Serial << "location = EXTERNAL_PIN" << endl;
        return 0;
      }
    }
  } else {
    // Serial << "direction = OUTPUT" << endl;
    return 0;
  }
}

// ----------------------------------------------------------------------------
// IOPin::write
//
// Write the value to the IOPin
// ----------------------------------------------------------------------------
void IOPin::write(unsigned int value) {
  if (direction == OUTPUT) {
    if (type == DIGITAL_PIN) {
      if (location == INTERNAL_PIN) {
        digitalWrite(pinNumber,value);
      } else {
        SPI.setDataMode(SPI_MODE0);
        extDigital.digitalWrite(pinNumber,value);
      }
    } else {
      if (location == EXTERNAL_PIN) {
        SPI.setDataMode(SPI_MODE2);
        extAnalogOutput.analogWrite(pinNumber,value);
      }
    }
  }
}

// ----------------------------------------------------------------------------
// IOPin::enablePullup
//
// Enable the IOPin pullup
// ----------------------------------------------------------------------------
void IOPin::enablePullup() {
  if (direction == INPUT) {
    if (type == DIGITAL_PIN) {
      if (location == INTERNAL_PIN) {
        digitalWrite(pinNumber,HIGH);
      } else {
        SPI.setDataMode(SPI_MODE0);
        extDigital.digitalWrite(pinNumber,HIGH);
      }
    }
  }
}

// ----------------------------------------------------------------------------
// IOPin::enableInterrupt
//
// Enable the IOPin interrupt, compare to previous value
// ----------------------------------------------------------------------------
void IOPin::enableInterrupt() {
  if (direction == INPUT) {
    if (type == DIGITAL_PIN) {
      if (location == EXTERNAL_PIN) {
        SPI.setDataMode(SPI_MODE0);
        extDigital.enableInterrupt(pinNumber);
      }
    }
  }
}

// ----------------------------------------------------------------------------
// IOPin::enableInterrupt
//
// Enable the IOPin interrupt, compare to previous value
// ----------------------------------------------------------------------------
void IOPin::enableInterrupt(bool defaultValue) {
  if (direction == INPUT) {
    if (type == DIGITAL_PIN) {
      if (location == EXTERNAL_PIN) {
        SPI.setDataMode(SPI_MODE0);
        extDigital.enableInterrupt(pinNumber,defaultValue);
      }
    }
  }
}

//------------------ private -----------------------------------------------
