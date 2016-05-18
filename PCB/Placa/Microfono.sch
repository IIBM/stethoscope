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
LIBS:ina
LIBS:opa2335
LIBS:reg
LIBS:plugs
LIBS:minidin_6
LIBS:ECG-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
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
L R R17
U 1 1 571BDBCE
P 3350 3600
F 0 "R17" V 3430 3600 50  0000 C CNN
F 1 "2.2k" V 3350 3600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3280 3600 30  0001 C CNN
F 3 "" H 3350 3600 30  0000 C CNN
	1    3350 3600
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR036
U 1 1 571BDBD5
P 3350 3400
F 0 "#PWR036" H 3350 3250 50  0001 C CNN
F 1 "+5V" H 3350 3540 50  0000 C CNN
F 2 "" H 3350 3400 60  0000 C CNN
F 3 "" H 3350 3400 60  0000 C CNN
	1    3350 3400
	1    0    0    -1  
$EndComp
$Comp
L CP C15
U 1 1 571BDBDB
P 3650 3800
F 0 "C15" H 3675 3900 50  0000 L CNN
F 1 "4.7u" H 3675 3700 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 3688 3650 30  0001 C CNN
F 3 "" H 3650 3800 60  0000 C CNN
	1    3650 3800
	0    -1   1    0   
$EndComp
Wire Wire Line
	3050 3800 3500 3800
Wire Wire Line
	3350 3750 3350 3800
Connection ~ 3350 3800
Wire Wire Line
	3350 3400 3350 3450
$Comp
L R R19
U 1 1 571BDBE7
P 4150 3800
F 0 "R19" V 4230 3800 50  0000 C CNN
F 1 "10k" V 4150 3800 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4080 3800 30  0001 C CNN
F 3 "" H 4150 3800 30  0000 C CNN
	1    4150 3800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4000 3800 3800 3800
$Comp
L OPA2335 U9
U 1 1 571BDBEF
P 4850 3700
F 0 "U9" H 4850 3850 60  0000 L CNN
F 1 "OPA2335" H 4850 3550 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 4850 3700 60  0001 C CNN
F 3 "" H 4850 3700 60  0000 C CNN
	1    4850 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 3800 4500 3800
$Comp
L R R21
U 1 1 571BDBF7
P 4800 4300
F 0 "R21" V 4880 4300 50  0000 C CNN
F 1 "100k" V 4800 4300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4730 4300 30  0001 C CNN
F 3 "" H 4800 4300 30  0000 C CNN
	1    4800 4300
	0    -1   1    0   
$EndComp
Wire Wire Line
	4400 3800 4400 4300
Wire Wire Line
	4400 4300 4650 4300
Connection ~ 4400 3800
Wire Wire Line
	4950 4300 5300 4300
Wire Wire Line
	5300 4300 5300 3700
Wire Wire Line
	5200 3700 5450 3700
$Comp
L GND #PWR037
U 1 1 571BDC04
P 4750 4050
F 0 "#PWR037" H 4750 3800 50  0001 C CNN
F 1 "GND" H 4750 3900 50  0000 C CNN
F 2 "" H 4750 4050 60  0000 C CNN
F 3 "" H 4750 4050 60  0000 C CNN
	1    4750 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 4050 4750 4000
$Comp
L +5V #PWR038
U 1 1 571BDC0B
P 4750 3350
F 0 "#PWR038" H 4750 3200 50  0001 C CNN
F 1 "+5V" H 4750 3490 50  0000 C CNN
F 2 "" H 4750 3350 60  0000 C CNN
F 3 "" H 4750 3350 60  0000 C CNN
	1    4750 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 3350 4750 3400
$Comp
L R R22
U 1 1 571BDC12
P 5600 3700
F 0 "R22" V 5680 3700 50  0000 C CNN
F 1 "1k" V 5600 3700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5530 3700 30  0001 C CNN
F 3 "" H 5600 3700 30  0000 C CNN
	1    5600 3700
	0    -1   -1   0   
$EndComp
Connection ~ 5300 3700
Wire Wire Line
	5750 3700 6200 3700
