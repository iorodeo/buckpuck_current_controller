// ----------------------------------------------------------------------------
// DigiPot.h
//
// Provides an SPI based interface to two MCP4261 dual ditigal POTS with
// non-volatile memory.
//
// Author: Peter Polidoro, IO Rodeo Inc.
// ----------------------------------------------------------------------------
#include "mcp4261.h"
#ifndef _DIGIPOT_H_
#define _DIGIPOT_H_

class DigiPot : public MCP4261 {
 public:
 DigiPot(int csPin) : MCP4261(csPin) {};
  void setWiper(int wiper, int value);
  void setWiper0(int value);
  void setWiper1(int value);
  void setWiper2(int value);
  void setWiper3(int value);
  void incrWiper(int wiper);
  void decrWiper(int wiper);
  void incrWiper0();
  void incrWiper1();
  void incrWiper2();
  void incrWiper3();
  void decrWiper0();
  void decrWiper1();
  void decrWiper2();
  void decrWiper3();
  void setWiper_NonVolatile(int wiper, int value);
  void setWiper0_NonVolatile(int value);
  void setWiper1_NonVolatile(int value);
  void setWiper2_NonVolatile(int value);
  void setWiper3_NonVolatile(int value);
};
#endif
