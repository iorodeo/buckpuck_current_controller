#include "WProgram.h"
#include "Streaming.h"
#include "display.h"

#define DISPLAY_RX 8
#define DISPLAY_TX 9

DISPLAY display(DISPLAY_RX,DISPLAY_TX);


void setup() {
}


void loop() {
  display.setLightLow();
  delay(500);
  display.setLightHigh();
  delay(500);
}
