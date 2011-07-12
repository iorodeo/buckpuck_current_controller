EESchema Schematic File Version 2  date Mon 11 Jul 2011 09:22:36 PM PDT
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
Sheet 5 5
Title "Single Buckpuck Channel"
Date "12 jul 2011"
Rev "3.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 4900 4000
Text Label 5150 3650 0    60   ~ 0
LED-
Text Label 5150 3500 0    60   ~ 0
LED+
Wire Wire Line
	5100 3500 5650 3500
Wire Wire Line
	7050 3800 7050 3950
Wire Wire Line
	7050 3950 7250 3950
Wire Wire Line
	7600 4250 7500 4250
Wire Wire Line
	7500 4250 7500 4100
Wire Wire Line
	5650 3700 5400 3700
Wire Wire Line
	5100 3650 5400 3650
Wire Wire Line
	4250 4100 4250 3800
Wire Wire Line
	4250 3800 4400 3800
Wire Wire Line
	4400 3500 4250 3500
Wire Wire Line
	4250 3500 4250 3200
Wire Wire Line
	5400 3650 5400 3700
Wire Wire Line
	7750 3950 7900 3950
Wire Wire Line
	7900 3950 7900 4050
Wire Wire Line
	4700 4000 4700 4400
Wire Wire Line
	4700 4400 4550 4400
Text HLabel 4550 4400 0    60   Input ~ 0
Control
Text HLabel 7600 4250 2    60   Output ~ 0
Potentiometer
$Comp
L GND #PWR030
U 1 1 4DD1EC8D
P 7900 4050
AR Path="/4DEEDDA4/4DD1EC8D" Ref="#PWR030"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC8D" Ref="#PWR036"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC8D" Ref="#PWR042"  Part="1" 
AR Path="/4DEEDD29/4DD1EC8D" Ref="#PWR048"  Part="1" 
AR Path="/4E1B87B2/4DD1EC8D" Ref="#PWR048"  Part="1" 
AR Path="/4E1B8863/4DD1EC8D" Ref="#PWR048"  Part="1" 
F 0 "#PWR048" H 7900 4050 30  0001 C CNN
F 1 "GND" H 7900 3980 30  0001 C CNN
	1    7900 4050
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR031
U 1 1 4DD1EC8A
P 7050 3800
AR Path="/4DEEDDA4/4DD1EC8A" Ref="#PWR031"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC8A" Ref="#PWR037"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC8A" Ref="#PWR043"  Part="1" 
AR Path="/4DEEDD29/4DD1EC8A" Ref="#PWR049"  Part="1" 
AR Path="/4E1B87B2/4DD1EC8A" Ref="#PWR049"  Part="1" 
AR Path="/4E1B8863/4DD1EC8A" Ref="#PWR049"  Part="1" 
F 0 "#PWR049" H 7050 3890 20  0001 C CNN
F 1 "+5V" H 7050 3890 30  0000 C CNN
	1    7050 3800
	1    0    0    -1  
$EndComp
$Comp
L POT RV4
U 1 1 4DD1EC78
P 7500 3950
AR Path="/4DEEDDA4/4DD1EC78" Ref="RV4"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC78" Ref="RV3"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC78" Ref="RV2"  Part="1" 
AR Path="/4DEEDD29/4DD1EC78" Ref="RV1"  Part="1" 
AR Path="/4E1B87B2/4DD1EC78" Ref="RV1"  Part="1" 
AR Path="/4E1B8863/4DD1EC78" Ref="RV1"  Part="1" 
F 0 "RV1" H 7500 3850 50  0000 C CNN
F 1 "POT" H 7500 3950 50  0000 C CNN
	1    7500 3950
	-1   0    0    1   
$EndComp
$Comp
L BUCKPUCK BP4
U 1 1 4DD1A2DC
P 4750 3650
AR Path="/4DEEDDA4/4DD1A2DC" Ref="BP4"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DC" Ref="BP3"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DC" Ref="BP2"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DC" Ref="BP1"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DC" Ref="BP1"  Part="1" 
AR Path="/4E1B8863/4DD1A2DC" Ref="BP1"  Part="1" 
F 0 "BP1" H 5100 3450 60  0000 C CNN
F 1 "BUCKPUCK" H 4750 3950 60  0000 C CNN
	1    4750 3650
	1    0    0    -1  
$EndComp
$Comp
L VAA #PWR43
U 1 1 4DD1A2DB
P 4250 3200
AR Path="/4DEEDDA4/4DD1A2DB" Ref="#PWR43"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DB" Ref="#PWR36"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DB" Ref="#PWR29"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DB" Ref="#PWR22"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DB" Ref="#PWR22"  Part="1" 
AR Path="/4E1B8863/4DD1A2DB" Ref="#PWR22"  Part="1" 
F 0 "#PWR22" H 4250 3260 30  0001 C CNN
F 1 "VAA" H 4250 3310 30  0000 C CNN
	1    4250 3200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR032
U 1 1 4DD1A2DA
P 4250 4100
AR Path="/4DEEDDA4/4DD1A2DA" Ref="#PWR032"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DA" Ref="#PWR038"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DA" Ref="#PWR044"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DA" Ref="#PWR050"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DA" Ref="#PWR050"  Part="1" 
AR Path="/4E1B8863/4DD1A2DA" Ref="#PWR050"  Part="1" 
F 0 "#PWR050" H 4250 4100 30  0001 C CNN
F 1 "GND" H 4250 4030 30  0001 C CNN
	1    4250 4100
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P12
U 1 1 4DD1A2D9
P 6000 3600
AR Path="/4DEEDDA4/4DD1A2D9" Ref="P12"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2D9" Ref="P11"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2D9" Ref="P10"  Part="1" 
AR Path="/4DEEDD29/4DD1A2D9" Ref="P9"  Part="1" 
AR Path="/4E1B87B2/4DD1A2D9" Ref="P9"  Part="1" 
AR Path="/4E1B8863/4DD1A2D9" Ref="P9"  Part="1" 
F 0 "P9" V 5950 3600 40  0000 C CNN
F 1 "CurrentOutput" V 6050 3600 40  0000 C CNN
	1    6000 3600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
