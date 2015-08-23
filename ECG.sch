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
LIBS:ECG-cache
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
L INA333 U1
U 1 1 55C79378
P 5500 3600
F 0 "U1" H 5800 3850 70  0000 C CNN
F 1 "INA333" H 5900 3350 70  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 5500 3600 60  0001 C CNN
F 3 "" H 5500 3600 60  0000 C CNN
	1    5500 3600
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 55C7955F
P 5500 4150
F 0 "R2" V 5580 4150 50  0000 C CNN
F 1 "12k" V 5500 4150 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5430 4150 30  0001 C CNN
F 3 "" H 5500 4150 30  0000 C CNN
	1    5500 4150
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 55C795DC
P 5700 4150
F 0 "R1" V 5780 4150 50  0000 C CNN
F 1 "12k" V 5700 4150 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5630 4150 30  0001 C CNN
F 3 "" H 5700 4150 30  0000 C CNN
	1    5700 4150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 55C7962F
P 5400 4000
F 0 "#PWR01" H 5400 3750 50  0001 C CNN
F 1 "GND" H 5400 3850 50  0000 C CNN
F 2 "" H 5400 4000 60  0000 C CNN
F 3 "" H 5400 4000 60  0000 C CNN
	1    5400 4000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 55C79649
P 5400 3200
F 0 "#PWR02" H 5400 3050 50  0001 C CNN
F 1 "+5V" H 5400 3340 50  0000 C CNN
F 2 "" H 5400 3200 60  0000 C CNN
F 3 "" H 5400 3200 60  0000 C CNN
	1    5400 3200
	1    0    0    -1  
$EndComp
$Comp
L OPA2335 U2
U 1 1 55C79960
P 6100 4800
F 0 "U2" H 6100 4950 60  0000 L CNN
F 1 "OPA2335" H 6100 4650 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 6100 4800 60  0001 C CNN
F 3 "" H 6100 4800 60  0000 C CNN
	1    6100 4800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 55C79A63
P 6000 5350
F 0 "#PWR03" H 6000 5100 50  0001 C CNN
F 1 "GND" H 6000 5200 50  0000 C CNN
F 2 "" H 6000 5350 60  0000 C CNN
F 3 "" H 6000 5350 60  0000 C CNN
	1    6000 5350
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR04
U 1 1 55C79A7F
P 6000 4450
F 0 "#PWR04" H 6000 4300 50  0001 C CNN
F 1 "+5V" H 6000 4590 50  0000 C CNN
F 2 "" H 6000 4450 60  0000 C CNN
F 3 "" H 6000 4450 60  0000 C CNN
	1    6000 4450
	1    0    0    -1  
$EndComp
$Comp
L OPA2335 U2
U 2 1 55C79B1A
P 7600 4700
F 0 "U2" H 7600 4850 60  0000 L CNN
F 1 "OPA2335" H 7600 4550 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 7600 4700 60  0001 C CNN
F 3 "" H 7600 4700 60  0000 C CNN
	2    7600 4700
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 55C79B61
P 6900 4800
F 0 "R6" V 6980 4800 50  0000 C CNN
F 1 "10k" V 6900 4800 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 6830 4800 30  0001 C CNN
F 3 "" H 6900 4800 30  0000 C CNN
	1    6900 4800
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR05
U 1 1 55C79E76
P 7500 5050
F 0 "#PWR05" H 7500 4800 50  0001 C CNN
F 1 "GND" H 7500 4900 50  0000 C CNN
F 2 "" H 7500 5050 60  0000 C CNN
F 3 "" H 7500 5050 60  0000 C CNN
	1    7500 5050
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR06
U 1 1 55C79E96
P 7500 4350
F 0 "#PWR06" H 7500 4200 50  0001 C CNN
F 1 "+5V" H 7500 4490 50  0000 C CNN
F 2 "" H 7500 4350 60  0000 C CNN
F 3 "" H 7500 4350 60  0000 C CNN
	1    7500 4350
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 55C79F39
P 7500 3850
F 0 "R7" V 7580 3850 50  0000 C CNN
F 1 "390k" V 7500 3850 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7430 3850 30  0001 C CNN
F 3 "" H 7500 3850 30  0000 C CNN
	1    7500 3850
	0    1    1    0   