$Comp
L OPA2335 U9
U 2 1 571BDC1B
P 6550 3800
F 0 "U9" H 6550 3950 60  0000 L CNN
F 1 "OPA2335" H 6550 3650 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 6550 3800 60  0001 C CNN
F 3 "" H 6550 3800 60  0000 C CNN
	2    6550 3800
	1    0    0    -1  
$EndComp
$Comp
L C C16
U 1 1 571BDC22
P 5850 3950
F 0 "C16" H 5875 4050 50  0000 L CNN
F 1 "0.1u" H 5875 3850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5888 3800 50  0001 C CNN
F 3 "" H 5850 3950 50  0000 C CNN
	1    5850 3950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR039
U 1 1 571BDC29
P 5850 4150
F 0 "#PWR039" H 5850 3900 50  0001 C CNN
F 1 "GND" H 5850 4000 50  0000 C CNN
F 2 "" H 5850 4150 60  0000 C CNN
F 3 "" H 5850 4150 60  0000 C CNN
	1    5850 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 4150 5850 4100
Wire Wire Line
	5850 3700 5850 3800
Connection ~ 5850 3700
Wire Wire Line
	6200 3900 6150 3900
Wire Wire Line
	6150 3900 6150 4300
Wire Wire Line
	6150 4300 7000 4300
Wire Wire Line
	7000 4300 7000 3800
Wire Wire Line
	6900 3800 7100 3800
$Comp
L GND #PWR040
U 1 1 571BDC37
P 6450 4150
F 0 "#PWR040" H 6450 3900 50  0001 C CNN
F 1 "GND" H 6450 4000 50  0000 C CNN
F 2 "" H 6450 4150 60  0000 C CNN
F 3 "" H 6450 4150 60  0000 C CNN
	1    6450 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 4150 6450 4100
$Comp
L +5V #PWR041
U 1 1 571BDC3E
P 6450 3450
F 0 "#PWR041" H 6450 3300 50  0001 C CNN
F 1 "+5V" H 6450 3590 50  0000 C CNN
F 2 "" H 6450 3450 60  0000 C CNN
F 3 "" H 6450 3450 60  0000 C CNN
	1    6450 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3450 6450 3500
$Comp
L R R23
U 1 1 571BDC45
P 7250 3800
F 0 "R23" V 7330 3800 50  0000 C CNN
F 1 "1.2k" V 7250 3800 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7180 3800 30  0001 C CNN
F 3 "" H 7250 3800 30  0000 C CNN
	1    7250 3800
	0    -1   -1   0   
$EndComp
$Comp
L C C17
U 1 1 571BDC4C
P 7500 4050
F 0 "C17" H 7525 4150 50  0000 L CNN
F 1 "0.1u" H 7525 3950 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7538 3900 50  0001 C CNN
F 3 "" H 7500 4050 50  0000 C CNN
	1    7500 4050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR042
U 1 1 571BDC53
P 7500 4250
F 0 "#PWR042" H 7500 4000 50  0001 C CNN
F 1 "GND" H 7500 4100 50  0000 C CNN
F 2 "" H 7500 4250 60  0000 C CNN
F 3 "" H 7500 4250 60  0000 C CNN
	1    7500 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 4250 7500 4200
Wire Wire Line
	7500 3800 7500 3900
Connection ~ 7500 3800
Connection ~ 7000 3800
Wire Wire Line
	7400 3800 8100 3800
$Comp
L R R18
U 1 1 571BDC5E
P 4150 3600
F 0 "R18" V 4230 3600 50  0000 C CNN
F 1 "1.1k" V 4150 3600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4080 3600 30  0001 C CNN
F 3 "" H 4150 3600 30  0000 C CNN
	1    4150 3600
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR043
U 1 1 571BDC65
P 3950 3600
F 0 "#PWR043" H 3950 3350 50  0001 C CNN
F 1 "GND" H 3950 3450 50  0000 C CNN
F 2 "" H 3950 3600 60  0000 C CNN
F 3 "" H 3950 3600 60  0000 C CNN
	1    3950 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 3600 4000 3600
