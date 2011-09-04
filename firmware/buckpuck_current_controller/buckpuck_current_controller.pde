#include "WProgram.h"
#include <Streaming.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include "SerialLCD.h"
#include "ad57x4r.h"
#include "mcp23sxx.h"
#include "TimerOne.h"
#include "ControllerDefines.h"
#include "display.h"
#include "channel.h"
#include "ioPin.h"


SoftwareSerial softSerial(DISPLAY_RX_PIN,DISPLAY_TX_PIN);
Display display(softSerial);

// External IO
MCP23SXX io = MCP23SXX(IO_CS_PIN);

// External DAC
AD57X4R dac = AD57X4R(DAC_CS);

// IO pins
IOPin switch_set = IOPin(SWITCH_SET_IO_PIN,INPUT,io); 
IOPin switch_light = IOPin(SWITCH_LIGHT_IO_PIN,INPUT,io); 

Channel::modes channelModes[CHANNEL_COUNT] = {Channel::OFF_MODE, Channel::ON_MODE, Channel::SET_MODE, Channel::CC_MODE};
unsigned int currentValues[CHANNEL_COUNT];
unsigned int currentValueMaxSettings[CHANNEL_COUNT];
unsigned int potentiometerValues[CHANNEL_COUNT];

byte lightLevel = LOW;
bool setSwitchPressed = false;

void setup() {
  // Setup serial communications
  Serial.begin(SERIAL_RATE);

  // Setup SPI communications
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV8);
  SPI.begin();

  // Initialize DAC
  SPI.setDataMode(SPI_MODE2);
  dac.init(AD57X4R::AD5724R, AD57X4R::UNIPOLAR_5V, AD57X4R::ALL);
  dac.analogWrite(AD57X4R::ALL,DAC_VALUE_OFF);

  // Initialize IO
  SPI.setDataMode(SPI_MODE0);
  io.init(MCP23SXX::MCP23S08);

  // Initialize set switch, turn on pullup resistor, enable interrupt
  switch_set.init();
  switch_set.enablePullup();
  switch_set.enableInterrupt();

  // Initialize light switch, turn on pullup resistor, enable interrupt
  switch_light.init();
  switch_light.enablePullup();
  switch_light.enableInterrupt();

  // Enable arduino interrupt
  attachInterrupt(IO_INTERRUPT,pushButtonCallback,FALLING);

  softSerial.begin(SOFT_SERIAL_RATE);
  display.init();
  display.setLightLevel(lightLevel);

  Timer1.initialize(TIMER1_PERIOD);
  Timer1.attachInterrupt(updateDisplayCallback,UPDATE_DISPLAY_PERIOD);
}

void loop() {
  for (int channel = 0; channel < CHANNEL_COUNT; channel++) {
    if (potentiometerValues[channel] < 1111) {
      potentiometerValues[channel] = potentiometerValues[channel] + channel;
    } else {
      potentiometerValues[channel] = 0;
    }
  }
  delay(100);
}

// updateDisplay interrupt callback
unsigned long clearDisplayPeriodCount = 0;
void updateDisplayCallback() {
  display.update(channelModes,currentValues,currentValueMaxSettings,potentiometerValues);
  clearDisplayPeriodCount++;
  if (CLEAR_DISPLAY_PERIOD_RATIO <= clearDisplayPeriodCount) {
    clearDisplayPeriodCount = 0;
    display.clearScreen();
  }
}

// pushButton interrupt callback
int pinValue;
int flagRegister;
int captureRegister;
// Debounce button presses
static unsigned long lastInterruptTime = 0;
static unsigned long interruptTime;
void pushButtonCallback() {
  flagRegister = io.getInterruptFlagRegister();
  // Get capture register to clear interrupts
  captureRegister = io.getInterruptCaptureRegister();
  interruptTime = millis();
  if (INTERRUPT_DEBOUNCE_MS < (interruptTime - lastInterruptTime)) {
    if ((1<<SWITCH_SET_IO_PIN) & flagRegister) {
      /* pinValue = IO.digitalRead(SWITCH_SET_IO_PIN); */
      pinValue = switch_set.read();
      if (pinValue == LOW) {
        setSwitchPressed = true;
      } else {
        setSwitchPressed = false;
      }
    }
    if ((1<<SWITCH_LIGHT_IO_PIN) & flagRegister) {
      /* pinValue = IO.digitalRead(SWITCH_LIGHT_IO_PIN); */
      pinValue = switch_light.read();
      if (pinValue == LOW) {
        lightLevel = !lightLevel;
        display.setLightLevel(lightLevel);
      }
    }
  }
  lastInterruptTime = interruptTime;
}