$EndComp
$Comp
L C_Small C1
U 1 1 55C7A003
P 7500 4050
F 0 "C1" H 7510 4120 50  0000 L CNN
F 1 "47p" H 7510 3970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7500 4050 60  0001 C CNN
F 3 "" H 7500 4050 60  0000 C CNN
	1    7500 4050
	0    1    1    0   
$EndComp
$Comp
L JUMPER3 JP1
U 1 1 55C7A2FF
P 5600 2850
F 0 "JP1" H 5650 2750 50  0000 L CNN
F 1 "GND/AC" H 5600 2950 50  0000 C BNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 5600 2850 60  0001 C CNN
F 3 "" H 5600 2850 60  0000 C CNN
	1    5600 2850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 55C7A391
P 5200 2900
F 0 "#PWR07" H 5200 2650 50  0001 C CNN
F 1 "GND" H 5200 2750 50  0000 C CNN
F 2 "" H 5200 2900 60  0000 C CNN
F 3 "" H 5200 2900 60  0000 C CNN
	1    5200 2900
	1    0    0    -1  
$EndComp
$Comp
L OPA2335 U3
U 1 1 55C7A4DF
P 6550 2850
F 0 "U3" H 6550 3000 60  0000 L CNN
F 1 "OPA2335" H 6550 2700 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 6550 2850 60  0001 C CNN
F 3 "" H 6550 2850 60  0000 C CNN
	1    6550 2850
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR08
U 1 1 55C7A600
P 6650 3200
F 0 "#PWR08" H 6650 3050 50  0001 C CNN
F 1 "+5V" H 6650 3340 50  0000 C CNN
F 2 "" H 6650 3200 60  0000 C CNN
F 3 "" H 6650 3200 60  0000 C CNN
	1    6650 3200
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR09
U 1 1 55C7A628
P 6650 2500
F 0 "#PWR09" H 6650 2250 50  0001 C CNN
F 1 "GND" H 6650 2350 50  0000 C CNN
F 2 "" H 6650 2500 60  0000 C CNN
F 3 "" H 6650 2500 60  0000 C CNN
	1    6650 2500
	-1   0    0    1   
$EndComp
$Comp
L C_Small C2
U 1 1 55C7A71F
P 6500 2250
F 0 "C2" H 6510 2320 50  0000 L CNN
F 1 "1u" H 6510 2170 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 6500 2250 60  0001 C CNN
F 3 "" H 6500 2250 60  0000 C CNN
	1    6500 2250
	0    -1   -1   0   
$EndComp
$Comp
L R R5
U 1 1 55C7A9F4
P 7150 2750
F 0 "R5" V 7230 2750 50  0000 C CNN
F 1 "330k" V 7150 2750 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7080 2750 30  0001 C CNN
F 3 "" H 7150 2750 30  0000 C CNN
	1    7150 2750
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 55C7AC89
P 7600 3600
F 0 "R3" V 7680 3600 50  0000 C CNN
F 1 "4.7k" V 7600 3600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7530 3600 30  0001 C CNN
F 3 "" H 7600 3600 30  0000 C CNN
	1    7600 3600
	0    1    1    0   
$EndComp
$Comp
L OPA2335 U3
U 2 1 55C7AD54
P 8600 3500
F 0 "U3" H 8600 3650 60  0000 L CNN
F 1 "OPA2335" H 8600 3350 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 8600 3500 60  0001 C CNN
F 3 "" H 8600 3500 60  0000 C CNN
	2    8600 3500
	1    0    0    -1  