$Comp
L R R20
U 1 1 571BDC6C
P 4450 3350
F 0 "R20" V 4530 3350 50  0000 C CNN
F 1 "2.2k" V 4450 3350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4380 3350 30  0001 C CNN
F 3 "" H 4450 3350 30  0000 C CNN
	1    4450 3350
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR044
U 1 1 571BDC73
P 4450 3150
F 0 "#PWR044" H 4450 3000 50  0001 C CNN
F 1 "+5V" H 4450 3290 50  0000 C CNN
F 2 "" H 4450 3150 60  0000 C CNN
F 3 "" H 4450 3150 60  0000 C CNN
	1    4450 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 3150 4450 3200
Wire Wire Line
	4300 3600 4500 3600
Wire Wire Line
	4450 3500 4450 3600
Connection ~ 4450 3600
Text Notes 4350 3700 0    51   ~ 0
1.66V
Text Notes 3400 4050 0    51   ~ 0
4.7u o 10u
Wire Notes Line
	3250 3200 3250 4100
Wire Notes Line
	3250 4100 4300 4100
Wire Notes Line
	4300 4100 4300 3700
Wire Notes Line
	4300 3700 3500 3700
Wire Notes Line
	3500 3700 3500 3200
Wire Notes Line
	3500 3200 3250 3200
Text Notes 3550 4300 0    51   ~ 0
Pasa-altos\n20Hz
Wire Notes Line
	5450 3550 5450 4350
Wire Notes Line
	5450 4350 6050 4350
Wire Notes Line
	6050 4350 6050 3550
Wire Notes Line
	6050 3550 5450 3550
Wire Notes Line
	7100 3650 7700 3650
Wire Notes Line
	7700 3650 7700 4450
Wire Notes Line
	7700 4450 7100 4450
Wire Notes Line
	7100 4450 7100 3650
Text Notes 5450 3550 0    51   ~ 0
Pasa-bajos\n1.6kHz
Text Notes 7100 3650 0    51   ~ 0
Pasa-bajos\n2kHz
$Comp
L C C18
U 1 1 571BDC94
P 7400 2600
F 0 "C18" H 7425 2700 50  0000 L CNN
F 1 "0.1u" H 7425 2500 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7438 2450 50  0001 C CNN
F 3 "" H 7400 2600 50  0000 C CNN
	1    7400 2600
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR045
U 1 1 571BDC9B
P 7400 2400
F 0 "#PWR045" H 7400 2250 50  0001 C CNN
F 1 "+5V" H 7400 2540 50  0000 C CNN
F 2 "" H 7400 2400 60  0000 C CNN
F 3 "" H 7400 2400 60  0000 C CNN
	1    7400 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR046
U 1 1 571BDCA1
P 7400 2800
F 0 "#PWR046" H 7400 2550 50  0001 C CNN
F 1 "GND" H 7400 2650 50  0000 C CNN
F 2 "" H 7400 2800 60  0000 C CNN
F 3 "" H 7400 2800 60  0000 C CNN
	1    7400 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 2400 7400 2450
Wire Wire Line
	7400 2750 7400 2800
Text HLabel 3050 3800 0    79   Input ~ 0
Mic
Text HLabel 8100 3800 2    79   Input ~ 0
OUT_Mic
$Comp
L R R28
U 1 1 571E83A5
P 7850 4050
F 0 "R28" V 7930 4050 50  0000 C CNN
F 1 "2.2k" V 7850 4050 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7780 4050 30  0001 C CNN
F 3 "" H 7850 4050 30  0000 C CNN
	1    7850 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 3900 7850 3800
Connection ~ 7850 3800
Wire Wire Line
	7850 4200 7850 4250
$Comp
L GND #PWR047
U 1 1 571E853F
P 7850 4250
F 0 "#PWR047" H 7850 4000 50  0001 C CNN
F 1 "GND" H 7850 4100 50  0000 C CNN
F 2 "" H 7850 4250 60  0000 C CNN
F 3 "" H 7850 4250 60  0000 C CNN
	1    7850 4250
	1    0    0    -1  
$EndComp
Text Notes 6100 3200 0    60   ~ 0
Hay fenómenos a 500Hz
$EndSCHEMATC
