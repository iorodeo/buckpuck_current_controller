// ----------------------------------------------------------------------------
// ioPin.h
//
// Object to control each IO pin of the current controller,
// digital or analog, input or output, internal or external.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "ioPin.h"


//---------- constructor ----------------------------------------------------
IOPin::IOPin() {
}

IOPin::IOPin(int pinNumber, types type, int direction) {
  this->pinNumber = pinNumber;
  this->location = INTERNAL_PIN;
  this->type = type;
  this->direction = direction;
}

IOPin::IOPin(int pinNumber, int direction, MCP23SXX &extDigital) {
  this->pinNumber = pinNumber;
  this->location = EXTERNAL_PIN;
  this->type = DIGITAL_PIN;
  this->direction = direction;
  this->extDigital = extDigital;
}

IOPin::IOPin(AD57X4R::channels channel, AD57X4R &extAnalogOutput) {
  this->channel = channel;
  this->location = EXTERNAL_PIN;
  this->type = ANALOG_PIN;
  this->direction = OUTPUT;
  this->extAnalogOutput = extAnalogOutput;
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
        extDigital.pinMode(pinNumber,INPUT);
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
  if (direction == INPUT) {
    if (type == DIGITAL_PIN) {
      if (location == INTERNAL_PIN) {
        return digitalRead(pinNumber);
      } else {
        return extDigital.digitalRead(pinNumber);
      }
    } else {
      if (location == INTERNAL_PIN) {
        return analogRead(pinNumber);
      } else {
        return 0;
      }
    }
  } else {
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
        extDigital.digitalWrite(pinNumber,value);
      }
    } else {
      if (location == EXTERNAL_PIN) {
        extAnalogOutput.analogWrite(channel,value);
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
        extDigital.enableInterrupt(pinNumber,defaultValue);
      }
    }
  }
}

//------------------ private -----------------------------------------------
