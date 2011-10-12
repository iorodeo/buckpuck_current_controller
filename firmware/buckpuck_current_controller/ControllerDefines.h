#define LOOP_DELAY 100

#define SERIAL_RATE 115200
#define SOFT_SERIAL_RATE 115200
#define DISPLAY_RX_PIN 8
#define DISPLAY_TX_PIN 9
#define TIMER1_PERIOD 1000
#define UPDATE_DISPLAY_PERIOD 200000
#define CLEAR_DISPLAY_PERIOD_RATIO 5000
#define MSG_SIZE 20
#define LIGHT_VALUE_LOW 0
#define LIGHT_VALUE_HIGH 50

#define POTENTIOMETER_VALUE_MIN 0
#define POTENTIOMETER_VALUE_MAX 1023
#define POTENTIOMETER_DISPLAY_MIN 0
#define POTENTIOMETER_DISPLAY_MAX 100

#define CHANNEL_COUNT 4

#define DAC_CS_PIN 10
#define DAC_VALUE_MIN 3205
#define DAC_VALUE_MAX 1067
#define DAC_VALUE_OFF 4095

#define IO_CS_PIN  3
#define IO_INTERRUPT 0
#define INTERRUPT_DEBOUNCE_MS 200

#define SWITCH_A_ONOFF_IO_PIN 0
#define SWITCH_B_ONOFF_IO_PIN 1
#define SWITCH_C_ONOFF_IO_PIN 2
#define SWITCH_D_ONOFF_IO_PIN 3
#define SWITCH_SET_PUSHBUTTON_IO_PIN 4
#define SWITCH_LIGHT_PUSHBUTTON_IO_PIN 5

#define RELAY_ENABLE_A_PIN 7
#define RELAY_ENABLE_B_PIN 6
#define RELAY_ENABLE_C_PIN 5
#define RELAY_ENABLE_D_PIN 4

#define POTENTIOMETER_A_PIN A0
#define POTENTIOMETER_B_PIN A1
#define POTENTIOMETER_C_PIN A2
#define POTENTIOMETER_D_PIN A3

#define DAC_A_PIN 0
#define DAC_B_PIN 1
#define DAC_C_PIN 2
#define DAC_D_PIN 3

#define BNC_A_PIN A4
#define BNC_B_PIN A5
#define BNC_C_PIN A6
#define BNC_D_PIN A7

#define EEPROM_ADDRESS_A 1
#define EEPROM_ADDRESS_B 2
#define EEPROM_ADDRESS_C 3
#define EEPROM_ADDRESS_D 4

#define EEPROM_VALUE_MIN 0
#define EEPROM_VALUE_MAX 255

#define CURRENT_VALUE_MIN 0
#define CURRENT_VALUE_MAX 1000
#define DAC_VALUE_MIN 3205
#define DAC_VALUE_MAX 1067
#define DAC_VALUE_OFF 4095

#define SET_DEADBAND 10

#define SERIAL_COMMAND_GET_123 0
#define SERIAL_COMMAND_SET_COMPUTERCONTROL_MODE 1
#define SERIAL_COMMAND_SET_STANDALONE_MODE 2
#define SERIAL_COMMAND_SET_CURRENT_VALUES 3
#define SERIAL_COMMAND_SET_CURRENT_VALUE 4