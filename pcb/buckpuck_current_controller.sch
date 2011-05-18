EESchema Schematic File Version 2  date Wed 18 May 2011 04:50:05 PM PDT
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
Sheet 1 5
Title "Buckpuck Current Controller"
Date "18 may 2011"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	2250 5900 2250 6400
Connection ~ 4250 1800
Wire Wire Line
	4250 1800 4250 1900
Wire Wire Line
	4250 2300 4250 2450
Wire Wire Line
	5400 1800 6550 1800
Connection ~ 3700 1800
Wire Wire Line
	3350 1800 4600 1800
Connection ~ 5450 3900
Wire Wire Line
	4350 3900 5700 3900
Wire Wire Line
	5700 3900 5700 3850
Wire Wire Line
	4450 2950 4450 3600
Wire Wire Line
	4300 6100 3800 6100
Wire Wire Line
	4100 5750 4100 5900
Wire Wire Line
	4100 5900 4300 5900
Wire Wire Line
	4450 3600 4350 3600
Wire Wire Line
	4350 3700 4600 3700
Wire Wire Line
	6800 3450 6800 3600
Wire Wire Line
	2650 3800 2250 3800
Wire Wire Line
	9500 6100 9700 6100
Wire Wire Line
	9500 5000 9700 5000
Wire Wire Line
	9500 4200 9700 4200
Wire Wire Line
	9500 3550 9700 3550
Wire Wire Line
	9500 2650 9700 2650
Wire Wire Line
	7950 4600 7550 4600
Wire Wire Line
	9500 2050 9700 2050
Wire Wire Line
	9500 1300 9700 1300
Wire Wire Line
	1550 4000 1550 3900
Wire Wire Line
	1550 3900 2650 3900
Wire Wire Line
	2650 4200 2000 4200
Wire Wire Line
	2650 4000 2000 4000
Wire Wire Line
	2650 4600 2050 4600
Wire Wire Line
	2650 4100 2250 4100
Wire Wire Line
	2650 4300 2250 4300
Wire Wire Line
	4350 4100 4550 4100
Wire Wire Line
	4350 4300 4550 4300
Wire Wire Line
	4350 4500 4550 4500
Wire Wire Line
	4350 4700 4550 4700
Wire Wire Line
	1650 2900 3450 2900
Wire Wire Line
	3450 1900 3450 1500
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
Connection ~ 3450 1800
Wire Wire Line
	3700 1800 3700 1600
Wire Wire Line
	4350 4600 4550 4600
Wire Wire Line
	4350 4400 4550 4400
Wire Wire Line
	4350 4200 4550 4200
Wire Wire Line
	4350 4000 4550 4000
Wire Wire Line
	2650 4400 2250 4400
Wire Wire Line
	2650 4900 2250 4900
Wire Wire Line
	2650 4700 2050 4700
Wire Wire Line
	2650 4500 2000 4500
Wire Wire Line
	2650 4800 2000 4800
Wire Wire Line
	7950 1700 7550 1700
Wire Wire Line
	9500 1700 9700 1700
Wire Wire Line
	7950 3100 7550 3100
Wire Wire Line
	7950 6100 7550 6100
Wire Wire Line
	9500 3100 9700 3100
Wire Wire Line
	9500 4600 9700 4600
Wire Wire Line
	9500 5750 9700 5750
Wire Wire Line
	9500 6500 9700 6500
Wire Wire Line
	5650 2950 5350 2950
Wire Wire Line
	6450 2950 6800 2950
Wire Wire Line
	6800 2950 6800 3050
Wire Wire Line
	6400 3400 6600 3400
Wire Wire Line
	6600 3400 6600 2950
Connection ~ 6600 2950
Wire Wire Line
	4600 3800 4600 3600
Connection ~ 4600 3700
Wire Wire Line
	4600 3200 4450 3200
Connection ~ 4450 3200
Wire Wire Line
	4300 6000 3550 6000
