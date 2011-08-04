EESchema Schematic File Version 2  date Wed 03 Aug 2011 10:08:40 PM PDT
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
Sheet 3 5
Title "Buckpuck Current Controller"
Date "4 aug 2011"
Rev "4.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	2850 3800 2750 3800
Wire Wire Line
	4750 3900 5550 3900
Wire Wire Line
	4750 4000 4900 4000
Wire Wire Line
	4900 4000 4900 3700
Wire Wire Line
	5700 4800 5850 4800
Wire Wire Line
	5850 4800 5850 4400
Wire Wire Line
	9050 4450 9050 4350
Wire Wire Line
	9050 4350 8900 4350
Wire Wire Line
	6550 4050 6550 4100
Wire Wire Line
	5550 4200 5400 4200
Wire Wire Line
	5400 4200 5400 4500
Wire Wire Line
	6550 4050 6250 4050
Wire Wire Line
	6550 4100 6800 4100
Wire Wire Line
	8650 4500 8650 4650
Wire Wire Line
	8650 4650 8750 4650
Wire Wire Line
	8400 4350 8200 4350
Wire Wire Line
	8200 4350 8200 4200
Wire Wire Line
	6250 3900 6800 3900
Wire Wire Line
	4750 3800 4900 3800
Connection ~ 4900 3800
Wire Wire Line
	3450 3900 3250 3900
Wire Wire Line
	3250 3900 3250 4050
Wire Wire Line
	3350 3800 3450 3800
$Comp
L R R2
U 1 1 4E386D28
P 3100 3800
AR Path="/4E3873D3/4E386D28" Ref="R2"  Part="1" 
AR Path="/4E388079/4E386D28" Ref="R5"  Part="1" 
AR Path="/4E38807C/4E386D28" Ref="R4"  Part="1" 
AR Path="/4E38806B/4E386D28" Ref="R3"  Part="1" 
F 0 "R5" V 3180 3800 50  0000 C CNN
F 1 "150" V 3100 3800 50  0000 C CNN
	1    3100 3800
	0    1    1    0   
$EndComp
Text HLabel 2750 3800 0    60   Input ~ 0
SSR_Control
$Comp
L GND #PWR?
U 1 1 4E35D6B2
P 3250 4050
AR Path="/4E1B87B2/4E35D6B2" Ref="#PWR?"  Part="1" 
AR Path="/4E1B8863/4E35D6B2" Ref="#PWR?"  Part="1" 
AR Path="/4E3873D3/4E35D6B2" Ref="#PWR047"  Part="1" 
AR Path="/4E388079/4E35D6B2" Ref="#PWR039"  Part="1" 
AR Path="/4E38807C/4E35D6B2" Ref="#PWR035"  Part="1" 
AR Path="/4E38806B/4E35D6B2" Ref="#PWR043"  Part="1" 
F 0 "#PWR047" H 3250 4050 30  0001 C CNN
F 1 "GND" H 3250 3980 30  0001 C CNN
	1    3250 4050
	1    0    0    -1  
$EndComp
Text Label 4950 3900 0    60   ~ 0
BuckpuckV+
NoConn ~ 3450 4000
$Comp
L SSR_DC_6PIN U?
U 1 1 4E35C1C4
P 4100 3900
AR Path="/4E1B87B2/4E35C1C4" Ref="U?"  Part="1" 
AR Path="/4E1B8863/4E35C1C4" Ref="U?"  Part="1" 
AR Path="/4E3873D3/4E35C1C4" Ref="U3"  Part="1" 
AR Path="/4E388079/4E35C1C4" Ref="U6"  Part="1" 
AR Path="/4E38807C/4E35C1C4" Ref="U5"  Part="1" 
AR Path="/4E38806B/4E35C1C4" Ref="U4"  Part="1" 
F 0 "U6" H 3850 4100 60  0000 C CNN
F 1 "SSR_DC_6PIN" H 4100 3700 60  0000 C CNN
	1    4100 3900
	1    0    0    -1  
