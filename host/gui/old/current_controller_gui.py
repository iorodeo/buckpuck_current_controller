import sys
from PyQt4 import QtCore
from PyQt4 import QtGui
from current_controller_ui import Ui_MainWindow
from current_controller import CurrentController

class Channel(object):
    def __init__(self,name,cc,onOffButton,currentValueSpinBox,currentLimitSpinBox,dial):
        self.name = name
        self.cc = cc
        self.onOffButton = onOffButton
        self.currentValueSpinBox = currentValueSpinBox
        self.currentLimitSpinBox = currentLimitSpinBox
        self.dial = dial

        self.on = False
        self.current_min = 0
        self.current_max = 1000
        self.set_current_limit(self.current_max)
        self.currentLimitSpinBox.setValue(self.current_max)
        self.set_current_value(self.current_min)
        self.currentValueSpinBox.setEnabled(False)
        self.dial.setEnabled(False)

    def get_name(self):
        return self.name

    def get_current_value(self):
        return self.current_value

    def set_current_value(self,value):
        if (self.current_min <= value) and (value <= self.current_limit):
            self.current_value = value
            self.currentValueSpinBox.setValue(value)
            self.dial.setValue(value)
            self.cc.set_current_value(self.name,self.current_value)

    def get_current_limit(self):
        return self.current_limit

    def set_current_limit(self,limit):
        if (self.current_min <= limit) and (limit <= self.current_max):
            self.current_limit = limit
            self.currentValueSpinBox.setMaximum(self.current_limit)
            self.currentValueSpinBox.setRange(self.current_min,self.current_limit)
            self.dial.setMaximum(self.current_limit)
            self.dial.setRange(self.current_min,self.current_limit)

    def turn_off(self):
        self.on = False
        self.currentValueSpinBox.setEnabled(False)
        self.dial.setEnabled(False)
        self.onOffButton.setText('OFF')
        self.cc.set_current_value(self.name,self.current_min)

    def onOffButtonCallback(self,pressed):
        if pressed:
            self.on = True
            self.currentValueSpinBox.setEnabled(True)
            self.dial.setEnabled(True)
            self.onOffButton.setText('ON')
            self.set_current_value(self.current_value)
        else:
            self.turn_off()

    def dialCallback(self,value):
        self.set_current_value(value)

    def currentValueSpinBoxCallback(self,value):
        self.set_current_value(value)

    def currentLimitSpinBoxCallback(self,value):
        self.set_current_limit(value)


class CurrentControllerGui(QtGui.QMainWindow, Ui_MainWindow):

    def __init__(self,parent=None):
        super(CurrentControllerGui,self).__init__(parent)
        self.setupUi(self)
        self.initialize()
        self.connectActions()

    def initialize(self):
        self.cc = CurrentController()
        self.channelA = Channel('a',self.cc,self.onOffButtonA,self.currentValueSpinBoxA,self.currentLimitSpinBoxA,self.dialA)
        self.channelB = Channel('b',self.cc,self.onOffButtonB,self.currentValueSpinBoxB,self.currentLimitSpinBoxB,self.dialB)
        self.channelC = Channel('c',self.cc,self.onOffButtonC,self.currentValueSpinBoxC,self.currentLimitSpinBoxC,self.dialC)
        self.channelD = Channel('d',self.cc,self.onOffButtonD,self.currentValueSpinBoxD,self.currentLimitSpinBoxD,self.dialD)
        # self.timer = QtCore.QTimer()
        # self.timer.setInterval(0.1)

    def closeEvent(self,event):
        self.cc.close()
        event.accept()

    def connectActions(self):
        self.channelA.onOffButton.clicked.connect(self.channelA.onOffButtonCallback)
        self.channelA.dial.valueChanged.connect(self.channelA.dialCallback)
        self.channelA.currentValueSpinBox.valueChanged.connect(self.channelA.currentValueSpinBoxCallback)
        self.channelA.currentLimitSpinBox.valueChanged.connect(self.channelA.currentLimitSpinBoxCallback)

        self.channelB.onOffButton.clicked.connect(self.channelB.onOffButtonCallback)
        self.channelB.dial.valueChanged.connect(self.channelB.dialCallback)
        self.channelB.currentValueSpinBox.valueChanged.connect(self.channelB.currentValueSpinBoxCallback)
        self.channelB.currentLimitSpinBox.valueChanged.connect(self.channelB.currentLimitSpinBoxCallback)

        self.channelC.onOffButton.clicked.connect(self.channelC.onOffButtonCallback)
        self.channelC.dial.valueChanged.connect(self.channelC.dialCallback)
        self.channelC.currentValueSpinBox.valueChanged.connect(self.channelC.currentValueSpinBoxCallback)
        self.channelC.currentLimitSpinBox.valueChanged.connect(self.channelC.currentLimitSpinBoxCallback)

        self.channelD.onOffButton.clicked.connect(self.channelD.onOffButtonCallback)
        self.channelD.dial.valueChanged.connect(self.channelD.dialCallback)
        self.channelD.currentValueSpinBox.valueChanged.connect(self.channelD.currentValueSpinBoxCallback)
        self.channelD.currentLimitSpinBox.valueChanged.connect(self.channelD.currentLimitSpinBoxCallback)

        # self.startPushButton.clicked.connect(self.startCallback)
        # self.stopPushButton.clicked.connect(self.stopCallback)
        # self.timer.timeout.connect(self.timerCallback)

    # def startCallback(self):
    #     print 'start'
    #     self.timer.start()

    # def stopCallback(self):
    #     print 'stop'
    #     self.timer.stop()

    # def timerCallback(self):
    #     print 'timer'


    def main(self):
        self.show()


# ---------------------------------------------------------
if __name__ == '__main__':

    app = QtGui.QApplication(sys.argv)
    current_controller_gui = CurrentControllerGui()
    current_controller_gui.main()
    app.exec_()
