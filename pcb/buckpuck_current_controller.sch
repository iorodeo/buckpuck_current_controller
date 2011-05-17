EESchema Schematic File Version 2  date Mon 16 May 2011 08:41:53 PM PDT
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:buckpuck_current_controller
LIBS:buckpuck_current_controller-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 2
Title "Buckpuck Current Controller"
Date "17 may 2011"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 9700 2050 0    60   ~ 0
PotentiometerA
Text Label 9700 1700 0    60   ~ 0
OnOffSwitchA
Text Label 9700 1300 0    60   ~ 0
CurrentSenseA
Wire Wire Line
	9500 2050 9700 2050
Wire Wire Line
	9500 1300 9700 1300
Wire Wire Line
	4150 3850 4150 3750
Wire Wire Line
	4150 3750 5250 3750
Wire Wire Line
	5250 4050 4600 4050
Wire Wire Line
	5250 3850 4600 3850
Wire Wire Line
	5250 4450 4650 4450
Wire Wire Line
	5250 3950 4850 3950
Wire Wire Line
	5250 4150 4850 4150
Wire Wire Line
	6950 3950 7150 3950
Wire Wire Line
	6950 4150 7150 4150
Wire Wire Line
	6950 4350 7150 4350
Wire Wire Line
	6950 4550 7150 4550
Wire Wire Line
	1650 2900 3450 2900
Wire Wire Line
	3450 1500 3450 1900
Wire Wire Line
	1350 1800 1350 950 
Wire Wire Line
	1350 1800 1100 1800
Wire Wire Line
	1100 1800 1100 1900
Wire Wire Line
	1100 1900 1000 1900
Connection ~ 3200 2900
Wire Wire Line
	3200 3050 3200 2900
Connection ~ 2950 2900
Wire Wire Line
	2950 2900 2950 2750
Wire Wire Line
	1650 2900 1650 1800
Connection ~ 2400 950 
Wire Wire Line
	2400 750  2400 950 
Wire Wire Line
	2500 2650 1350 2650
Wire Wire Line
	1350 2650 1350 1900
Wire Wire Line
	1350 950  2500 950 
Wire Wire Line
	3450 2900 3450 2300
Connection ~ 3450 2900
Wire Wire Line
	1000 1700 1200 1700
Wire Wire Line
	1200 1700 1200 1900
Wire Wire Line
	1200 1900 1350 1900
Wire Wire Line
	3350 1800 3700 1800
Connection ~ 3450 1800
Wire Wire Line
	3700 1800 3700 1600
Wire Wire Line
	6950 4450 7150 4450
Wire Wire Line
	6950 4250 7150 4250
Wire Wire Line
	6950 4050 7150 4050
Wire Wire Line
	6950 3850 7150 3850
Wire Wire Line
	5250 4250 4850 4250
Wire Wire Line
	5250 4750 4850 4750
Wire Wire Line
	5250 4550 4650 4550
Wire Wire Line
	5250 4350 4600 4350
Wire Wire Line
	5250 4650 4600 4650
Wire Wire Line
	7950 1700 7550 1700
Wire Wire Line
	9500 1700 9700 1700
Text Label 7600 1700 0    60   ~ 0
PwmA
$Sheet
S 7950 1050 1550 1100
U 4DD19FA6
F0 "ChannelA" 60
F1 "single_buckpuck_channel.sch" 60
F2 "Potentiometer" O R 9500 2050 60 
F3 "OnOffSwitch" O R 9500 1700 60 
F4 "PWM" I L 7950 1700 60 
F5 "CurrentSense" O R 9500 1300 60 
$EndSheet
NoConn ~ 6950 3450
NoConn ~ 6950 3650
NoConn ~ 6950 4650
NoConn ~ 6950 4750
NoConn ~ 6950 4850
NoConn ~ 5250 4850
NoConn ~ 5250 3650
Text Label 4650 4650 0    60   ~ 0
OnOffSwitchC
Text Label 4650 4350 0    60   ~ 0
OnOffSwitchA
Text Label 4650 4050 0    60   ~ 0
OnOffSwitchB
Text Label 4650 3850 0    60   ~ 0
OnOffSwitchD
Text Label 4700 4550 0    60   ~ 0
DisplayTX
Text Label 4700 4450 0    60   ~ 0
DisplayRX
$Comp
L GND #PWR?
U 1 1 4DB0D0E3
P 4150 3850
F 0 "#PWR?" H 4150 3850 30  0001 C CNN
F 1 "GND" H 4150 3780 30  0001 C CNN
	1    4150 3850
	1    0    0    -1  
