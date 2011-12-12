from __future__ import print_function
import sys
import serial
import platform
import functools
import time
from PyQt4 import QtCore
from PyQt4 import QtGui
from current_controller import CurrentController

from current_controller_ui import Ui_CurrentController_MainWindow 

SET_CURRENT_DT = 0.10

class Controller_MainWindow(QtGui.QMainWindow, Ui_CurrentController_MainWindow):
    """
    Main Window for the current controller GUI. 
    """

    def __init__(self, parent=None):
        super(Controller_MainWindow,self).__init__(parent)
        self.setupUi(self)
        self.initialize()
        self.connectActions()

    def main(self):
        self.show()

    def connectActions(self):
        """
        Connect widget actions.
        """
        self.openClose_PushButton.pressed.connect(self.openClosePressed_Callback)
        self.openClose_PushButton.clicked.connect(self.openCloseClicked_Callback)
        self.serialPort_LineEdit.editingFinished.connect(self.serialPort_Callback)

        for chan in self.channelList:

            groupBoxName = 'channel{0}_GroupBox'.format(chan.upper())
            groupBox = getattr(self,groupBoxName)

            toggled_Callback = channelWrapper(
                    self.channelGroupBoxToggled_Callback,
                    chan
                    )
            groupBox.toggled.connect(toggled_Callback)

            sliderName = 'channel{0}_Slider'.format(chan.upper())
            slider = getattr(self,sliderName)

            valueChanged_Callback = channelWrapper(
                    self.channelValueChanged_Callback,
                    chan
                    )
            slider.valueChanged.connect(valueChanged_Callback)

    def initialize(self):
        """
        Initialize the GUI state
        """
        self.dev = None
        self.channelList = ['a','b','c','d']
        self.setChanGroupBoxEnabled(False)
        self.openClose_PushButton.setText('Open')

        # Set default com port
        osType = platform.system()
        if osType == 'Linux':
            self.port = '/dev/ttyUSB0'
        else: 
            self.port = 'com1'
        self.serialPort_LineEdit.setText(self.port)

    def openClosePressed_Callback(self):
        """
        Callback function for the open/close putton 'pressed' event. Note this
        function is called before the 'clicked' event callback and we use it to
        disable the serial port line edit. 
        """
        self.serialPort_LineEdit.setEnabled(False)
        self.openClose_PushButton.setText('Close')


    def openCloseClicked_Callback(self):
        """
        Callback function for the open/close button 'clicked' event. This is
        used to establish or break the serial connection with the current
        controller.
        """
        if self.dev is None:
            try:
                self.dev = CurrentController(self.port)
                self.setChanGroupBoxEnabled(True)
            except serial.serialutil.SerialException, e:
                errMsg = '{0}'.format(str(e))
                QtGui.QMessageBox.critical(self,'Error',errMsg)
                self.serialPort_LineEdit.setEnabled(True)
                self.openClose_PushButton.setText('Open')
        else:
            self.dev.close()
            self.dev = None 
            self.serialPort_LineEdit.setEnabled(True)
            self.openClose_PushButton.setText('Open')
            self.setChanGroupBoxEnabled(False)
            self.setChanGroupBoxEnabled(False)

    def serialPort_Callback(self):
        """
        Callback for the serialPort_LineEdit widget.
        """
        self.port = str(self.serialPort_LineEdit.text())

    def channelGroupBoxToggled_Callback(self,value,chan=None):
        """
        Callback function for the channel group box checks 'toggled' events.
        """
        if value == True:
            sliderValue = self.getSliderValue(chan)
            self.dev.set_current_value(chan,sliderValue)
        else:
            self.dev.set_current_value(chan,0)

    def getSliderValue(self,chan):
        """
        Get the value of the given slider for the given channel. 
        """
        sliderName = 'channel{0}_Slider'.format(chan.upper())
        slider = getattr(self,sliderName)
        return slider.value()

    def channelValueChanged_Callback(self,value,chan=None):
        self.dev.set_current_value(chan,value)
        #time.sleep(SET_CURRENT_DT)

    def setChanGroupBoxEnabled(self,value):
        """
        Enable/Disables the all of the channel group boxes
        """
        # Disable channel groups
        for chan in self.channelList:
            widgetName = 'channel{0}_GroupBox'.format(chan.upper())
            groubox = getattr(self,widgetName)
            groubox.setEnabled(value)

def channelWrapper(f,chan):
    """
    Decorator for channel specific callback functions. Allows the channel
    assigned to be passed to the callback function.
    """
    functools.wraps(f)
    def decorated(value,chan=chan):
        f(value,chan=chan)
    return decorated


# -----------------------------------------------------------------------------
if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    mainWindow = Controller_MainWindow()
    mainWindow.main()
    app.exec_()