$EndComp
Text GLabel 6900 2950 2    60   Input ~ 0
REF
Text GLabel 8250 3400 0    60   Input ~ 0
REF
Text GLabel 7250 4500 1    60   Input ~ 0
REF
$Comp
L GND #PWR010
U 1 1 55C7B4A3
P 8500 3900
F 0 "#PWR010" H 8500 3650 50  0001 C CNN
F 1 "GND" H 8500 3750 50  0000 C CNN
F 2 "" H 8500 3900 60  0000 C CNN
F 3 "" H 8500 3900 60  0000 C CNN
	1    8500 3900
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR011
U 1 1 55C7B4D3
P 8500 3100
F 0 "#PWR011" H 8500 2950 50  0001 C CNN
F 1 "+5V" H 8500 3240 50  0000 C CNN
F 2 "" H 8500 3100 60  0000 C CNN
F 3 "" H 8500 3100 60  0000 C CNN
	1    8500 3100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 55C7B999
P 9000 1700
F 0 "#PWR012" H 9000 1450 50  0001 C CNN
F 1 "GND" H 9000 1550 50  0000 C CNN
F 2 "" H 9000 1700 60  0000 C CNN
F 3 "" H 9000 1700 60  0000 C CNN
	1    9000 1700
	1    0    0    -1  
$EndComp
Text GLabel 8350 1000 0    60   Input ~ 0
Alimentacion
$Comp
L GND #PWR013
U 1 1 55C7C161
P 9000 2550
F 0 "#PWR013" H 9000 2300 50  0001 C CNN
F 1 "GND" H 9000 2400 50  0000 C CNN
F 2 "" H 9000 2550 60  0000 C CNN
F 3 "" H 9000 2550 60  0000 C CNN
	1    9000 2550
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR014
U 1 1 55C7C195
P 8450 2000
F 0 "#PWR014" H 8450 1850 50  0001 C CNN
F 1 "+5V" H 8450 2140 50  0000 C CNN
F 2 "" H 8450 2000 60  0000 C CNN
F 3 "" H 8450 2000 60  0000 C CNN
	1    8450 2000
	1    0    0    -1  
$EndComp
Text GLabel 9550 2050 2    60   Input ~ 0
REF
$Comp
L C_Small C4
U 1 1 55C7C4D5
P 8450 2300
F 0 "C4" H 8460 2370 50  0000 L CNN
F 1 "0.1u" H 8460 2220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8450 2300 60  0001 C CNN
F 3 "" H 8450 2300 60  0000 C CNN
	1    8450 2300
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 55C7D19F
P 8550 4300
F 0 "R4" V 8630 4300 50  0000 C CNN
F 1 "10k" V 8550 4300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 8480 4300 30  0001 C CNN
F 3 "" H 8550 4300 30  0000 C CNN
	1    8550 4300
	0    1    1    0   
$EndComp
$Comp
L C_Small C3
U 1 1 55C7D2B0
P 8550 4500
F 0 "C3" H 8560 4570 50  0000 L CNN
F 1 "330p" H 8560 4420 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8550 4500 60  0001 C CNN
F 3 "" H 8550 4500 60  0000 C CNN
	1    8550 4500
	0    1    1    0   
$EndComp
$Comp
L C_Small C5
U 1 1 55C7DCE3
P 8400 1500
F 0 "C5" H 8410 1570 50  0000 L CNN
F 1 "1u" H 8410 1420 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 8400 1500 60  0001 C CNN
F 3 "" H 8400 1500 60  0000 C CNN
	1    8400 1500
	1    0    0    -1  
$EndComp
$Comp
L C_Small C6
U 1 1 55C7E26D
P 9700 1500
F 0 "C6" H 9710 1570 50  0000 L CNN
F 1 "22u" H 9710 1420 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2" H 9700 1500 60  0001 C CNN
F 3 "" H 9700 1500 60  0000 C CNN
	1    9700 1500
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P1
U 1 1 55C7E983
P 4100 3500
F 0 "P1" H 4100 3600 50  0000 C CNN
F 1 "RA" V 4200 3500 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 3500 60  0001 C CNN
F 3 "" H 4100 3500 60  0000 C CNN
	1    4100 3500
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X01 P2
U 1 1 55C7EC18
P 4100 3800
F 0 "P2" H 4100 3900 50  0000 C CNN
F 1 "LL" V 4200 3800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 3800 60  0001 C CNN
F 3 "" H 4100 3800 60  0000 C CNN
	1    4100 3800
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X01 P3
U 1 1 55C7EE8B
P 4100 4200
F 0 "P3" H 4100 4300 50  0000 C CNN
F 1 "RL" V 4200 4200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 4200 60  0001 C CNN
F 3 "" H 4100 4200 60  0000 C CNN
	1    4100 4200
	-1   0    0    1   
