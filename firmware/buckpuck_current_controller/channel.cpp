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

// Channel::Channel() {
//   setMode(OFF_MODE);
// }

Channel::Channel(IOPin & onOffSwitch, IOPin & relayEnable, IOPin & potentiometer, IOPin & dac, int EEPROMAddress):
  mode(OFF_MODE), onOffSwitch(onOffSwitch), relayEnable(relayEnable), potentiometer(potentiometer), dac(dac), EEPROMAddress(EEPROMAddress),
  currentValue(0), currentLimit(CURRENT_VALUE_MIN), updateValue(0), initialSetValue(0), currentLimitNeedsSaving(false)
{
  getSavedCurrentLimit();
}

//---------- public ----------------------------------------------------

// ----------------------------------------------------------------------------
// Channel::setMode
//
// Set the channel mode.
// ----------------------------------------------------------------------------
void Channel::setMode(modes mode) {
  if (mode != this->mode) {
    this->mode = mode;
    switch (mode) {
    case ON_MODE: setModeOn(); break;
    case OFF_MODE: setModeOff(); break;
    case SET_MODE: setModeSet(); break;
    case CC_MODE: setModeCC(); break;
    }
  }
}

// ----------------------------------------------------------------------------
// Channel::getMode
//
// Get the channel mode.
// ----------------------------------------------------------------------------
Channel::modes Channel::getMode() {
  return mode;
}

// ----------------------------------------------------------------------------
// Channel::getPotentiometerValue
//
// Get the channel potentiometer value.
// ----------------------------------------------------------------------------
int Channel::getPotentiometerValue() {
  return potentiometer.read();
}

// ----------------------------------------------------------------------------
// Channel::getOnOffSwitchValue
//
// Get the channel on/off switch value.
// ----------------------------------------------------------------------------
byte Channel::getOnOffSwitchValue() {
  return onOffSwitch.read();
}

// ----------------------------------------------------------------------------
// Channel::setCurrentValue
//
// Set the channel current value.
// ----------------------------------------------------------------------------
void Channel::setCurrentValue(int currentValue) {
  if (mode == CC_MODE) {
    this->currentValue = currentValue;
    setDacValue();
  }
}

// ----------------------------------------------------------------------------
// Channel::getCurrentValue
//
// Get the channel current value.
// ----------------------------------------------------------------------------
int Channel::getCurrentValue() {
  return currentValue;
}

// ----------------------------------------------------------------------------
// Channel::setCurrentLimit
//
// Set the channel current limit.
// ----------------------------------------------------------------------------
void Channel::setCurrentLimit(int currentLimit) {
  if (mode == CC_MODE) {
    this->currentLimit = currentLimit;
    currentLimitNeedsSaving = true;
  }
}

// ----------------------------------------------------------------------------
// Channel::getCurrentLimit
//
// Get the channel current limit.
// ----------------------------------------------------------------------------
int Channel::getCurrentLimit() {
  return currentLimit;
}

// ----------------------------------------------------------------------------
// Channel::update
//
// Update the channel based on the mode, given the update value.
// ----------------------------------------------------------------------------
void Channel::update(int updateValue) {
  this->updateValue = updateValue;
  switch (mode) {
  case ON_MODE:
    currentValue = map(updateValue,POTENTIOMETER_VALUE_MIN,POTENTIOMETER_VALUE_MAX,CURRENT_VALUE_MIN,currentLimit);
    setDacValue();
    break;
  case OFF_MODE:
    break;
  case SET_MODE:
    if (SET_DEADBAND < abs(updateValue - initialSetValue)) {
      currentLimit = map(updateValue,POTENTIOMETER_VALUE_MIN,POTENTIOMETER_VALUE_MAX,CURRENT_VALUE_MIN,CURRENT_VALUE_MAX);
      currentLimitNeedsSaving = true;
    }
    break;
  case CC_MODE:
    break;
  }
}

//------------------ private -----------------------------------------------

// ----------------------------------------------------------------------------
// Channel::enableRelay
//
// Enable relay.
// ----------------------------------------------------------------------------
void Channel::enableRelay() {
  relayEnable.write(HIGH);
}

// ----------------------------------------------------------------------------
// Channel::disableRelay
//
// Disable relay.
// ----------------------------------------------------------------------------
void Channel::disableRelay() {
  relayEnable.write(LOW);
}

// ----------------------------------------------------------------------------
// Channel::setDacValue
//
// Set DAC given currentValue.
// ----------------------------------------------------------------------------
void Channel::setDacValue() {
  int dacValue = map(currentValue,CURRENT_VALUE_MIN,CURRENT_VALUE_MAX,DAC_VALUE_MIN,DAC_VALUE_MAX);
  dac.write(dacValue);
}

// ----------------------------------------------------------------------------
// Channel::setDacOff
//
// Set DAC to OFF dac value.
// ----------------------------------------------------------------------------
void Channel::setDacOff() {
  dac.write(DAC_VALUE_OFF);
}

// ----------------------------------------------------------------------------
// Channel::setModeOn
//
// Enable relay and set DAC.
// ----------------------------------------------------------------------------
void Channel::setModeOn() {
  enableRelay();
  setDacValue();
  if (currentLimitNeedsSaving) {
    currentLimitNeedsSaving = false;
    setSavedCurrentLimit();
  }
}

// ----------------------------------------------------------------------------
// Channel::setModeOff
//
// Set DAC OFF and disable relay.
// ----------------------------------------------------------------------------
void Channel::setModeOff() {
  currentValue = CURRENT_VALUE_MIN;
  setDacOff();
  disableRelay();
  if (currentLimitNeedsSaving) {
    currentLimitNeedsSaving = false;
    setSavedCurrentLimit();
  }
}

// ----------------------------------------------------------------------------
// Channel::setModeSet
//
// SetModeOff
// ----------------------------------------------------------------------------
void Channel::setModeSet() {
  initialSetValue = updateValue;
  setModeOff();
}

// ----------------------------------------------------------------------------
// Channel::setModeCC
//
// SetModeOn
// ----------------------------------------------------------------------------
void Channel::setModeCC() {
  setModeOn();
}

// ----------------------------------------------------------------------------
// Channel::setSavedCurrentLimit
//
// Save currentLimit to EEPROM after remapping.
// ----------------------------------------------------------------------------
void Channel::setSavedCurrentLimit() {
  byte EEPROMValue = map(currentLimit,CURRENT_VALUE_MIN,CURRENT_VALUE_MAX,EEPROM_VALUE_MIN,EEPROM_VALUE_MAX);
  EEPROM.write(EEPROMAddress,EEPROMValue);
}

// ----------------------------------------------------------------------------
// Channel::getSavedCurrentLimit
//
// Get saved from EEPROM and remap to currentLimit.
// ----------------------------------------------------------------------------
void Channel::getSavedCurrentLimit() {
  byte EEPROMValue = EEPROM.read(EEPROMAddress);
  currentLimit = map(EEPROMValue,EEPROM_VALUE_MIN,EEPROM_VALUE_MAX,CURRENT_VALUE_MIN,CURRENT_VALUE_MAX);
}
