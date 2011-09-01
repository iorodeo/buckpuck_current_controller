// ----------------------------------------------------------------------------
// channel.cpp
//
// Object to control each channel of the current controller.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "WProgram.h"
#include <SPI.h>
#include <EEPROM.h>
#include <Streaming.h>

//---------- constructor ----------------------------------------------------

CHANNEL::CHANNEL(char* name, IO onOffSwitch, IO potentiometer, IO relayEnable, int EEPROMAddress) {
  setName(name);
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// CHANNEL::setMode
//
// Set the channel mode.
// ----------------------------------------------------------------------------
void CHANNEL::setMode(modes mode) {
  this->mode = mode;
}

// ----------------------------------------------------------------------------
// CHANNEL::getMode
//
// Get the channel mode.
// ----------------------------------------------------------------------------
modes CHANNEL::getMode() {
  return mode;
}

// ----------------------------------------------------------------------------
// CHANNEL::setName
//
// Set the channel name.
// ----------------------------------------------------------------------------
void CHANNEL::setName(char* name) {
  this->name = name;
}

// ----------------------------------------------------------------------------
// CHANNEL::getName
//
// Get the channel name.
// ----------------------------------------------------------------------------
char* CHANNEL::getName() {
  return name;
}

//------------------ private -----------------------------------------------

// ----------------------------------------------------------------------------
// CHANNEL::setupCS
//
// Set chip select pin for SPI Bus, and start high (disabled)
// ----------------------------------------------------------------------------
void CHANNEL::setupCS(int csPin) {
  csInvertFlag = false;
  ::pinMode(csPin,OUTPUT);
  ::digitalWrite(csPin,HIGH);
  this->csPin = csPin;
}