$EndComp
Text GLabel 4300 3500 2    60   Input ~ 0
RA
Text GLabel 4300 3800 2    60   Input ~ 0
LL
Text GLabel 4300 4200 2    60   Input ~ 0
RL
Text GLabel 5100 3500 0    60   Input ~ 0
RA
Text GLabel 5100 3700 0    60   Input ~ 0
LL
Text GLabel 9250 3500 2    60   Input ~ 0
OUT
Text GLabel 8500 4700 2    60   Input ~ 0
RL
$Comp
L R R8
U 1 1 55C7F643
P 8250 4700
F 0 "R8" V 8330 4700 50  0000 C CNN
F 1 "100k" V 8250 4700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 8180 4700 30  0001 C CNN
F 3 "" H 8250 4700 30  0000 C CNN
	1    8250 4700
	0    1    1    0   
$EndComp
$Comp
L CONN_01X01 P4
U 1 1 55C807C4
P 4100 4550
F 0 "P4" H 4100 4650 50  0000 C CNN
F 1 "OUT" V 4200 4550 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 4550 60  0001 C CNN
F 3 "" H 4100 4550 60  0000 C CNN
	1    4100 4550
	-1   0    0    1   
$EndComp
Text GLabel 4300 4550 2    60   Input ~ 0
OUT
$Comp
L CONN_01X01 P5
U 1 1 55C80DB4
P 4100 4900
F 0 "P5" H 4100 5000 50  0000 C CNN
F 1 "5V" V 4200 4900 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 4900 60  0001 C CNN
F 3 "" H 4100 4900 60  0000 C CNN
	1    4100 4900
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X01 P6
U 1 1 55C80E41
P 4100 5250
F 0 "P6" H 4100 5350 50  0000 C CNN
F 1 "GND" V 4200 5250 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 5250 60  0001 C CNN
F 3 "" H 4100 5250 60  0000 C CNN
	1    4100 5250
	-1   0    0    1   
$EndComp
Text GLabel 4300 4900 2    60   Input ~ 0
Alimentacion
$Comp
L GND #PWR015
U 1 1 55C81083
P 4400 5350
F 0 "#PWR015" H 4400 5100 50  0001 C CNN
F 1 "GND" H 4400 5200 50  0000 C CNN
F 2 "" H 4400 5350 60  0000 C CNN
F 3 "" H 4400 5350 60  0000 C CNN
	1    4400 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 3900 5400 4000
Wire Wire Line
	5500 4000 5500 3900
Wire Wire Line
	5600 3900 5600 3950
Wire Wire Line
	5600 3950 5700 3950
Wire Wire Line
	5700 3950 5700 4000
Wire Wire Line
	5400 3300 5400 3200
Wire Wire Line
	5500 4300 5500 4700
Wire Wire Line
	5500 4400 5700 4400
Wire Wire Line
	5700 4400 5700 4300
Wire Wire Line
	5500 4700 5750 4700
Connection ~ 5500 4400
Wire Wire Line
	5750 4900 5750 5200
Wire Wire Line
	5750 5200 6600 5200
Wire Wire Line
	6600 5200 6600 4400
Wire Wire Line
	6450 4800 6750 4800
Wire Wire Line
	6000 5350 6000 5100
Connection ~ 6600 4800
Wire Wire Line
	7050 4800 7250 4800
Wire Wire Line
	7100 3850 7350 3850
Wire Wire Line
	7100 4050 7400 4050
Wire Wire Line
	7600 4050 7950 4050
Wire Wire Line
	7950 3850 7950 4700
Wire Wire Line
	7950 3850 7650 3850
Connection ~ 7950 4050
Wire Wire Line
	5600 3300 5600 2950
Wire Wire Line
	5850 2850 6200 2850
