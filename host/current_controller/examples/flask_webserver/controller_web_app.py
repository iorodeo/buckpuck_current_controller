#!/usr/bin/env python
"""
Web server interface to IO Rodeo's LED Current Controller. A Demonstrates a
simple web application which allows users to set the current on the devices
channels using http requests e.g.

http://localhost:5000/set_current?channel=a&value=100

sets the current on channel 'a' to 100 mA. 

By default the web server runs on port 5000. This can be changed by setting the
network_port varialble below. 

Requirements: 

    requires the python flask web framwork - see the notes in the README.txt 
    file.

    requires the current_controller to be installed.

Usage:

    # Runs the web server - available on localhost only

    python controller_web_app.py '/dev/ttyUSB0' local

    # Runs web server - available externally

    python controller_web_app.py '/dev/ttyUSB0' builtin


Will Dickson IO Rodeo Inc.

"""
from __future__ import print_function
import sys
import flask
import atexit
from current_controller import CurrentController

network_port = 5000

# Setup application
app = flask.Flask(__name__)
allowed_channels = ('a','b','c','d')
value_min = 0
value_max = 1000

@app.route('/')
def index():
    return 'IO Rodeo Current Controller running.'


@app.route('/set_current', methods=['GET'])
def setcurrent():
    cmd_ok = True
    err_list = []

    # Get channel and value from request arguments
    try:
        channel = str(flask.request.args['channel'])
        channel = channel.lower()
    except KeyError:
        cmd_ok = False
        err_list.append('channel not specified')

    try:
        value = int(flask.request.args['value'])
    except KeyError:
        cmd_ok = False
        err_list.append('value not specified')
    except ValueError:
        cmd_ok = False
        err_list.append('unable to convert value to int')

    # Check that channel is within allowed values
    if not channel in allowed_channels:
        cmd_ok = False
        err_list.append('channel not in allowed values')

    # Check that value is within max and min allowed
    if cmd_ok:
        if value < value_min or value > value_max:
            cmd_ok = False
            err_list.append('value out of range')

    if cmd_ok:
        dev.set_current_value(channel,value)
        return 'channel={0}, value={1}'.format(channel,value)
    else:
        err_msg = 'Error: {0}'.format(', '.join(err_list))
        return err_msg


def close_device():
    """
    Clean up after application - closes serial port
    """
    print(' * cleaning up')
    if dev is not None:
        dev.close()

# -----------------------------------------------------------------------------
if __name__ == '__main__':

    dev = None

    # Get command line arguments
    try:
        serial_port = sys.argv[1]
    except IndexError:
        print('Error: no serial port specified')
        sys.exit(1)
    print(' * serial port {0}'.format(serial_port))

    try:
        server = sys.argv[2]
    except IndexError:
        server = 'local'

    # Open connection to device and set atexit function
    dev = CurrentController(serial_port)
    atexit.register(close_device)

    if server == 'local':
        print(' * using debug server - localhost only')
        #app.debug = 'True'
        app.run(port=network_port)
    else:
        print(' * using builtin server - remote access possible')
        app.run(host='0.0.0.0',port=network_port)

