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

Channel::Channel(char* name, IO onOffSwitch, IO potentiometer, IO relayEnable, int EEPROMAddress) {
  setName(name);
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// Channel::setMode
//
// Set the channel mode.
// ----------------------------------------------------------------------------
void Channel::setMode(modes mode) {
  this->mode = mode;
}

// ----------------------------------------------------------------------------
// Channel::getMode
//
// Get the channel mode.
// ----------------------------------------------------------------------------
modes Channel::getMode() {
  return mode;
}

// ----------------------------------------------------------------------------
// Channel::setName
//
// Set the channel name.
// ----------------------------------------------------------------------------
void Channel::setName(char* name) {
  this->name = name;
}

// ----------------------------------------------------------------------------
// Channel::getName
//
// Get the channel name.
// ----------------------------------------------------------------------------
char* Channel::getName() {
  return name;
}

//------------------ private -----------------------------------------------

// ----------------------------------------------------------------------------
// Channel::setupCS
//
// Set chip select pin for SPI Bus, and start high (disabled)
// ----------------------------------------------------------------------------
void Channel::setupCS(int csPin) {
  csInvertFlag = false;
  ::pinMode(csPin,OUTPUT);
  ::digitalWrite(csPin,HIGH);
  this->csPin = csPin;
}