Connection ~ 6100 2850
Wire Wire Line
	6400 2250 6100 2250
Wire Wire Line
	6900 2250 6600 2250
Wire Wire Line
	6100 2250 6100 2850
Wire Wire Line
	6900 2750 6900 2250
Wire Wire Line
	5900 3600 7450 3600
Wire Wire Line
	7350 3600 7350 2750
Wire Wire Line
	7350 2750 7300 2750
Wire Wire Line
	7000 2750 6900 2750
Connection ~ 7350 3600
Wire Wire Line
	7100 3850 7100 4800
Connection ~ 7100 4800
Connection ~ 7100 4050
Wire Wire Line
	7250 4600 7250 4500
Wire Wire Line
	7750 3600 8250 3600
Connection ~ 9000 2500
Wire Wire Line
	8450 2000 8450 2200
Wire Wire Line
	8450 2400 8450 2500
Wire Wire Line
	8050 2500 9500 2500
Wire Wire Line
	9000 3500 9000 4500
Wire Wire Line
	8950 3500 9250 3500
Wire Wire Line
	9000 1550 9000 1700
Connection ~ 9000 1650
Connection ~ 9000 3500
Wire Wire Line
	7950 4700 8100 4700
Wire Wire Line
	8400 4700 8500 4700
Wire Wire Line
	4400 5350 4400 5250
Wire Wire Line
	4400 5250 4300 5250
Wire Wire Line
	5350 2850 5200 2850
Wire Wire Line
	5200 2850 5200 2900
Wire Wire Line
	8500 3200 8500 3100
Wire Wire Line
	7500 4400 7500 4350
Wire Wire Line
	7500 5050 7500 5000
Wire Wire Line
	6000 4500 6000 4450
Wire Wire Line
	6650 2550 6650 2500
Wire Wire Line
	6650 3200 6650 3150
Wire Wire Line
	8500 3900 8500 3800
Wire Wire Line
	9700 1650 9700 1600
Wire Wire Line
	9700 1100 9700 1400
$Comp
L +5V #PWR016
U 1 1 55C7B9CB
P 9700 1100
F 0 "#PWR016" H 9700 950 50  0001 C CNN
F 1 "+5V" H 9700 1240 50  0000 C CNN
F 2 "" H 9700 1100 60  0000 C CNN
F 3 "" H 9700 1100 60  0000 C CNN
	1    9700 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 1650 9700 1650
$Comp
L PWR_FLAG #FLG017
U 1 1 55C8500D
P 9500 2500
F 0 "#FLG017" H 9500 2595 50  0001 C CNN
F 1 "PWR_FLAG" H 9500 2680 50  0000 C CNN
F 2 "" H 9500 2500 60  0000 C CNN
F 3 "" H 9500 2500 60  0000 C CNN
	1    9500 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 2050 8550 2050
Connection ~ 8450 2050
Wire Wire Line
	9000 2400 9000 2550
Wire Wire Line
	9450 2050 9550 2050
Wire Wire Line
	9500 1150 9700 1150
Connection ~ 9700 1150
Wire Wire Line
	8400 1650 8400 1600
Wire Wire Line
	8350 1000 8500 1000
NoConn ~ 9500 1400
$Comp
L REF5050 U4
U 1 1 55C878C4
P 9000 1200
F 0 "U4" H 8700 1500 40  0000 C CNN
F 1 "REF5050" H 9210 1500 40  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 9000 1200 40  0001 C CIN
F 3 "" H 9000 1200 60  0000 C CNN
	1    9000 1200
	1    0    0    -1  
$EndComp
$Comp
L REF3125 U5
U 1 1 55C87BC1
P 9000 2100
F 0 "U5" H 8700 2350 40  0000 C CNN
F 1 "REF3125" H 9000 2300 40  0000 C CNN
F 2 "Housings_SOT-23_SOT-143_TSOT-6:SOT-23_Handsoldering" H 9000 2200 35  0001 C CIN
F 3 "" H 9000 2100 60  0000 C CNN
	1    9000 2100
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG018
U 1 1 55C8812A
P 8450 950
F 0 "#FLG018" H 8450 1045 50  0001 C CNN
F 1 "PWR_FLAG" H 8450 1130 50  0000 C CNN
F 2 "" H 8450 950 60  0000 C CNN
F 3 "" H 8450 950 60  0000 C CNN
	1    8450 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 950  8450 1100
