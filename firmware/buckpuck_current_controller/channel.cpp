// ----------------------------------------------------------------------------
// channel.cpp
//
// Object to control each channel of the current controller.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "WProgram.h"
#include <Streaming.h>
#include "channel.h"

//---------- constructor ----------------------------------------------------

Channel::Channel() {
  setMode(OFF_MODE);
}

Channel::Channel(IOPin onOffSwitch, IOPin potentiometer, IOPin relayEnable, int EEPROMAddress) {
  setMode(OFF_MODE);
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
// modes Channel::getMode() {
//   return mode;
// }

//------------------ private -----------------------------------------------
