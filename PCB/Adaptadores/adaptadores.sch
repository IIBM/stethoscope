EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
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
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_02X04 P1
U 1 1 576AE857
P 5150 4200
F 0 "P1" H 5150 4450 50  0000 C CNN
F 1 "CONN_02X04" H 5150 3950 50  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 5150 3000 50  0001 C CNN
F 3 "" H 5150 3000 50  0000 C CNN
	1    5150 4200
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P2
U 1 1 576AEA6C
P 4300 4200
F 0 "P2" H 4300 4450 50  0000 C CNN
F 1 "CONN_01X04" V 4400 4200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04" H 4300 4200 50  0001 C CNN
F 3 "" H 4300 4200 50  0000 C CNN
	1    4300 4200
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X04 P3
U 1 1 576AEAD1
P 6200 4200
F 0 "P3" H 6200 4450 50  0000 C CNN
F 1 "CONN_01X04" V 6300 4200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04" H 6200 4200 50  0001 C CNN
F 3 "" H 6200 4200 50  0000 C CNN
	1    6200 4200
	1    0    0    -1  
$EndComp
Text Label 4500 4050 0    60   ~ 0
1
Text Label 4900 4050 2    60   ~ 0
1
Text Label 5400 4050 0    60   ~ 0
2
Text Label 4900 4150 2    60   ~ 0
3
Text Label 5400 4150 0    60   ~ 0
4
Text Label 4900 4250 2    60   ~ 0
5
Text Label 5400 4250 0    60   ~ 0
6
Text Label 4900 4350 2    60   ~ 0
7
Text Label 5400 4350 0    60   ~ 0
8
Text Label 4500 4150 0    60   ~ 0
2
Text Label 4500 4250 0    60   ~ 0
3
Text Label 4500 4350 0    60   ~ 0
4
Text Label 6000 4050 2    60   ~ 0
5
Text Label 6000 4150 2    60   ~ 0
6
Text Label 6000 4250 2    60   ~ 0
7
Text Label 6000 4350 2    60   ~ 0
8
$Comp
L C C1
U 1 1 576AF0DD
P 5150 4600
F 0 "C1" H 5175 4700 50  0000 L CNN
F 1 "C" H 5175 4500 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 5188 4450 50  0001 C CNN
F 3 "" H 5150 4600 50  0000 C CNN
	1    5150 4600
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 4600 5000 4600
Wire Wire Line
	5300 4600 5500 4600
Wire Wire Line
	5500 4600 5500 4150
Wire Wire Line
	5500 4150 5400 4150
Wire Wire Line
	4800 4600 4800 4350
Wire Wire Line
	4800 4350 4900 4350
$Comp
L CONN_02X04 P5
U 1 1 576AF2AD
P 5150 2300
F 0 "P5" H 5150 2550 50  0000 C CNN
F 1 "CONN_02X04" H 5150 2050 50  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 5150 1100 50  0001 C CNN
F 3 "" H 5150 1100 50  0000 C CNN
	1    5150 2300
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P4
U 1 1 576AF2B3
P 4300 2300
F 0 "P4" H 4300 2550 50  0000 C CNN
F 1 "CONN_01X04" V 4400 2300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04" H 4300 2300 50  0001 C CNN
F 3 "" H 4300 2300 50  0000 C CNN
	1    4300 2300
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X04 P6
U 1 1 576AF2B9
P 6200 2300
F 0 "P6" H 6200 2550 50  0000 C CNN
F 1 "CONN_01X04" V 6300 2300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04" H 6200 2300 50  0001 C CNN
F 3 "" H 6200 2300 50  0000 C CNN
	1    6200 2300
	1    0    0    -1  
$EndComp
Text Label 4500 2150 0    60   ~ 0
1
Text Label 4900 2150 2    60   ~ 0
1
Text Label 5400 2150 0    60   ~ 0
2
Text Label 4900 2250 2    60   ~ 0
3
Text Label 5400 2250 0    60   ~ 0
4
Text Label 4900 2350 2    60   ~ 0
5
Text Label 5400 2350 0    60   ~ 0
6
Text Label 4900 2450 2    60   ~ 0
7
Text Label 5400 2450 0    60   ~ 0
8
Text Label 4500 2250 0    60   ~ 0
2
Text Label 4500 2350 0    60   ~ 0
3
Text Label 4500 2450 0    60   ~ 0
4
Text Label 6000 2150 2    60   ~ 0
5
Text Label 6000 2250 2    60   ~ 0
6
Text Label 6000 2350 2    60   ~ 0
7
Text Label 6000 2450 2    60   ~ 0
8
$Comp
L C C2
U 1 1 576AF2CF
P 5650 2450
F 0 "C2" H 5675 2550 50  0000 L CNN
F 1 "C" H 5675 2350 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 5688 2300 50  0001 C CNN
F 3 "" H 5650 2450 50  0000 C CNN
	1    5650 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 2250 5650 2250
Wire Wire Line
	5650 2250 5650 2300
Wire Wire Line
	5400 2450 5400 2650
Wire Wire Line
	5400 2650 5650 2650
Wire Wire Line
	5650 2650 5650 2600
Wire Notes Line
	4050 1850 4050 2800
Wire Notes Line
	4050 2800 6400 2800
Wire Notes Line
	6400 2800 6400 1850
Wire Notes Line
	6400 1850 4050 1850
Text Notes 4100 1950 0    60   ~ 0
OPA2335
Wire Notes Line
	4050 3750 4050 4750
Wire Notes Line
	4050 4750 6400 4750
Wire Notes Line
	6400 4750 6400 3750
Wire Notes Line
	6400 3750 4050 3750
Text Notes 4100 3850 0    60   ~ 0
INA333
$EndSCHEMATC