$EndComp
NoConn ~ 6050 4400
Text Label 6300 4050 0    60   ~ 0
LED-
Text Label 6300 3900 0    60   ~ 0
LED+
Text HLabel 5700 4800 0    60   Input ~ 0
Buckpuck_Control
Text HLabel 8750 4650 2    60   Output ~ 0
Potentiometer
$Comp
L GND #PWR030
U 1 1 4DD1EC8D
P 9050 4450
AR Path="/4DEEDDA4/4DD1EC8D" Ref="#PWR030"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC8D" Ref="#PWR036"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC8D" Ref="#PWR042"  Part="1" 
AR Path="/4DEEDD29/4DD1EC8D" Ref="#PWR048"  Part="1" 
AR Path="/4E1B87B2/4DD1EC8D" Ref="#PWR043"  Part="1" 
AR Path="/4E1B8863/4DD1EC8D" Ref="#PWR040"  Part="1" 
AR Path="/4E1B8870/4DD1EC8D" Ref="#PWR034"  Part="1" 
AR Path="/4E1B886D/4DD1EC8D" Ref="#PWR037"  Part="1" 
AR Path="/4E3873D3/4DD1EC8D" Ref="#PWR048"  Part="1" 
AR Path="/4E388079/4DD1EC8D" Ref="#PWR040"  Part="1" 
AR Path="/4E38807C/4DD1EC8D" Ref="#PWR036"  Part="1" 
AR Path="/4E38806B/4DD1EC8D" Ref="#PWR044"  Part="1" 
F 0 "#PWR048" H 9050 4450 30  0001 C CNN
F 1 "GND" H 9050 4380 30  0001 C CNN
	1    9050 4450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR031
U 1 1 4DD1EC8A
P 8200 4200
AR Path="/4DEEDDA4/4DD1EC8A" Ref="#PWR031"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC8A" Ref="#PWR037"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC8A" Ref="#PWR043"  Part="1" 
AR Path="/4DEEDD29/4DD1EC8A" Ref="#PWR049"  Part="1" 
AR Path="/4E1B87B2/4DD1EC8A" Ref="#PWR044"  Part="1" 
AR Path="/4E1B8863/4DD1EC8A" Ref="#PWR041"  Part="1" 
AR Path="/4E1B8870/4DD1EC8A" Ref="#PWR035"  Part="1" 
AR Path="/4E1B886D/4DD1EC8A" Ref="#PWR038"  Part="1" 
AR Path="/4E3873D3/4DD1EC8A" Ref="#PWR049"  Part="1" 
AR Path="/4E388079/4DD1EC8A" Ref="#PWR041"  Part="1" 
AR Path="/4E38807C/4DD1EC8A" Ref="#PWR037"  Part="1" 
AR Path="/4E38806B/4DD1EC8A" Ref="#PWR045"  Part="1" 
F 0 "#PWR049" H 8200 4290 20  0001 C CNN
F 1 "+5V" H 8200 4290 30  0000 C CNN
	1    8200 4200
	1    0    0    -1  
$EndComp
$Comp
L POT RV4
U 1 1 4DD1EC78
P 8650 4350
AR Path="/4DEEDDA4/4DD1EC78" Ref="RV4"  Part="1" 
AR Path="/4DEEDD9B/4DD1EC78" Ref="RV3"  Part="1" 
AR Path="/4DEEDD8F/4DD1EC78" Ref="RV2"  Part="1" 
AR Path="/4DEEDD29/4DD1EC78" Ref="RV1"  Part="1" 
AR Path="/4E1B87B2/4DD1EC78" Ref="RV1"  Part="1" 
AR Path="/4E1B8863/4DD1EC78" Ref="RV2"  Part="1" 
AR Path="/4E1B8870/4DD1EC78" Ref="RV3"  Part="1" 
AR Path="/4E1B886D/4DD1EC78" Ref="RV4"  Part="1" 
AR Path="/4E3873D3/4DD1EC78" Ref="RV1"  Part="1" 
AR Path="/4E388079/4DD1EC78" Ref="RV4"  Part="1" 
AR Path="/4E38807C/4DD1EC78" Ref="RV3"  Part="1" 
AR Path="/4E38806B/4DD1EC78" Ref="RV2"  Part="1" 
F 0 "RV4" H 8650 4250 50  0000 C CNN
F 1 "POT" H 8650 4350 50  0000 C CNN
	1    8650 4350
	-1   0    0    1   
$EndComp
$Comp
L BUCKPUCK BP4
U 1 1 4DD1A2DC
P 5900 4050
AR Path="/4DEEDDA4/4DD1A2DC" Ref="BP4"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DC" Ref="BP3"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DC" Ref="BP2"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DC" Ref="BP1"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DC" Ref="BP1"  Part="1" 
AR Path="/4E1B8863/4DD1A2DC" Ref="BP2"  Part="1" 
AR Path="/4E1B8870/4DD1A2DC" Ref="BP3"  Part="1" 
AR Path="/4E1B886D/4DD1A2DC" Ref="BP4"  Part="1" 
AR Path="/4E3873D3/4DD1A2DC" Ref="BP1"  Part="1" 
AR Path="/4E388079/4DD1A2DC" Ref="BP4"  Part="1" 
AR Path="/4E38807C/4DD1A2DC" Ref="BP3"  Part="1" 
AR Path="/4E38806B/4DD1A2DC" Ref="BP2"  Part="1" 
F 0 "BP4" H 6250 3850 60  0000 C CNN
F 1 "BUCKPUCK" H 5900 4350 60  0000 C CNN
	1    5900 4050
	1    0    0    -1  
