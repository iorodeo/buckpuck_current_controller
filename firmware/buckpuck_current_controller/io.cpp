// ----------------------------------------------------------------------------
// io.h
//
// Object to control each IO pin of the current controller,
// digital or analog, input or output, internal or external.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "WProgram.h"
#include <SPI.h>
#include <EEPROM.h>
#include <Streaming.h>

//---------- constructor ----------------------------------------------------

IO::IO(char* name, IO onOffSwitch, IO potentiometer, IO relayEnable, int EEPROMAddress) {
  setName(name);
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// IO::setMode
//
// Set the io mode.
// ----------------------------------------------------------------------------
void IO::setMode(modes mode) {
  this->mode = mode;
}

// ----------------------------------------------------------------------------
// IO::getMode
//
// Get the io mode.
// ----------------------------------------------------------------------------
modes IO::getMode() {
  return mode;
}

// ----------------------------------------------------------------------------
// IO::setName
//
// Set the io name.
// ----------------------------------------------------------------------------
void IO::setName(char* name) {
  this->name = name;
}

// ----------------------------------------------------------------------------
// IO::getName
//
// Get the io name.
// ----------------------------------------------------------------------------
char* IO::getName() {
  return name;
}

//------------------ private -----------------------------------------------

// ----------------------------------------------------------------------------
// IO::setupCS
//
// Set chip select pin for SPI Bus, and start high (disabled)
// ----------------------------------------------------------------------------
void IO::setupCS(int csPin) {
  csInvertFlag = false;
  ::pinMode(csPin,OUTPUT);
  ::digitalWrite(csPin,HIGH);
  this->csPin = csPin;
}