Wire Wire Line
	3550 6000 3550 6350
Wire Wire Line
	4300 6200 3800 6200
Wire Wire Line
	5450 3700 5450 3900
Wire Wire Line
	5750 3250 5750 3400
Wire Wire Line
	5750 3400 5900 3400
Wire Wire Line
	5000 2100 5000 2250
Wire Wire Line
	5750 1800 5750 1900
Connection ~ 5750 1800
Wire Wire Line
	5750 2300 5750 2450
Wire Wire Line
	6550 1800 6550 1650
Wire Wire Line
	2650 5000 2050 5000
Wire Wire Line
	2050 5000 2050 5700
Wire Wire Line
	2050 5700 2250 5700
$Comp
L CONN_2 P3
U 1 1 4DD40675
P 2600 5800
F 0 "P3" V 2550 5800 40  0000 C CNN
F 1 "SetSwitch" V 2650 5800 40  0000 C CNN
	1    2600 5800
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR01
U 1 1 4DD30F8E
P 6550 1650
F 0 "#PWR01" H 6550 1750 30  0001 C CNN
F 1 "VDD" H 6550 1760 30  0000 C CNN
	1    6550 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 4DD30F78
P 5750 2450
F 0 "#PWR02" H 5750 2450 30  0001 C CNN
F 1 "GND" H 5750 2380 30  0001 C CNN
	1    5750 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 4DD30F74
P 4250 2450
F 0 "#PWR03" H 4250 2450 30  0001 C CNN
F 1 "GND" H 4250 2380 30  0001 C CNN
	1    4250 2450
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 4DD30F54
P 5750 2100
F 0 "C3" H 5800 2200 50  0000 L CNN
F 1 "10uF" H 5800 2000 50  0000 L CNN
	1    5750 2100
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 4DD30F51
P 4250 2100
F 0 "C2" H 4300 2200 50  0000 L CNN
F 1 "10uF" H 4300 2000 50  0000 L CNN
	1    4250 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 4DD30F46
P 5000 2250
F 0 "#PWR04" H 5000 2250 30  0001 C CNN
F 1 "GND" H 5000 2180 30  0001 C CNN
	1    5000 2250
	1    0    0    -1  
$EndComp
$Comp
L V7809 U1
U 1 1 4DD30F0E
P 5000 1850
F 0 "U1" H 5150 1654 60  0000 C CNN
F 1 "V7809" H 5000 2050 60  0000 C CNN
	1    5000 1850
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR05
U 1 1 4DD308A2
P 5750 3250
F 0 "#PWR05" H 5750 3340 20  0001 C CNN
F 1 "+5V" H 5750 3340 30  0000 C CNN
	1    5750 3250
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG06
U 1 1 4DD3088D
P 5700 3850
F 0 "#FLG06" H 5700 4120 30  0001 C CNN
F 1 "PWR_FLAG" H 5700 4080 30  0000 C CNN
	1    5700 3850
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR07
U 1 1 4DD3087D
P 5450 3700
F 0 "#PWR07" H 5450 3790 20  0001 C CNN
F 1 "+5V" H 5450 3790 30  0000 C CNN
	1    5450 3700
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR08
U 1 1 4DD3074D
P 4450 2950
F 0 "#PWR08" H 4450 3050 30  0001 C CNN
F 1 "VDD" H 4450 3060 30  0000 C CNN
	1    4450 2950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 4DD2FA71
P 2250 6400
F 0 "#PWR09" H 2250 6400 30  0001 C CNN
F 1 "GND" H 2250 6330 30  0001 C CNN
	1    2250 6400
	1    0    0    -1  
