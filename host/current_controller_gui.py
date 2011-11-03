import sys
from PyQt4 import QtCore
from PyQt4 import QtGui
from current_controller_ui import Ui_MainWindow
from current_controller import CurrentController

class CurrentControllerGui(QtGui.QMainWindow, Ui_MainWindow):

    def __init__(self,parent=None):
        super(CurrentControllerGui,self).__init__(parent)
        self.setupUi(self)
        self.initialize()
        self.connectActions()

    def initialize(self):
        self.cc = CurrentController()
        # self.timer = QtCore.QTimer()
        # self.timer.setInterval(0.1)

    def closeEvent(self,event):
        self.cc.close()
        event.accept()

    def connectActions(self):
        self.onOffButton.clicked.connect(self.onOffButtonCallback)
        # self.startPushButton.clicked.connect(self.startCallback)
        # self.stopPushButton.clicked.connect(self.stopCallback)
        # self.timer.timeout.connect(self.timerCallback)

    def onOffButtonCallback(self,pressed):
        if pressed:
            self.onOffButton.setText('ON')
            self.cc.set_current_value('a',50)
        else:
            self.onOffButton.setText('OFF')
            self.cc.turn_off_channel('a')

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
