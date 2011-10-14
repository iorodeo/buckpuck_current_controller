#!/usr/bin/env python
"""
Copyright 2011  IO Rodeo Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""
from __future__ import division
import sys
import os
import os.path
import platform
import time
import serial


CHANNEL_COUNT = 4

SERIAL_BAUDRATE = 115200

SERIAL_COMMAND_GET_123 = 0
SERIAL_COMMAND_SET_COMPUTERCONTROL_MODE = 1
SERIAL_COMMAND_SET_STANDALONE_MODE = 2
SERIAL_COMMAND_SET_CURRENT_VALUES = 3
SERIAL_COMMAND_SET_CURRENT_VALUE = 4
SERIAL_COMMAND_SET_BNC_MODES = 5
SERIAL_COMMAND_SET_BNC_MODE = 6


class CurrentController(object):
    def __init__(self,port=''):
        # Set default com port
        osType = platform.system()
        if port == '':
            if osType == 'Linux':
                self.port = '/dev/ttyUSB0'
            else:
                self.port = 'com1'
        else:
            self.port = port

        self.serial = serial.Serial(self.port,SERIAL_BAUDRATE,timeout=1)
        self.serial.open()
        time.sleep(2)
        self.test_serial_port()
        self.set_computercontrol_mode()
        self.set_current_values([0,0,0,0])

    def close(self):
        self.set_standalone_mode()
        self.close_serial_port()

    def close_serial_port(self):
        self.serial.close()

    def test_serial_port(self):
        serial_list = [SERIAL_COMMAND_GET_123]
        self.serial.write(str(serial_list))
        read_line = self.serial.readline()
        if (read_line == '') or (int(read_line) != 123):
            raise RuntimeError('Did not receive expected response on serial port, check port and connections.')

    def set_computercontrol_mode(self):
        serial_list = [SERIAL_COMMAND_SET_COMPUTERCONTROL_MODE]
        self.serial.write(str(serial_list))

    def set_standalone_mode(self):
        serial_list = [SERIAL_COMMAND_SET_STANDALONE_MODE]
        self.serial.write(str(serial_list))

    def convert_channel_to_int(self,channel):
        if type(channel) == str:
            channel = channel.lower()
            if channel == 'a':
                channel = 0
            elif channel == 'b':
                channel = 1
            elif channel == 'c':
                channel = 2
            elif channel == 'd':
                channel = 3
            elif channel == 'all':
                channel = -1
        return channel

    def turn_off_channel(self,channel='all'):
        channel = self.convert_channel_to_int(channel)
        if channel != -1:
            self.set_current_value(channel,0)
        else:
            self.set_current_values([0]*CHANNEL_COUNT)

    def set_current_value(self,channel='a',value=0):
        if (value < 0) or (value > 1000):
            raise RuntimeError('Invalid current value, must be between 0-1000')

        channel = self.convert_channel_to_int(channel)
        if (channel < -1 ) or (CHANNEL_COUNT <= channel):
            raise RuntimeError('Invalid channel, must be 0-3 or "a", "b", "c", "d", or "all"')

        if channel != -1:
            serial_list = [SERIAL_COMMAND_SET_CURRENT_VALUE,channel,value]
            self.serial.write(str(serial_list))
        else:
            self.set_current_values([value]*CHANNEL_COUNT)

    def set_current_values(self,value_list=[0]*CHANNEL_COUNT):
        if (type(value_list) != list) and (type(value_list) != tuple):
            raise RuntimeError('set_current_values argument must be a list or tuple.')

        if (len(value_list) != CHANNEL_COUNT):
            raise RuntimeError('set_current_values argument length must equal ' + str(CHANNEL_COUNT))
        serial_list = [SERIAL_COMMAND_SET_CURRENT_VALUES]
        print "sending " + str(value_list)
        serial_list.extend(value_list)
        self.serial.write(str(serial_list))

    def set_bnc_modes(self,mode_list=[False]*CHANNEL_COUNT):
        serial_list = [SERIAL_COMMAND_SET_BNC_MODES]
        serial_list.extend(mode_list)
        print "sending " + str(serial_list)
        self.serial.write(str(serial_list))

# -----------------------------------------------------------------------
if __name__ == '__main__':
    cc = CurrentController()
    time.sleep(1)
    # for i in range(3):
    #     cc.set_current_values([100,0,500,100])
    #     time.sleep(1)
    #     cc.set_current_values([500,0,100,500])
    #     time.sleep(1)
    #     cc.turn_off_channel('c')
    #     cc.set_current_value('a',50)
    #     time.sleep(1)
    # cc.set_current_values([0,0,0,0])
    cc.set_bnc_modes()
    cc.close()
