# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'current_controller.ui'
#
# Created: Sun Dec 11 17:01:19 2011
#      by: PyQt4 UI code generator 4.7.2
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

class Ui_CurrentController_MainWindow(object):
    def setupUi(self, CurrentController_MainWindow):
        CurrentController_MainWindow.setObjectName("CurrentController_MainWindow")
        CurrentController_MainWindow.resize(512, 513)
        self.centralwidget = QtGui.QWidget(CurrentController_MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtGui.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")
        self.groupBox_5 = QtGui.QGroupBox(self.centralwidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.groupBox_5.sizePolicy().hasHeightForWidth())
        self.groupBox_5.setSizePolicy(sizePolicy)
        self.groupBox_5.setObjectName("groupBox_5")
        self.horizontalLayout_5 = QtGui.QHBoxLayout(self.groupBox_5)
        self.horizontalLayout_5.setObjectName("horizontalLayout_5")
        self.serialPort_LineEdit = QtGui.QLineEdit(self.groupBox_5)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.serialPort_LineEdit.sizePolicy().hasHeightForWidth())
        self.serialPort_LineEdit.setSizePolicy(sizePolicy)
        self.serialPort_LineEdit.setMaximumSize(QtCore.QSize(120, 16777215))
        self.serialPort_LineEdit.setObjectName("serialPort_LineEdit")
        self.horizontalLayout_5.addWidget(self.serialPort_LineEdit)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_5.addItem(spacerItem)
        self.openClose_PushButton = QtGui.QPushButton(self.groupBox_5)
        self.openClose_PushButton.setObjectName("openClose_PushButton")
        self.horizontalLayout_5.addWidget(self.openClose_PushButton)
        spacerItem1 = QtGui.QSpacerItem(497, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_5.addItem(spacerItem1)
        self.verticalLayout.addWidget(self.groupBox_5)
        self.line = QtGui.QFrame(self.centralwidget)
        self.line.setFrameShape(QtGui.QFrame.HLine)
        self.line.setFrameShadow(QtGui.QFrame.Sunken)
        self.line.setObjectName("line")
        self.verticalLayout.addWidget(self.line)
        self.channelA_GroupBox = QtGui.QGroupBox(self.centralwidget)
        self.channelA_GroupBox.setCheckable(True)
        self.channelA_GroupBox.setChecked(False)
        self.channelA_GroupBox.setObjectName("channelA_GroupBox")
        self.horizontalLayout = QtGui.QHBoxLayout(self.channelA_GroupBox)
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.channelA_SpinBox = QtGui.QSpinBox(self.channelA_GroupBox)
        self.channelA_SpinBox.setMaximum(1000)
        self.channelA_SpinBox.setSingleStep(50)
        self.channelA_SpinBox.setObjectName("channelA_SpinBox")
        self.horizontalLayout.addWidget(self.channelA_SpinBox)
        self.label = QtGui.QLabel(self.channelA_GroupBox)
        self.label.setObjectName("label")
        self.horizontalLayout.addWidget(self.label)
        self.channelA_Slider = QtGui.QSlider(self.channelA_GroupBox)
        self.channelA_Slider.setMaximum(1000)
        self.channelA_Slider.setSingleStep(10)
        self.channelA_Slider.setPageStep(100)
        self.channelA_Slider.setOrientation(QtCore.Qt.Horizontal)
        self.channelA_Slider.setObjectName("channelA_Slider")
        self.horizontalLayout.addWidget(self.channelA_Slider)
        self.verticalLayout.addWidget(self.channelA_GroupBox)
        self.line_2 = QtGui.QFrame(self.centralwidget)
        self.line_2.setFrameShape(QtGui.QFrame.HLine)
        self.line_2.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_2.setObjectName("line_2")
        self.verticalLayout.addWidget(self.line_2)
        self.channelB_GroupBox = QtGui.QGroupBox(self.centralwidget)
        self.channelB_GroupBox.setCheckable(True)
        self.channelB_GroupBox.setChecked(False)
        self.channelB_GroupBox.setObjectName("channelB_GroupBox")
        self.horizontalLayout_2 = QtGui.QHBoxLayout(self.channelB_GroupBox)
        self.horizontalLayout_2.setObjectName("horizontalLayout_2")
        self.channelB_SpinBox = QtGui.QSpinBox(self.channelB_GroupBox)
        self.channelB_SpinBox.setMaximum(1000)
        self.channelB_SpinBox.setSingleStep(50)
        self.channelB_SpinBox.setObjectName("channelB_SpinBox")
        self.horizontalLayout_2.addWidget(self.channelB_SpinBox)
        self.label_2 = QtGui.QLabel(self.channelB_GroupBox)
        self.label_2.setObjectName("label_2")
        self.horizontalLayout_2.addWidget(self.label_2)
        self.channelB_Slider = QtGui.QSlider(self.channelB_GroupBox)
        self.channelB_Slider.setMaximum(1000)
        self.channelB_Slider.setSingleStep(10)
        self.channelB_Slider.setPageStep(100)
        self.channelB_Slider.setOrientation(QtCore.Qt.Horizontal)
        self.channelB_Slider.setObjectName("channelB_Slider")
        self.horizontalLayout_2.addWidget(self.channelB_Slider)
        self.verticalLayout.addWidget(self.channelB_GroupBox)
        self.line_4 = QtGui.QFrame(self.centralwidget)
        self.line_4.setFrameShape(QtGui.QFrame.HLine)
        self.line_4.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_4.setObjectName("line_4")
        self.verticalLayout.addWidget(self.line_4)
        self.channelC_GroupBox = QtGui.QGroupBox(self.centralwidget)
        self.channelC_GroupBox.setCheckable(True)
        self.channelC_GroupBox.setChecked(False)
        self.channelC_GroupBox.setObjectName("channelC_GroupBox")
        self.horizontalLayout_3 = QtGui.QHBoxLayout(self.channelC_GroupBox)
        self.horizontalLayout_3.setObjectName("horizontalLayout_3")
        self.channelC_SpinBox = QtGui.QSpinBox(self.channelC_GroupBox)
        self.channelC_SpinBox.setMaximum(1000)
        self.channelC_SpinBox.setSingleStep(50)
        self.channelC_SpinBox.setObjectName("channelC_SpinBox")
        self.horizontalLayout_3.addWidget(self.channelC_SpinBox)
        self.label_3 = QtGui.QLabel(self.channelC_GroupBox)
        self.label_3.setObjectName("label_3")
        self.horizontalLayout_3.addWidget(self.label_3)
        self.channelC_Slider = QtGui.QSlider(self.channelC_GroupBox)
        self.channelC_Slider.setMaximum(1000)
        self.channelC_Slider.setSingleStep(10)
        self.channelC_Slider.setPageStep(100)
        self.channelC_Slider.setOrientation(QtCore.Qt.Horizontal)
        self.channelC_Slider.setObjectName("channelC_Slider")
        self.horizontalLayout_3.addWidget(self.channelC_Slider)
        self.verticalLayout.addWidget(self.channelC_GroupBox)
        self.line_3 = QtGui.QFrame(self.centralwidget)
        self.line_3.setFrameShape(QtGui.QFrame.HLine)
        self.line_3.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_3.setObjectName("line_3")
        self.verticalLayout.addWidget(self.line_3)
        self.channelD_GroupBox = QtGui.QGroupBox(self.centralwidget)
        self.channelD_GroupBox.setCheckable(True)
        self.channelD_GroupBox.setChecked(False)
        self.channelD_GroupBox.setObjectName("channelD_GroupBox")
        self.horizontalLayout_4 = QtGui.QHBoxLayout(self.channelD_GroupBox)
        self.horizontalLayout_4.setObjectName("horizontalLayout_4")
        self.channelD_SpinBox = QtGui.QSpinBox(self.channelD_GroupBox)
        self.channelD_SpinBox.setMaximum(1000)
        self.channelD_SpinBox.setSingleStep(50)
        self.channelD_SpinBox.setObjectName("channelD_SpinBox")
        self.horizontalLayout_4.addWidget(self.channelD_SpinBox)
        self.label_4 = QtGui.QLabel(self.channelD_GroupBox)
        self.label_4.setObjectName("label_4")
        self.horizontalLayout_4.addWidget(self.label_4)
        self.channelD_Slider = QtGui.QSlider(self.channelD_GroupBox)
        self.channelD_Slider.setMaximum(1000)
        self.channelD_Slider.setSingleStep(10)
        self.channelD_Slider.setPageStep(100)
        self.channelD_Slider.setOrientation(QtCore.Qt.Horizontal)
        self.channelD_Slider.setObjectName("channelD_Slider")
        self.horizontalLayout_4.addWidget(self.channelD_Slider)
        self.verticalLayout.addWidget(self.channelD_GroupBox)
        CurrentController_MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(CurrentController_MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 512, 23))
        self.menubar.setObjectName("menubar")
        CurrentController_MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(CurrentController_MainWindow)
        self.statusbar.setObjectName("statusbar")
        CurrentController_MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(CurrentController_MainWindow)
        QtCore.QObject.connect(self.channelA_Slider, QtCore.SIGNAL("valueChanged(int)"), self.channelA_SpinBox.setValue)
        QtCore.QObject.connect(self.channelB_Slider, QtCore.SIGNAL("valueChanged(int)"), self.channelB_SpinBox.setValue)
        QtCore.QObject.connect(self.channelC_Slider, QtCore.SIGNAL("valueChanged(int)"), self.channelC_SpinBox.setValue)
        QtCore.QObject.connect(self.channelD_Slider, QtCore.SIGNAL("valueChanged(int)"), self.channelD_SpinBox.setValue)
        QtCore.QObject.connect(self.channelA_SpinBox, QtCore.SIGNAL("valueChanged(int)"), self.channelA_Slider.setValue)
        QtCore.QObject.connect(self.channelB_SpinBox, QtCore.SIGNAL("valueChanged(int)"), self.channelB_Slider.setValue)
        QtCore.QObject.connect(self.channelC_SpinBox, QtCore.SIGNAL("valueChanged(int)"), self.channelC_Slider.setValue)
        QtCore.QObject.connect(self.channelD_SpinBox, QtCore.SIGNAL("valueChanged(int)"), self.channelD_Slider.setValue)
        QtCore.QMetaObject.connectSlotsByName(CurrentController_MainWindow)

    def retranslateUi(self, CurrentController_MainWindow):
        CurrentController_MainWindow.setWindowTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Current Controller", None, QtGui.QApplication.UnicodeUTF8))
        self.groupBox_5.setTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Serial Port", None, QtGui.QApplication.UnicodeUTF8))
        self.openClose_PushButton.setText(QtGui.QApplication.translate("CurrentController_MainWindow", "Open", None, QtGui.QApplication.UnicodeUTF8))
        self.channelA_GroupBox.setTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Channel A", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("CurrentController_MainWindow", "mA", None, QtGui.QApplication.UnicodeUTF8))
        self.channelB_GroupBox.setTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Channel B", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("CurrentController_MainWindow", "mA", None, QtGui.QApplication.UnicodeUTF8))
        self.channelC_GroupBox.setTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Channel C", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("CurrentController_MainWindow", "mA", None, QtGui.QApplication.UnicodeUTF8))
        self.channelD_GroupBox.setTitle(QtGui.QApplication.translate("CurrentController_MainWindow", "Channel D", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("CurrentController_MainWindow", "mA", None, QtGui.QApplication.UnicodeUTF8))
