# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'current_controller.ui'
#
# Created: Wed Nov  2 16:36:47 2011
#      by: PyQt4 UI code generator 4.8.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(878, 692)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.verticalLayoutWidget = QtGui.QWidget(self.centralwidget)
        self.verticalLayoutWidget.setGeometry(QtCore.QRect(130, 230, 231, 331))
        self.verticalLayoutWidget.setObjectName(_fromUtf8("verticalLayoutWidget"))
        self.verticalLayout = QtGui.QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setMargin(0)
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.horizontalLayout_2 = QtGui.QHBoxLayout()
        self.horizontalLayout_2.setObjectName(_fromUtf8("horizontalLayout_2"))
        self.onOffButton = QtGui.QPushButton(self.verticalLayoutWidget)
        self.onOffButton.setMaximumSize(QtCore.QSize(50, 100))
        self.onOffButton.setCheckable(True)
        self.onOffButton.setAutoDefault(False)
        self.onOffButton.setObjectName(_fromUtf8("onOffButton"))
        self.horizontalLayout_2.addWidget(self.onOffButton)
        self.verticalLayout.addLayout(self.horizontalLayout_2)
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.dial = QtGui.QDial(self.verticalLayoutWidget)
        self.dial.setMaximumSize(QtCore.QSize(100, 100))
        self.dial.setObjectName(_fromUtf8("dial"))
        self.horizontalLayout.addWidget(self.dial)
        self.verticalLayout.addLayout(self.horizontalLayout)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 878, 25))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QtGui.QApplication.translate("MainWindow", "CurrentController", None, QtGui.QApplication.UnicodeUTF8))
        self.onOffButton.setText(QtGui.QApplication.translate("MainWindow", "OFF", None, QtGui.QApplication.UnicodeUTF8))