Connection ~ 8450 1000
Wire Wire Line
	8400 1400 8400 1100
Wire Wire Line
	8400 1100 8450 1100
NoConn ~ 8500 1400
$Comp
L JUMPER3 JP2
U 1 1 55C96D6E
P 8150 4250
F 0 "JP2" H 8200 4150 50  0000 L CNN
F 1 "C3/C10" H 8150 4350 50  0000 C BNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 8150 4250 60  0001 C CNN
F 3 "" H 8150 4250 60  0000 C CNN
	1    8150 4250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9000 4500 8650 4500
Wire Wire Line
	8700 4300 9000 4300
Connection ~ 9000 4300
$Comp
L C_Small C10
U 1 1 55C974A6
P 8550 4150
F 0 "C10" H 8560 4220 50  0000 L CNN
F 1 "100n" H 8560 4070 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8550 4150 60  0001 C CNN
F 3 "" H 8550 4150 60  0000 C CNN
	1    8550 4150
	0    1    1    0   
$EndComp
Wire Wire Line
	8650 4150 9000 4150
Connection ~ 9000 4150
Wire Wire Line
	8450 4150 8350 4150
Wire Wire Line
	8350 4150 8350 4000
Wire Wire Line
	8350 4000 8150 4000
Connection ~ 8050 3600
Wire Wire Line
	8450 4500 8150 4500
Wire Wire Line
	8250 4250 8050 4250
Wire Wire Line
	8050 4250 8050 3600
Wire Wire Line
	8400 4300 8250 4300
Wire Wire Line
	8250 4300 8250 4250
$Comp
L C_Small C11
U 1 1 55CA480B
P 8200 2300
F 0 "C11" H 8210 2370 50  0000 L CNN
F 1 "0.1u" H 8210 2220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8200 2300 60  0001 C CNN
F 3 "" H 8200 2300 60  0000 C CNN
	1    8200 2300
	1    0    0    -1  
$EndComp
$Comp
L C_Small C12
U 1 1 55CA4ACA
P 8050 2300
F 0 "C12" H 8060 2370 50  0000 L CNN
F 1 "0.1u" H 8060 2220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8050 2300 60  0001 C CNN
F 3 "" H 8050 2300 60  0000 C CNN
	1    8050 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 2200 8200 2050
Wire Wire Line
	8050 2200 8050 2050
Connection ~ 8200 2050
Wire Wire Line
	8200 2400 8200 2500
Connection ~ 8450 2500
Wire Wire Line
	8050 2400 8050 2500
Connection ~ 8200 2500
$Comp
L CONN_01X01 P7
U 1 1 55CD1DFD
P 4100 3200
F 0 "P7" H 4100 3300 50  0000 C CNN
F 1 "Shield" V 4200 3200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 3200 60  0001 C CNN
F 3 "" H 4100 3200 60  0000 C CNN
	1    4100 3200
	-1   0    0    1   
$EndComp
Text GLabel 4300 3200 2    60   Input ~ 0
SHIELD
Text GLabel 6550 4400 0    60   Input ~ 0
SHIELD
Wire Wire Line
	6600 4400 6550 4400
$Comp
L CONN_01X01 P8
U 1 1 55CD2620
P 4100 2900
F 0 "P8" H 4100 3000 50  0000 C CNN
F 1 "Out_ina" V 4200 2900 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 4100 2900 60  0001 C CNN
F 3 "" H 4100 2900 60  0000 C CNN
	1    4100 2900
	-1   0    0    1   
$EndComp
Text GLabel 4300 2900 2    60   Input ~ 0
INA
Text GLabel 7050 3400 0    60   Input ~ 0
INA
Wire Wire Line
	7050 3400 7150 3400
Wire Wire Line
	7150 3400 7150 3600
Connection ~ 7150 3600
$EndSCHEMATC