$EndComp
$Comp
L VAA #PWR43
U 1 1 4DD1A2DB
P 4900 3700
AR Path="/4DEEDDA4/4DD1A2DB" Ref="#PWR43"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DB" Ref="#PWR36"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DB" Ref="#PWR29"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DB" Ref="#PWR22"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DB" Ref="#PWR32"  Part="1" 
AR Path="/4E1B8863/4DD1A2DB" Ref="#PWR36"  Part="1" 
AR Path="/4E1B8870/4DD1A2DB" Ref="#PWR44"  Part="1" 
AR Path="/4E1B886D/4DD1A2DB" Ref="#PWR40"  Part="1" 
AR Path="/4E3873D3/4DD1A2DB" Ref="#PWR36"  Part="1" 
AR Path="/4E388079/4DD1A2DB" Ref="#PWR46"  Part="1" 
AR Path="/4E38807C/4DD1A2DB" Ref="#PWR51"  Part="1" 
AR Path="/4E38806B/4DD1A2DB" Ref="#PWR41"  Part="1" 
F 0 "#PWR46" H 4900 3760 30  0001 C CNN
F 1 "VAA" H 4900 3810 30  0000 C CNN
	1    4900 3700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR032
U 1 1 4DD1A2DA
P 5400 4500
AR Path="/4DEEDDA4/4DD1A2DA" Ref="#PWR032"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2DA" Ref="#PWR038"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2DA" Ref="#PWR044"  Part="1" 
AR Path="/4DEEDD29/4DD1A2DA" Ref="#PWR050"  Part="1" 
AR Path="/4E1B87B2/4DD1A2DA" Ref="#PWR045"  Part="1" 
AR Path="/4E1B8863/4DD1A2DA" Ref="#PWR042"  Part="1" 
AR Path="/4E1B8870/4DD1A2DA" Ref="#PWR036"  Part="1" 
AR Path="/4E1B886D/4DD1A2DA" Ref="#PWR039"  Part="1" 
AR Path="/4E3873D3/4DD1A2DA" Ref="#PWR050"  Part="1" 
AR Path="/4E388079/4DD1A2DA" Ref="#PWR042"  Part="1" 
AR Path="/4E38807C/4DD1A2DA" Ref="#PWR038"  Part="1" 
AR Path="/4E38806B/4DD1A2DA" Ref="#PWR046"  Part="1" 
F 0 "#PWR050" H 5400 4500 30  0001 C CNN
F 1 "GND" H 5400 4430 30  0001 C CNN
	1    5400 4500
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P12
U 1 1 4DD1A2D9
P 7150 4000
AR Path="/4DEEDDA4/4DD1A2D9" Ref="P12"  Part="1" 
AR Path="/4DEEDD9B/4DD1A2D9" Ref="P11"  Part="1" 
AR Path="/4DEEDD8F/4DD1A2D9" Ref="P10"  Part="1" 
AR Path="/4DEEDD29/4DD1A2D9" Ref="P9"  Part="1" 
AR Path="/4E1B87B2/4DD1A2D9" Ref="P9"  Part="1" 
AR Path="/4E1B8863/4DD1A2D9" Ref="P10"  Part="1" 
AR Path="/4E1B8870/4DD1A2D9" Ref="P11"  Part="1" 
AR Path="/4E1B886D/4DD1A2D9" Ref="P12"  Part="1" 
AR Path="/4E3873D3/4DD1A2D9" Ref="P9"  Part="1" 
AR Path="/4E388079/4DD1A2D9" Ref="P12"  Part="1" 
AR Path="/4E38807C/4DD1A2D9" Ref="P11"  Part="1" 
AR Path="/4E38806B/4DD1A2D9" Ref="P10"  Part="1" 
F 0 "P12" V 7100 4000 40  0000 C CNN
F 1 "CurrentOutput" V 7200 4000 40  0000 C CNN
	1    7150 4000
	1    0    0    -1  
$EndComp
$EndSCHEMATC
