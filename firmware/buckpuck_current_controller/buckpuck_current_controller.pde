#include "WProgram.h"
#include <util/atomic.h>
#include <Streaming.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <EEPROM.h>
#include "SerialLCD.h"
#include "ad57x4r.h"
#include "mcp23sxx.h"
#include "TimerOne.h"
#include "ControllerDefines.h"
#include "display.h"
#include "channel.h"
#include "ioPin.h"
#include "SerialReceiver.h"


SoftwareSerial softSerial(DISPLAY_RX_PIN,DISPLAY_TX_PIN);
Display display(softSerial);
SerialReceiver receiver = SerialReceiver();

// External IO
MCP23SXX io = MCP23SXX(IO_CS_PIN);

// External DAC
AD57X4R dac = AD57X4R(DAC_CS_PIN);

// IO pins
IOPin switchOnOffA = IOPin(SWITCH_A_ONOFF_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin switchOnOffB = IOPin(SWITCH_B_ONOFF_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin switchOnOffC = IOPin(SWITCH_C_ONOFF_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin switchOnOffD = IOPin(SWITCH_D_ONOFF_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin switchPushbuttonSet = IOPin(SWITCH_SET_PUSHBUTTON_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin switchPushbuttonLight = IOPin(SWITCH_LIGHT_PUSHBUTTON_IO_PIN,IOPin::EXTERNAL_PIN,IOPin::DIGITAL_PIN,INPUT,io,dac);
IOPin relayEnableA = IOPin(RELAY_ENABLE_A_PIN,IOPin::INTERNAL_PIN,IOPin::DIGITAL_PIN,OUTPUT,io,dac);
IOPin relayEnableB = IOPin(RELAY_ENABLE_B_PIN,IOPin::INTERNAL_PIN,IOPin::DIGITAL_PIN,OUTPUT,io,dac);
IOPin relayEnableC = IOPin(RELAY_ENABLE_C_PIN,IOPin::INTERNAL_PIN,IOPin::DIGITAL_PIN,OUTPUT,io,dac);
IOPin relayEnableD = IOPin(RELAY_ENABLE_D_PIN,IOPin::INTERNAL_PIN,IOPin::DIGITAL_PIN,OUTPUT,io,dac);
IOPin potentiometerA = IOPin(POTENTIOMETER_A_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin potentiometerB = IOPin(POTENTIOMETER_B_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin potentiometerC = IOPin(POTENTIOMETER_C_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin potentiometerD = IOPin(POTENTIOMETER_D_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin dacA = IOPin(DAC_A_PIN,IOPin::EXTERNAL_PIN,IOPin::ANALOG_PIN,OUTPUT,io,dac);
IOPin dacB = IOPin(DAC_B_PIN,IOPin::EXTERNAL_PIN,IOPin::ANALOG_PIN,OUTPUT,io,dac);
IOPin dacC = IOPin(DAC_C_PIN,IOPin::EXTERNAL_PIN,IOPin::ANALOG_PIN,OUTPUT,io,dac);
IOPin dacD = IOPin(DAC_D_PIN,IOPin::EXTERNAL_PIN,IOPin::ANALOG_PIN,OUTPUT,io,dac);
IOPin bncA = IOPin(BNC_A_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin bncB = IOPin(BNC_B_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin bncC = IOPin(BNC_C_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);
IOPin bncD = IOPin(BNC_D_PIN,IOPin::INTERNAL_PIN,IOPin::ANALOG_PIN,INPUT,io,dac);

Channel channels[CHANNEL_COUNT] = {Channel(switchOnOffA,relayEnableA,potentiometerA,dacA,bncA,EEPROM_ADDRESS_CURRENT_LIMIT_A,EEPROM_ADDRESS_BNC_MODE_A),
                                   Channel(switchOnOffB,relayEnableB,potentiometerB,dacB,bncB,EEPROM_ADDRESS_CURRENT_LIMIT_B,EEPROM_ADDRESS_BNC_MODE_B),
                                   Channel(switchOnOffC,relayEnableC,potentiometerC,dacC,bncC,EEPROM_ADDRESS_CURRENT_LIMIT_C,EEPROM_ADDRESS_BNC_MODE_C),
                                   Channel(switchOnOffD,relayEnableD,potentiometerD,dacD,bncD,EEPROM_ADDRESS_CURRENT_LIMIT_D,EEPROM_ADDRESS_BNC_MODE_D)};
Channel::modes channelModes[CHANNEL_COUNT] = {Channel::ON_MODE,Channel::OFF_MODE,Channel::SET_MODE,Channel::CC_MODE};
int currentValues[CHANNEL_COUNT];
int currentLimits[CHANNEL_COUNT];
int updateValues[CHANNEL_COUNT];

byte lightLevel = LOW;
bool standaloneMode = true;
bool setMode = false;
int pinValue;

int serialCommand;
int updateValue;
int updateChannelIndex;
typedef enum computercontrolModes {WAIT,SET_CURRENT_VALUES,SET_CURRENT_VALUE};
computercontrolModes computercontrolMode = WAIT;

void setup() {
  // Check to see if EEPROM values have been initialized, if not, initialize
  if (EEPROM.read(EEPROM_ADDRESS_INITIALIZED) != INITIALIZED_VALUE) {
    EEPROM.write(EEPROM_ADDRESS_INITIALIZED,INITIALIZED_VALUE);
    EEPROM.write(EEPROM_ADDRESS_CURRENT_LIMIT_A,EEPROM_VALUE_MAX);
    EEPROM.write(EEPROM_ADDRESS_CURRENT_LIMIT_B,EEPROM_VALUE_MAX);
    EEPROM.write(EEPROM_ADDRESS_CURRENT_LIMIT_C,EEPROM_VALUE_MAX);
    EEPROM.write(EEPROM_ADDRESS_CURRENT_LIMIT_D,EEPROM_VALUE_MAX);
    EEPROM.write(EEPROM_ADDRESS_BNC_MODE_A,false);
    EEPROM.write(EEPROM_ADDRESS_BNC_MODE_B,false);
    EEPROM.write(EEPROM_ADDRESS_BNC_MODE_C,false);
    EEPROM.write(EEPROM_ADDRESS_BNC_MODE_D,false);
  }

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

  // Initialize switches A-D
  switchOnOffA.init();
  switchOnOffA.enablePullup();
  switchOnOffB.init();
  switchOnOffB.enablePullup();
  switchOnOffC.init();
  switchOnOffC.enablePullup();
  switchOnOffD.init();
  switchOnOffD.enablePullup();

  // Initialize set switch, turn on pullup resistor, enable interrupt
  switchPushbuttonSet.init();
  switchPushbuttonSet.enablePullup();
  switchPushbuttonSet.enableInterrupt();

  // Initialize light switch, turn on pullup resistor, enable interrupt
  switchPushbuttonLight.init();
  switchPushbuttonLight.enablePullup();
  switchPushbuttonLight.enableInterrupt();

  // Initialize relay enable A-D
  relayEnableA.init();
  relayEnableB.init();
  relayEnableC.init();
  relayEnableD.init();

  // Analog input/output IOPins do not need to be initialized

  // Enable arduino interrupt
  attachInterrupt(IO_INTERRUPT,pushbuttonCallback,FALLING);

  softSerial.begin(SOFT_SERIAL_RATE);
  display.init();
  display.setLightLevel(lightLevel);

  Timer1.initialize(TIMER1_PERIOD);
  Timer1.attachInterrupt(updateDisplayCallback,UPDATE_DISPLAY_PERIOD);
}

void loop() {
  // Service any serial port messages
  while (Serial.available() > 0) {
    receiver.process(Serial.read());
    if (receiver.messageReady()) {
      serialCommand = receiver.readInt(0);
      switch (serialCommand) {
      case SERIAL_COMMAND_GET_123 :
        Serial << 123 << endl;
        break;
      case SERIAL_COMMAND_SET_COMPUTERCONTROL_MODE :
        standaloneMode = false;
        break;
      case SERIAL_COMMAND_SET_STANDALONE_MODE :
        standaloneMode = true;
        break;
      case SERIAL_COMMAND_SET_CURRENT_VALUES :
        computercontrolMode = SET_CURRENT_VALUES;
        for (int channelIndex = 0; channelIndex < CHANNEL_COUNT; channelIndex++) {
          updateValues[channelIndex] = receiver.readInt(channelIndex+1);
        }
        break;
      case SERIAL_COMMAND_SET_CURRENT_VALUE :
        computercontrolMode = SET_CURRENT_VALUE;
        updateChannelIndex = receiver.readInt(1);
        updateValue = receiver.readInt(2);
        break;
      case SERIAL_COMMAND_SET_BNC_MODES :
        standaloneMode = true;
        for (int channelIndex = 0; channelIndex < CHANNEL_COUNT; channelIndex++) {
          bool bncMode = receiver.readInt(channelIndex+1);
          channels[channelIndex].setSavedBncMode(bncMode);
        }
        break;
      case SERIAL_COMMAND_SET_BNC_MODE :
        standaloneMode = true;
        int channelIndex = receiver.readInt(1);
        bool bncMode = receiver.readInt(2);
        channels[channelIndex].setSavedBncMode(bncMode);
        break;
      }
      receiver.reset();
    }
  }

  // Read some pin, just to check to make sure interrupts are cleared
  // Also use the value to doublecheck set mode to prevent flawed interrupt states
  pinValue = switchPushbuttonSet.read();
  if (pinValue == HIGH) {
    setMode = false;
  } else {
    setMode = true;
  }

  for (int channelIndex = 0; channelIndex < CHANNEL_COUNT; channelIndex++) {
    // Determine channel mode
    if (standaloneMode) {
      if (setMode) {
        channels[channelIndex].setMode(Channel::SET_MODE);
      } else {
        pinValue = channels[channelIndex].getOnOffSwitchValue();
        if (pinValue == HIGH) {
          channels[channelIndex].setMode(Channel::OFF_MODE);
        } else {
          if (!(channels[channelIndex].getSavedBncMode())) {
            channels[channelIndex].setMode(Channel::ON_MODE);
          } else {
            channels[channelIndex].setMode(Channel::BNC_MODE);
          }
        }
      }
      if (channels[channelIndex].getMode() != Channel::BNC_MODE) {
        updateValue = channels[channelIndex].getPotentiometerValue();
      } else {
        updateValue = channels[channelIndex].getBncValue();
      }
      updateValues[channelIndex] = updateValue;
    } else {
      channels[channelIndex].setMode(Channel::CC_MODE);
      switch (computercontrolMode) {
      case WAIT :
        break;
      case SET_CURRENT_VALUES :
        for (int channelIndex = 0; channelIndex < CHANNEL_COUNT; channelIndex++) {
          channels[channelIndex].setCurrentValue(updateValues[channelIndex]);
        }
        break;
      case SET_CURRENT_VALUE :
        channels[updateChannelIndex].setCurrentValue(updateValue);
        break;
      }
      computercontrolMode = WAIT;
    }

    // Update channel
    channels[channelIndex].update(updateValue);

    // Update variables for display
    channelModes[channelIndex] = channels[channelIndex].getMode();
    currentValues[channelIndex] = channels[channelIndex].getCurrentValue();
    currentLimits[channelIndex] = channels[channelIndex].getCurrentLimit();
  }
  /* delay(LOOP_DELAY); */
}

// updateDisplay interrupt callback
unsigned long clearDisplayPeriodCount = 0;
void updateDisplayCallback() {
  display.update(channelModes,currentValues,currentLimits,updateValues);
  clearDisplayPeriodCount++;
  if (CLEAR_DISPLAY_PERIOD_RATIO <= clearDisplayPeriodCount) {
    clearDisplayPeriodCount = 0;
    display.clearScreen();
  }
}

// pushButton interrupt callback
int flagRegister;
int captureRegister;
// Debounce button presses
static unsigned long lastInterruptTime = 0;
static unsigned long interruptTime;
void pushbuttonCallback() {
  SPI.setDataMode(SPI_MODE0);
  flagRegister = io.getInterruptFlagRegister();
  // Get capture register to clear interrupts
  captureRegister = io.getInterruptCaptureRegister();
  interruptTime = millis();
  if (INTERRUPT_DEBOUNCE_MS < (interruptTime - lastInterruptTime)) {
    if ((1<<SWITCH_SET_PUSHBUTTON_IO_PIN) & flagRegister) {
      pinValue = switchPushbuttonSet.read();
      if (pinValue == LOW) {
        setMode = true;
      } else {
        setMode = false;
      }
    }
    if ((1<<SWITCH_LIGHT_PUSHBUTTON_IO_PIN) & flagRegister) {
      pinValue = switchPushbuttonLight.read();
      if (pinValue == LOW) {
        lightLevel = !lightLevel;
        display.setLightLevel(lightLevel);
      }
    }
  }
  lastInterruptTime = interruptTime;
}
