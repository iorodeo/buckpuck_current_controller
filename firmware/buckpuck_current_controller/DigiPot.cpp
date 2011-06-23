// ----------------------------------------------------------------------------
// DigiPot.cpp
//
// Provides an SPI based interface to two MCP4261 dual ditigal POTS with
// non-volatile memory.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "WProgram.h"
#include "mcp4261.h"
#include "DigiPot.h"


// ----------------------------------------------------------------------------
// DigiPot::setWiper
//
// Set the given wiper to the given value.
// ----------------------------------------------------------------------------
void DigiPot::setWiper(int wiper, int value) {
  if ((wiper == 0) || (wiper == 1)) {
    MCP4261::setCSNormal();
    MCP4261::setWiper(wiper,value);
  }
  else {
    MCP4261::setCSInvert();
    MCP4261::setWiper((wiper-2),value);
  }
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper0
//
// Sets wiper 0 (volatile) to the given value
// ----------------------------------------------------------------------------
void DigiPot::setWiper0(int value) {
  MCP4261::setCSNormal();
  MCP4261::setWiper(MCP4261_WIPER_0, value);
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper1
//
// Sets wiper 1 (volatile) to the given value
// ----------------------------------------------------------------------------
void DigiPot::setWiper1(int value) {
  MCP4261::setCSNormal();
  MCP4261::setWiper(MCP4261_WIPER_1, value);
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper2
//
// Sets wiper 2 (volatile) to the given value
// ----------------------------------------------------------------------------
void DigiPot::setWiper2(int value) {
  MCP4261::setCSInvert();
  MCP4261::setWiper(MCP4261_WIPER_0, value);
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper3
//
// Sets wiper 3 (volatile) to the given value
// ----------------------------------------------------------------------------
void DigiPot::setWiper3(int value) {
  MCP4261::setCSInvert();
  MCP4261::setWiper(MCP4261_WIPER_1, value);
}

// ---------------------------------------------------------------------------
// DigiPot::setWiper_NonVolatile
//
// Sets the non-volatile value for the wiper.
//
// Note, after writing to a nonvolatile memory location you need to wait until
// the end of the eeprom write cycle before making another nonvolatile write -
// so put the appropriate delays into your code.  (see the MCP4261 spec sheet)
// ---------------------------------------------------------------------------
void DigiPot::setWiper_NonVolatile(int wiper, int value) {
  if ((wiper == 0) || (wiper == 1)) {
    MCP4261::setCSNormal();
    MCP4261::setWiper_NonVolatile(wiper,value);
  }
  else {
    MCP4261::setCSInvert();
    MCP4261::setWiper_NonVolatile((wiper-2),value);
  }
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper0_NonVolatile
//
// Sets the non-volatile value for wiper 0
//
// Note, after writing to a nonvolatile memory location you need to wait until
// the end of the eeprom write cycle before making another nonvolatile write -
// so put the appropriate delays into your code.  (see the MCP4261 spec sheet)
// ---------------------------------------------------------------------------
void DigiPot::setWiper0_NonVolatile(int value) {
  MCP4261::setCSNormal();
  MCP4261::setWiper_NonVolatile(MCP4261_WIPER_0, value);
}

// ---------------------------------------------------------------------------
// DigiPot::setWiper1_NonVolatile
//
// Sets the non-volatile value for wiper 1
//
// Note, after writing to a nonvolatile memory location you need to wait until
// the end of the eeprom write cycle before making another nonvolatile write -
// so put the appropriate delays into your code.  (see the MCP4261 spec sheet)
// ---------------------------------------------------------------------------
void DigiPot::setWiper1_NonVolatile(int value) {
  MCP4261::setCSNormal();
  MCP4261::setWiper_NonVolatile(MCP4261_WIPER_1, value);
}

// ----------------------------------------------------------------------------
// DigiPot::setWiper2_NonVolatile
//
// Sets the non-volatile value for wiper 2
//
// Note, after writing to a nonvolatile memory location you need to wait until
// the end of the eeprom write cycle before making another nonvolatile write -
// so put the appropriate delays into your code.  (see the MCP4261 spec sheet)
// ---------------------------------------------------------------------------
void DigiPot::setWiper2_NonVolatile(int value) {
  MCP4261::setCSInvert();
  MCP4261::setWiper_NonVolatile(MCP4261_WIPER_0, value);
}

// ---------------------------------------------------------------------------
// DigiPot::setWiper3_NonVolatile
//
// Sets the non-volatile value for wiper 3
//
// Note, after writing to a nonvolatile memory location you need to wait until
// the end of the eeprom write cycle before making another nonvolatile write -
// so put the appropriate delays into your code.  (see the MCP4261 spec sheet)
// ---------------------------------------------------------------------------
void DigiPot::setWiper3_NonVolatile(int value) {
  MCP4261::setCSInvert();
  MCP4261::setWiper_NonVolatile(MCP4261_WIPER_1, value);
}


// ---------------------------------------------------------------------------
// DigiPot::incrWiper
//
// Increments the (volatile) value of the given wiper
// ---------------------------------------------------------------------------
void DigiPot::incrWiper(int wiper) {
  if ((wiper == 0) || (wiper == 1)) {
    MCP4261::setCSNormal();
    MCP4261::incrWiper(wiper);
  }
  else {
    MCP4261::setCSInvert();
    MCP4261::incrWiper((wiper-2));
  }
}

// ---------------------------------------------------------------------------
// DigiPot::decrWiper
//
// Decrements the (volatile) value of the given wiper
// ---------------------------------------------------------------------------
void DigiPot::decrWiper(int wiper) {
  if ((wiper == 0) || (wiper == 1)) {
    MCP4261::setCSNormal();
    MCP4261::decrWiper(wiper);
  }
  else {
    MCP4261::setCSInvert();
    MCP4261::decrWiper((wiper-2));
  }
}


// ----------------------------------------------------------------------------
// DigiPot::incrWiper0
//
// Increments wiper 0
// ----------------------------------------------------------------------------
void DigiPot::incrWiper0() {
  MCP4261::setCSNormal();
  MCP4261::incrWiper(MCP4261_WIPER_0);
}

// ----------------------------------------------------------------------------
// DigiPot::decrWiper0
//
// Decrements wiper 0
// ----------------------------------------------------------------------------
void DigiPot::decrWiper0() {
  MCP4261::setCSNormal();
  MCP4261::decrWiper(MCP4261_WIPER_0);
}

// ----------------------------------------------------------------------------
// DigiPot::incrWiper1
//
// Increments wiper 1
// ----------------------------------------------------------------------------
void DigiPot::incrWiper1() {
  MCP4261::setCSNormal();
  MCP4261::incrWiper(MCP4261_WIPER_1);
}

// ----------------------------------------------------------------------------
// DigiPot::decrWiper1
//
// Decrements wiper 1
// ----------------------------------------------------------------------------
void DigiPot::decrWiper1() {
  MCP4261::setCSNormal();
  MCP4261::decrWiper(MCP4261_WIPER_1);
}

// ----------------------------------------------------------------------------
// DigiPot::incrWiper2
//
// Increments wiper 2
// ----------------------------------------------------------------------------
void DigiPot::incrWiper2() {
  MCP4261::setCSInvert();
  MCP4261::incrWiper(MCP4261_WIPER_0);
}

// ----------------------------------------------------------------------------
// DigiPot::decrWiper2
//
// Decrements wiper 2
// ----------------------------------------------------------------------------
void DigiPot::decrWiper2() {
  MCP4261::setCSInvert();
  MCP4261::decrWiper(MCP4261_WIPER_0);
}

// ----------------------------------------------------------------------------
// DigiPot::incrWiper3
//
// Increments wiper 3
// ----------------------------------------------------------------------------
void DigiPot::incrWiper3() {
  MCP4261::setCSInvert();
  MCP4261::incrWiper(MCP4261_WIPER_1);
}

// ----------------------------------------------------------------------------
// DigiPot::decrWiper3
//
// Decrements wiper 3
// ----------------------------------------------------------------------------
void DigiPot::decrWiper3() {
  MCP4261::setCSInvert();
  MCP4261::decrWiper(MCP4261_WIPER_1);
}