$EndComp
Text Label 3800 6200 0    60   ~ 0
DisplayTX
Text Label 3800 6100 0    60   ~ 0
DisplayRX
$Comp
L GND #PWR010
U 1 1 4DD2F8D7
P 3550 6350
F 0 "#PWR010" H 3550 6350 30  0001 C CNN
F 1 "GND" H 3550 6280 30  0001 C CNN
	1    3550 6350
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR011
U 1 1 4DD2F8C8
P 4100 5750
F 0 "#PWR011" H 4100 5850 30  0001 C CNN
F 1 "VDD" H 4100 5860 30  0000 C CNN
	1    4100 5750
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 P4
U 1 1 4DD2F842
P 4650 6050
F 0 "P4" V 4600 6050 50  0000 C CNN
F 1 "Display" V 4700 6050 50  0000 C CNN
	1    4650 6050
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 4DD2F791
P 4600 3400
F 0 "C5" H 4650 3500 50  0000 L CNN
F 1 "0.1uF" H 4650 3300 50  0000 L CNN
	1    4600 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 4DD2F728
P 4600 3800
F 0 "#PWR012" H 4600 3800 30  0001 C CNN
F 1 "GND" H 4600 3730 30  0001 C CNN
	1    4600 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 4DD2F63F
P 6800 3600
F 0 "#PWR013" H 6800 3600 30  0001 C CNN
F 1 "GND" H 6800 3530 30  0001 C CNN
	1    6800 3600
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4DD2F567
P 6150 3400
F 0 "R1" V 6230 3400 50  0000 C CNN
F 1 "68" V 6150 3400 50  0000 C CNN
	1    6150 3400
	0    1    1    0   
$EndComp
$Comp
L C C4
U 1 1 4DD2F558
P 6800 3250
F 0 "C4" H 6850 3350 50  0000 L CNN
F 1 "0.33uF" H 6850 3150 50  0000 L CNN
	1    6800 3250
	1    0    0    -1  
$EndComp
Text Label 5350 2950 0    60   ~ 0
RST
Text Label 2250 3800 0    60   ~ 0
RST
NoConn ~ 6450 3050
NoConn ~ 5650 3050
$Comp
L CONN_2X2 P2
U 1 1 4DD2F1DB
P 6050 3000
F 0 "P2" H 6050 3150 50  0000 C CNN
F 1 "ResetOverride" H 6060 2870 40  0000 C CNN
	1    6050 3000
	1    0    0    -1  
$EndComp
Text Label 9700 6500 0    60   ~ 0
PotentiometerD
Text Label 9700 6100 0    60   ~ 0
OnOffSwitchD
Text Label 9700 5750 0    60   ~ 0
CurrentSenseD
Text Label 9700 5000 0    60   ~ 0
PotentiometerC
Text Label 9700 4600 0    60   ~ 0
OnOffSwitchC
Text Label 9700 4200 0    60   ~ 0
CurrentSenseC
Text Label 9700 3550 0    60   ~ 0
PotentiometerB
Text Label 9700 3100 0    60   ~ 0
OnOffSwitchB
Text Label 9700 2650 0    60   ~ 0
CurrentSenseB
Text Label 7550 6100 0    60   ~ 0
PwmD
Text Label 7550 4600 0    60   ~ 0
PwmC
Text Label 7550 3100 0    60   ~ 0
PwmB
$Sheet
S 7950 5450 1550 1200
U 4DD2E86D
F0 "ChannelD" 60
F1 "single_buckpuck_channel.sch" 60
F2 "Potentiometer" O R 9500 6500 60 
F3 "OnOffSwitch" O R 9500 6100 60 
F4 "PWM" I L 7950 6100 60 
F5 "CurrentSense" O R 9500 5750 60 
$EndSheet
$Sheet
S 7950 4000 1550 1200
U 4DD2E861
F0 "ChannelC" 60
F1 "single_buckpuck_channel.sch" 60
F2 "Potentiometer" O R 9500 5000 60 
F3 "OnOffSwitch" O R 9500 4600 60 
F4 "PWM" I L 7950 4600 60 
F5 "CurrentSense" O R 9500 4200 60 
$EndSheet
$Sheet
S 7950 2500 1550 1200
U 4DD2E82D
F0 "ChannelB" 60
F1 "single_buckpuck_channel.sch" 60
F2 "Potentiometer" O R 9500 3550 60 
F3 "OnOffSwitch" O R 9500 3100 60 
F4 "PWM" I L 7950 3100 60 
F5 "CurrentSense" O R 9500 2650 60 
$EndSheet
Text Label 9700 2050 0    60   ~ 0
PotentiometerA
Text Label 9700 1700 0    60   ~ 0
OnOffSwitchA
Text Label 9700 1300 0    60   ~ 0
CurrentSenseA
Text Label 7550 1700 0    60   ~ 0
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
NoConn ~ 4350 3800
NoConn ~ 4350 4800
NoConn ~ 4350 4900
NoConn ~ 4350 5000
Text Label 2000 4800 0    60   ~ 0
OnOffSwitchC
Text Label 2000 4500 0    60   ~ 0
OnOffSwitchA
Text Label 2000 4200 0    60   ~ 0
OnOffSwitchB
Text Label 2000 4000 0    60   ~ 0
OnOffSwitchD
Text Label 2050 4700 0    60   ~ 0
DisplayTX
Text Label 2050 4600 0    60   ~ 0
DisplayRX
$Comp
L GND #PWR014
U 1 1 4DB0D0E3
P 1550 4000
F 0 "#PWR014" H 1550 4000 30  0001 C CNN
F 1 "GND" H 1550 3930 30  0001 C CNN
	1    1550 4000
	1    0    0    -1  