$EndComp
NoConn ~ 5250 3550
NoConn ~ 5250 3450
Text Label 4900 4750 0    60   ~ 0
PwmC
Text Label 4900 4250 0    60   ~ 0
PwmA
Text Label 4900 4150 0    60   ~ 0
PwmB
Text Label 4900 3950 0    60   ~ 0
PwmD
Text Label 7050 3850 0    60   ~ 0
PotentiometerD
Text Label 7050 3950 0    60   ~ 0
CurrentSenseD
Text Label 7050 4050 0    60   ~ 0
PotentiometerC
Text Label 7050 4150 0    60   ~ 0
CurrentSenseC
Text Label 7050 4250 0    60   ~ 0
PotentiometerB
Text Label 7050 4350 0    60   ~ 0
CurrentSenseB
Text Label 7050 4450 0    60   ~ 0
PotentiometerA
Text Label 7050 4550 0    60   ~ 0
CurrentSenseA
$Comp
L VAA #PWR?
U 1 1 4DAF3EF4
P 3700 1600
F 0 "#PWR?" H 3700 1660 30  0001 C CNN
F 1 "VAA" H 3700 1710 30  0000 C CNN
	1    3700 1600
	1    0    0    -1  
$EndComp
$Comp
L ARDUINO_NANO U?
U 1 1 4DAF2A1C
P 6100 4200
F 0 "U?" H 5650 5150 60  0000 C CNN
F 1 "ARDUINO_NANO" H 6100 3350 60  0000 C CNN
	1    6100 4200
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P1
U 1 1 4B885718
P 650 1800
F 0 "P1" V 600 1800 40  0000 C CNN
F 1 "POWER" V 700 1800 40  0000 C CNN
	1    650  1800
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR02
U 1 1 4B884901
P 3200 3050
F 0 "#PWR02" H 3200 3050 30  0001 C CNN
F 1 "GND" H 3200 2980 30  0001 C CNN
	1    3200 3050
	1    0    0    -1  
$EndComp
$Comp
L BRIDGE D1
U 1 1 4B5F750E
P 2500 1800
F 0 "D1" H 2500 1850 70  0000 C CNN
F 1 "BRIDGE" H 2500 1750 70  0000 C CNN
	1    2500 1800
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 4B61DEC3
P 2950 2750
F 0 "#FLG03" H 2950 3020 30  0001 C CNN
F 1 "PWR_FLAG" H 2950 2980 30  0000 C CNN
	1    2950 2750
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG04
U 1 1 4B61DEA9
P 2400 750
F 0 "#FLG04" H 2400 1020 30  0001 C CNN
F 1 "PWR_FLAG" H 2400 980 30  0000 C CNN
	1    2400 750 
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG05
U 1 1 4B61DE8F
P 3450 1500
F 0 "#FLG05" H 3450 1770 30  0001 C CNN
F 1 "PWR_FLAG" H 3450 1730 30  0000 C CNN
	1    3450 1500
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4B5F73D3
P 3450 2100
F 0 "C1" H 3300 2200 50  0000 L CNN
F 1 "10uF" H 3150 2000 50  0000 L CNN
	1    3450 2100
	1    0    0    -1  
$EndComp
$EndSCHEMATC