$EndComp
NoConn ~ 2650 3700
NoConn ~ 2650 3600
Text Label 2250 4900 0    60   ~ 0
PwmC
Text Label 2250 4400 0    60   ~ 0
PwmA
Text Label 2250 4300 0    60   ~ 0
PwmB
Text Label 2250 4100 0    60   ~ 0
PwmD
Text Label 4550 4000 0    60   ~ 0
PotentiometerD
Text Label 4550 4100 0    60   ~ 0
CurrentSenseD
Text Label 4550 4200 0    60   ~ 0
PotentiometerC
Text Label 4550 4300 0    60   ~ 0
CurrentSenseC
Text Label 4550 4400 0    60   ~ 0
PotentiometerB
Text Label 4550 4500 0    60   ~ 0
CurrentSenseB
Text Label 4550 4600 0    60   ~ 0
PotentiometerA
Text Label 4550 4700 0    60   ~ 0
CurrentSenseA
$Comp
L VAA #PWR1
U 1 1 4DAF3EF4
P 3700 1600
F 0 "#PWR1" H 3700 1660 30  0001 C CNN
F 1 "VAA" H 3700 1710 30  0000 C CNN
	1    3700 1600
	1    0    0    -1  
$EndComp
$Comp
L ARDUINO_NANO U2
U 1 1 4DAF2A1C
P 3500 4350
F 0 "U2" H 3050 5300 60  0000 C CNN
F 1 "ARDUINO_NANO" H 3500 3500 60  0000 C CNN
	1    3500 4350
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
L GND #PWR015
U 1 1 4B884901
P 3200 3050
F 0 "#PWR015" H 3200 3050 30  0001 C CNN
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
L PWR_FLAG #FLG016
U 1 1 4B61DEC3
P 2950 2750
F 0 "#FLG016" H 2950 3020 30  0001 C CNN
F 1 "PWR_FLAG" H 2950 2980 30  0000 C CNN
	1    2950 2750
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG017
U 1 1 4B61DEA9
P 2400 750
F 0 "#FLG017" H 2400 1020 30  0001 C CNN
F 1 "PWR_FLAG" H 2400 980 30  0000 C CNN
	1    2400 750 
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG018
U 1 1 4B61DE8F
P 3450 1500
F 0 "#FLG018" H 3450 1770 30  0001 C CNN
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
