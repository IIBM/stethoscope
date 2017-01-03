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
Sheet 2 3
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
U 1 1 571AB8F3
P 1750 2150
F 0 "U1" H 2050 2400 70  0000 C CNN
F 1 "INA333" H 2150 1900 70  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 1750 2150 60  0001 C CNN
F 3 "" H 1750 2150 60  0000 C CNN
	1    1750 2150
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 571AB8FA
P 1750 2700
F 0 "R2" V 1830 2700 50  0000 C CNN
F 1 "12k" V 1750 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1680 2700 30  0001 C CNN
F 3 "" H 1750 2700 30  0000 C CNN
	1    1750 2700
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 571AB901
P 1950 2700
F 0 "R1" V 2030 2700 50  0000 C CNN
F 1 "12k" V 1950 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1880 2700 30  0001 C CNN
F 3 "" H 1950 2700 30  0000 C CNN
	1    1950 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 571AB908
P 1650 2500
F 0 "#PWR09" H 1650 2250 50  0001 C CNN
F 1 "GND" H 1650 2350 50  0000 C CNN
F 2 "" H 1650 2500 60  0000 C CNN
F 3 "" H 1650 2500 60  0000 C CNN
	1    1650 2500
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR010
U 1 1 571AB90E
P 1650 1800
F 0 "#PWR010" H 1650 1650 50  0001 C CNN
F 1 "+5V" H 1650 1940 50  0000 C CNN
F 2 "" H 1650 1800 60  0000 C CNN
F 3 "" H 1650 1800 60  0000 C CNN
	1    1650 1800
	1    0    0    -1  
$EndComp
$Comp
L OPA2335 U2
U 1 1 571AB914
P 2350 3350
F 0 "U2" H 2350 3500 60  0000 L CNN
F 1 "OPA2335" H 2350 3200 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 2350 3350 60  0001 C CNN
F 3 "" H 2350 3350 60  0000 C CNN
	1    2350 3350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 571AB91B
P 2250 3700
F 0 "#PWR011" H 2250 3450 50  0001 C CNN
F 1 "GND" H 2250 3550 50  0000 C CNN
F 2 "" H 2250 3700 60  0000 C CNN
F 3 "" H 2250 3700 60  0000 C CNN
	1    2250 3700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR012
U 1 1 571AB921
P 2250 3000
F 0 "#PWR012" H 2250 2850 50  0001 C CNN
F 1 "+5V" H 2250 3140 50  0000 C CNN
F 2 "" H 2250 3000 60  0000 C CNN
F 3 "" H 2250 3000 60  0000 C CNN
	1    2250 3000
	1    0    0    -1  
$EndComp
$Comp
L OPA2335 U2
U 2 1 571AB927
P 3850 3250
F 0 "U2" H 3850 3400 60  0000 L CNN
F 1 "OPA2335" H 3850 3100 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 3850 3250 60  0001 C CNN
F 3 "" H 3850 3250 60  0000 C CNN
	2    3850 3250
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 571AB92E
P 3100 3350
F 0 "R6" V 3180 3350 50  0000 C CNN
F 1 "10k" V 3100 3350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3030 3350 30  0001 C CNN
F 3 "" H 3100 3350 30  0000 C CNN
	1    3100 3350
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR013
U 1 1 571AB935
P 3750 3600
F 0 "#PWR013" H 3750 3350 50  0001 C CNN
F 1 "GND" H 3750 3450 50  0000 C CNN
F 2 "" H 3750 3600 60  0000 C CNN
F 3 "" H 3750 3600 60  0000 C CNN
	1    3750 3600
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR014
U 1 1 571AB93B
P 3750 2950
F 0 "#PWR014" H 3750 2800 50  0001 C CNN
F 1 "+5V" H 3750 3090 50  0000 C CNN
F 2 "" H 3750 2950 60  0000 C CNN
F 3 "" H 3750 2950 60  0000 C CNN
	1    3750 2950
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 571AB941
P 3750 2400
F 0 "R7" V 3830 2400 50  0000 C CNN
F 1 "2.2k" V 3750 2400 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3680 2400 30  0001 C CNN
F 3 "" H 3750 2400 30  0000 C CNN
	1    3750 2400
	0    1    1    0   
$EndComp
$Comp
L C_Small C1
U 1 1 571AB948
P 3750 2600
F 0 "C1" H 3760 2670 50  0000 L CNN
F 1 "10n" H 3760 2520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 3750 2600 60  0001 C CNN
F 3 "" H 3750 2600 60  0000 C CNN
	1    3750 2600
	0    1    1    0   
$EndComp
$Comp
L OPA2335 U3
U 2 1 571AB94F
P 2800 1450
F 0 "U3" H 2800 1600 60  0000 L CNN
F 1 "OPA2335" H 2850 1350 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 2800 1450 60  0001 C CNN
F 3 "" H 2800 1450 60  0000 C CNN
	2    2800 1450
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR015
U 1 1 571AB956
P 2750 1850
F 0 "#PWR015" H 2750 1700 50  0001 C CNN
F 1 "+5V" H 2750 1990 50  0000 C CNN
F 2 "" H 2750 1850 60  0000 C CNN
F 3 "" H 2750 1850 60  0000 C CNN
	1    2750 1850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 571AB95C
P 2750 1100
F 0 "#PWR016" H 2750 850 50  0001 C CNN
F 1 "GND" H 2750 950 50  0000 C CNN
F 2 "" H 2750 1100 60  0000 C CNN
F 3 "" H 2750 1100 60  0000 C CNN
	1    2750 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C2
U 1 1 571AB962
P 2750 850
F 0 "C2" H 2760 920 50  0000 L CNN
F 1 "1u" H 2760 770 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2750 850 60  0001 C CNN
F 3 "" H 2750 850 60  0000 C CNN
	1    2750 850 
	0    -1   -1   0   
$EndComp
$Comp
L R R5
U 1 1 571AB969
P 3400 1350
F 0 "R5" V 3480 1350 50  0000 C CNN
F 1 "330k" V 3400 1350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3330 1350 30  0001 C CNN
F 3 "" H 3400 1350 30  0000 C CNN
	1    3400 1350
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 571AB970
P 4050 2150
F 0 "R3" V 4130 2150 50  0000 C CNN
F 1 "4.7k" V 4050 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3980 2150 30  0001 C CNN
F 3 "" H 4050 2150 30  0000 C CNN
	1    4050 2150
	0    1    1    0   
$EndComp
$Comp
L OPA2335 U3
U 1 1 571AB977
P 4850 2050
F 0 "U3" H 4850 2200 60  0000 L CNN
F 1 "OPA2335" H 4850 1900 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 4850 2050 60  0001 C CNN
F 3 "" H 4850 2050 60  0000 C CNN
	1    4850 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 571AB97E
P 4750 2400
F 0 "#PWR017" H 4750 2150 50  0001 C CNN
F 1 "GND" H 4750 2250 50  0000 C CNN
F 2 "" H 4750 2400 60  0000 C CNN
F 3 "" H 4750 2400 60  0000 C CNN
	1    4750 2400
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR018
U 1 1 571AB984
P 4750 1700
F 0 "#PWR018" H 4750 1550 50  0001 C CNN
F 1 "+5V" H 4750 1840 50  0000 C CNN
F 2 "" H 4750 1700 60  0000 C CNN
F 3 "" H 4750 1700 60  0000 C CNN
	1    4750 1700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR019
U 1 1 571AB98A
P 5400 850
F 0 "#PWR019" H 5400 700 50  0001 C CNN
F 1 "+5V" H 5400 990 50  0000 C CNN
F 2 "" H 5400 850 60  0000 C CNN
F 3 "" H 5400 850 60  0000 C CNN
	1    5400 850 
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 571AB990
P 4750 2700
F 0 "R4" V 4830 2700 50  0000 C CNN
F 1 "1M" V 4750 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4680 2700 30  0001 C CNN
F 3 "" H 4750 2700 30  0000 C CNN
	1    4750 2700
	0    1    1    0   
$EndComp
$Comp
L C_Small C3
U 1 1 571AB997
P 4750 2900
F 0 "C3" H 4760 2970 50  0000 L CNN
F 1 "1n" H 4760 2820 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 4750 2900 60  0001 C CNN
F 3 "" H 4750 2900 60  0000 C CNN
	1    4750 2900
	0    1    1    0   
$EndComp
$Comp
L R R8
U 1 1 571AB99E
P 4500 3250
F 0 "R8" V 4580 3250 50  0000 C CNN
F 1 "100k" V 4500 3250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4430 3250 30  0001 C CNN
F 3 "" H 4500 3250 30  0000 C CNN
	1    4500 3250
	0    1    1    0   
$EndComp
Text Label 3350 3600 0    60   ~ 0
filtro
Text Label 3400 1550 2    60   ~ 0
REF
Text Label 4300 1950 0    60   ~ 0
REF
Text Label 3550 3050 2    60   ~ 0
REF
Text Notes 1000 900  0    79   ~ 16
Canal 1
Text Label 2800 2950 2    60   ~ 0
SHIELD
$Comp
L C C12
U 1 1 571AB9F9
P 5150 1100
F 0 "C12" H 5175 1200 50  0000 L CNN
F 1 "0.1u" H 5175 1000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5188 950 50  0001 C CNN
F 3 "" H 5150 1100 50  0000 C CNN
	1    5150 1100
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 571ABA00
P 5400 1100
F 0 "C11" H 5425 1200 50  0000 L CNN
F 1 "0.1u" H 5425 1000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5438 950 50  0001 C CNN
F 3 "" H 5400 1100 50  0000 C CNN
	1    5400 1100
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 571ABA07
P 5650 1100
F 0 "C4" H 5675 1200 50  0000 L CNN
F 1 "0.1u" H 5675 1000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5688 950 50  0001 C CNN
F 3 "" H 5650 1100 50  0000 C CNN
	1    5650 1100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR020
U 1 1 571ABA13
P 5400 1350
F 0 "#PWR020" H 5400 1100 50  0001 C CNN
F 1 "GND" H 5400 1200 50  0000 C CNN
F 2 "" H 5400 1350 60  0000 C CNN
F 3 "" H 5400 1350 60  0000 C CNN
	1    5400 1350
	1    0    0    -1  
$EndComp
Text Notes 4400 950  0    60   ~ 0
Colocar cerca de la\nalimentación de los\nintegrados
$Comp
L R R24
U 1 1 571ABA1E
P 1850 3100
F 0 "R24" V 1930 3100 50  0000 C CNN
F 1 "100k" V 1850 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1780 3100 30  0001 C CNN
F 3 "" H 1850 3100 30  0000 C CNN
	1    1850 3100
	1    0    0    -1  
$EndComp
$Comp
L INA333 U6
U 1 1 571ABEF7
P 1750 5700
F 0 "U6" H 2050 5950 70  0000 C CNN
F 1 "INA333" H 2150 5450 70  0000 C CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 1750 5700 60  0001 C CNN
F 3 "" H 1750 5700 60  0000 C CNN
	1    1750 5700
	1    0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 571ABEFE
P 1750 6250
F 0 "R9" V 1830 6250 50  0000 C CNN
F 1 "12k" V 1750 6250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1680 6250 30  0001 C CNN
F 3 "" H 1750 6250 30  0000 C CNN
	1    1750 6250
	1    0    0    -1  
$EndComp
$Comp
L R R10
U 1 1 571ABF05
P 1950 6250
F 0 "R10" V 2030 6250 50  0000 C CNN
F 1 "12k" V 1950 6250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1880 6250 30  0001 C CNN
F 3 "" H 1950 6250 30  0000 C CNN
	1    1950 6250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 571ABF0C
P 1650 6050
F 0 "#PWR021" H 1650 5800 50  0001 C CNN
F 1 "GND" H 1650 5900 50  0000 C CNN
F 2 "" H 1650 6050 60  0000 C CNN
F 3 "" H 1650 6050 60  0000 C CNN
	1    1650 6050
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR022
U 1 1 571ABF12
P 1650 5350
F 0 "#PWR022" H 1650 5200 50  0001 C CNN
F 1 "+5V" H 1650 5490 50  0000 C CNN
F 2 "" H 1650 5350 60  0000 C CNN
F 3 "" H 1650 5350 60  0000 C CNN
	1    1650 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR023
U 1 1 571ABF18
P 2850 7050
F 0 "#PWR023" H 2850 6800 50  0001 C CNN
F 1 "GND" H 2850 6900 50  0000 C CNN
F 2 "" H 2850 7050 60  0000 C CNN
F 3 "" H 2850 7050 60  0000 C CNN
	1    2850 7050
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR024
U 1 1 571ABF1E
P 2850 6350
F 0 "#PWR024" H 2850 6200 50  0001 C CNN
F 1 "+5V" H 2850 6490 50  0000 C CNN
F 2 "" H 2850 6350 60  0000 C CNN
F 3 "" H 2850 6350 60  0000 C CNN
	1    2850 6350
	1    0    0    -1  
$EndComp
$Comp
L R R12
U 1 1 571ABF24
P 3700 6700
F 0 "R12" V 3780 6700 50  0000 C CNN
F 1 "10k" V 3700 6700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3630 6700 30  0001 C CNN
F 3 "" H 3700 6700 30  0000 C CNN
	1    3700 6700
	0    -1   -1   0   
$EndComp
$Comp
L OPA2335 U7
U 2 1 571ABF2B
P 2800 4950
F 0 "U7" H 2800 5100 60  0000 L CNN
F 1 "OPA2335" H 2850 4850 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 2800 4950 60  0001 C CNN
F 3 "" H 2800 4950 60  0000 C CNN
	2    2800 4950
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR025
U 1 1 571ABF32
P 2750 5350
F 0 "#PWR025" H 2750 5200 50  0001 C CNN
F 1 "+5V" H 2750 5490 50  0000 C CNN
F 2 "" H 2750 5350 60  0000 C CNN
F 3 "" H 2750 5350 60  0000 C CNN
	1    2750 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 571ABF38
P 2750 4600
F 0 "#PWR026" H 2750 4350 50  0001 C CNN
F 1 "GND" H 2750 4450 50  0000 C CNN
F 2 "" H 2750 4600 60  0000 C CNN
F 3 "" H 2750 4600 60  0000 C CNN
	1    2750 4600
	1    0    0    -1  
$EndComp
$Comp
L C_Small C7
U 1 1 571ABF3E
P 2750 4350
F 0 "C7" H 2760 4420 50  0000 L CNN
F 1 "1u" H 2760 4270 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2750 4350 60  0001 C CNN
F 3 "" H 2750 4350 60  0000 C CNN
	1    2750 4350
	0    -1   -1   0   
$EndComp
$Comp
L R R11
U 1 1 571ABF45
P 3400 4850
F 0 "R11" V 3480 4850 50  0000 C CNN
F 1 "330k" V 3400 4850 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3330 4850 30  0001 C CNN
F 3 "" H 3400 4850 30  0000 C CNN
	1    3400 4850
	0    1    1    0   
$EndComp
$Comp
L R R13
U 1 1 571ABF4C
P 3850 5700
F 0 "R13" V 3930 5700 50  0000 C CNN
F 1 "4.7k" V 3850 5700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3780 5700 30  0001 C CNN
F 3 "" H 3850 5700 30  0000 C CNN
	1    3850 5700
	0    1    1    0   
$EndComp
$Comp
L OPA2335 U7
U 1 1 571ABF53
P 4850 5600
F 0 "U7" H 4850 5750 60  0000 L CNN
F 1 "OPA2335" H 4850 5450 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 4850 5600 60  0001 C CNN
F 3 "" H 4850 5600 60  0000 C CNN
	1    4850 5600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 571ABF5A
P 4750 5950
F 0 "#PWR027" H 4750 5700 50  0001 C CNN
F 1 "GND" H 4750 5800 50  0000 C CNN
F 2 "" H 4750 5950 60  0000 C CNN
F 3 "" H 4750 5950 60  0000 C CNN
	1    4750 5950
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR028
U 1 1 571ABF60
P 4750 5250
F 0 "#PWR028" H 4750 5100 50  0001 C CNN
F 1 "+5V" H 4750 5390 50  0000 C CNN
F 2 "" H 4750 5250 60  0000 C CNN
F 3 "" H 4750 5250 60  0000 C CNN
	1    4750 5250
	1    0    0    -1  
$EndComp
$Comp
L R R14
U 1 1 571ABF66
P 4750 6250
F 0 "R14" V 4830 6250 50  0000 C CNN
F 1 "1M" V 4750 6250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4680 6250 30  0001 C CNN
F 3 "" H 4750 6250 30  0000 C CNN
	1    4750 6250
	0    1    1    0   
$EndComp
$Comp
L C_Small C8
U 1 1 571ABF6D
P 4750 6450
F 0 "C8" H 4760 6520 50  0000 L CNN
F 1 "1n" H 4760 6370 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 4750 6450 60  0001 C CNN
F 3 "" H 4750 6450 60  0000 C CNN
	1    4750 6450
	0    1    1    0   
$EndComp
$Comp
L Jumper_NC_Small JP2
U 1 1 571ABFA1
P 4000 6700
F 0 "JP2" H 4000 6780 50  0000 C CNN
F 1 "Jumper" H 4010 6640 50  0001 C CNN
F 2 "jumper_smd:jumper_smd" H 4000 6700 50  0001 C CNN
F 3 "" H 4000 6700 50  0000 C CNN
	1    4000 6700
	1    0    0    -1  
$EndComp
$Comp
L Jumper_NC_Small JP1
U 1 1 571ABFA8
P 2000 6600
F 0 "JP1" H 2000 6680 50  0000 C CNN
F 1 "Jumper" H 2010 6540 50  0001 C CNN
F 2 "jumper_smd:jumper_smd" H 2000 6600 50  0001 C CNN
F 3 "" H 2000 6600 50  0000 C CNN
	1    2000 6600
	1    0    0    -1  
$EndComp
Text Label 4350 6700 2    60   ~ 0
filtro
Text Label 3350 5050 2    60   ~ 0
REF
Text Label 4300 5500 0    60   ~ 0
REF
Text Notes 1000 4400 0    79   ~ 16
Canal 2
$Comp
L OPA2335 U8
U 1 1 571ABFC1
P 2950 6700
F 0 "U8" H 2950 6850 60  0000 L CNN
F 1 "OPA2335" H 2950 6550 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 2950 6700 60  0001 C CNN
F 3 "" H 2950 6700 60  0000 C CNN
	1    2950 6700
	1    0    0    -1  
$EndComp
Text Notes 3650 7050 0    60   ~ 0
Los jumper son pads que\nse unen con estaño
$Comp
L +5V #PWR029
U 1 1 571ABFCB
P 5400 4400
F 0 "#PWR029" H 5400 4250 50  0001 C CNN
F 1 "+5V" H 5400 4540 50  0000 C CNN
F 2 "" H 5400 4400 60  0000 C CNN
F 3 "" H 5400 4400 60  0000 C CNN
	1    5400 4400
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 571ABFD6
P 5150 4600
F 0 "C9" H 5175 4700 50  0000 L CNN
F 1 "0.1u" H 5175 4500 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5188 4450 50  0001 C CNN
F 3 "" H 5150 4600 50  0000 C CNN
	1    5150 4600
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 571ABFDD
P 5400 4600
F 0 "C10" H 5425 4700 50  0000 L CNN
F 1 "0.1u" H 5425 4500 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5438 4450 50  0001 C CNN
F 3 "" H 5400 4600 50  0000 C CNN
	1    5400 4600
	1    0    0    -1  
$EndComp
$Comp
L C C13
U 1 1 571ABFE4
P 5650 4600
F 0 "C13" H 5675 4700 50  0000 L CNN
F 1 "0.1u" H 5675 4500 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5688 4450 50  0001 C CNN
F 3 "" H 5650 4600 50  0000 C CNN
	1    5650 4600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR030
U 1 1 571ABFED
P 5400 4850
F 0 "#PWR030" H 5400 4600 50  0001 C CNN
F 1 "GND" H 5400 4700 50  0000 C CNN
F 2 "" H 5400 4850 60  0000 C CNN
F 3 "" H 5400 4850 60  0000 C CNN
	1    5400 4850
	1    0    0    -1  
$EndComp
Text Notes 4400 4500 0    60   ~ 0
Colocar cerca de la\nalimentación de los\nintegrados
$Comp
L R R25
U 1 1 571ABFF8
P 2350 6600
F 0 "R25" V 2430 6600 50  0000 C CNN
F 1 "100k" V 2350 6600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 2280 6600 30  0001 C CNN
F 3 "" H 2350 6600 30  0000 C CNN
	1    2350 6600
	0    1    1    0   
$EndComp
$Comp
L OPA2335 U8
U 2 1 571AF7AE
P 10100 5500
F 0 "U8" H 10100 5650 60  0000 L CNN
F 1 "OPA2335" H 10100 5350 60  0000 L CNN
F 2 "Housings_SSOP:MSOP-8_3x3mm_Pitch0.65mm" H 10100 5500 60  0001 C CNN
F 3 "" H 10100 5500 60  0000 C CNN
	2    10100 5500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR031
U 1 1 571AF7BA
P 9600 5450
F 0 "#PWR031" H 9600 5200 50  0001 C CNN
F 1 "GND" H 9600 5300 50  0000 C CNN
F 2 "" H 9600 5450 60  0000 C CNN
F 3 "" H 9600 5450 60  0000 C CNN
	1    9600 5450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR032
U 1 1 571AF7C2
P 10000 5150
F 0 "#PWR032" H 10000 5000 50  0001 C CNN
F 1 "+5V" H 10000 5290 50  0000 C CNN
F 2 "" H 10000 5150 60  0000 C CNN
F 3 "" H 10000 5150 60  0000 C CNN
	1    10000 5150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR033
U 1 1 571AF7C8
P 10000 5850
F 0 "#PWR033" H 10000 5600 50  0001 C CNN
F 1 "GND" H 10000 5700 50  0000 C CNN
F 2 "" H 10000 5850 60  0000 C CNN
F 3 "" H 10000 5850 60  0000 C CNN
	1    10000 5850
	1    0    0    -1  
$EndComp
Text Notes 10250 5200 0    60   ~ 0
OpAmp\nsobrante
Text HLabel 1300 2050 0    60   Input ~ 0
RA_ch1
Text HLabel 1300 2250 0    60   Input ~ 0
LA_ch1
Text HLabel 1300 5600 0    60   Input ~ 0
RA_ch2
Text HLabel 1300 5800 0    60   Input ~ 0
LA_ch2
Text HLabel 5950 2050 2    60   Input ~ 0
OUT_ch1
Text HLabel 5900 5600 2    60   Input ~ 0
OUT_ch2
Text HLabel 3400 1550 2    60   Input ~ 0
REF
Text HLabel 2900 2950 2    60   Input ~ 0
SHIELD
Wire Wire Line
	1650 2450 1650 2500
Wire Wire Line
	1750 2550 1750 2450
Wire Wire Line
	1850 2450 1850 2500
Wire Wire Line
	1850 2500 1950 2500
Wire Wire Line
	1950 2500 1950 2550
Wire Wire Line
	1650 1850 1650 1800
Wire Wire Line
	1750 2900 1950 2900
Wire Wire Line
	1950 2900 1950 2850
Wire Wire Line
	2000 3450 2000 3900
Wire Wire Line
	2000 3900 2850 3900
Wire Wire Line
	2700 3350 2950 3350
Wire Wire Line
	2250 3700 2250 3650
Connection ~ 2850 3350
Wire Wire Line
	3250 3350 3500 3350
Wire Wire Line
	3350 2400 3600 2400
Wire Wire Line
	3350 2600 3650 2600
Wire Wire Line
	3850 2600 4200 2600
Wire Wire Line
	4200 2400 4200 3250
Wire Wire Line
	4200 2400 3900 2400
Connection ~ 4200 2600
Wire Wire Line
	1850 1450 1850 1850
Wire Wire Line
	1850 1450 2450 1450
Connection ~ 2350 1450
Wire Wire Line
	2650 850  2350 850 
Wire Wire Line
	3150 850  2850 850 
Wire Wire Line
	2350 850  2350 1450
Wire Wire Line
	3150 1350 3150 850 
Wire Wire Line
	2150 2150 3900 2150
Wire Wire Line
	3800 2150 3800 1350
Wire Wire Line
	3800 1350 3550 1350
Wire Wire Line
	3250 1350 3150 1350
Connection ~ 3800 2150
Wire Wire Line
	3350 2400 3350 3600
Connection ~ 3350 3350
Connection ~ 3350 2600
Wire Wire Line
	4200 2150 4500 2150
Connection ~ 5250 2050
Wire Wire Line
	4200 3250 4350 3250
Wire Wire Line
	4650 3250 4950 3250
Wire Wire Line
	4750 1750 4750 1700
Wire Wire Line
	3750 2950 3750 2950
Wire Wire Line
	3750 3600 3750 3550
Wire Wire Line
	2250 3050 2250 3000
Wire Wire Line
	2900 1150 2900 1100
Wire Wire Line
	2900 1750 2900 1850
Wire Wire Line
	4750 2400 4750 2350
Connection ~ 5250 2700
Connection ~ 4300 2150
Wire Wire Line
	4300 2150 4300 2900
Connection ~ 5400 900 
Wire Wire Line
	2800 2950 2900 2950
Wire Wire Line
	5150 900  5150 950 
Wire Wire Line
	5400 850  5400 950 
Wire Wire Line
	4600 2700 4300 2700
Connection ~ 4300 2700
Wire Wire Line
	4900 2700 5250 2700
Wire Wire Line
	5250 2900 4850 2900
Wire Wire Line
	4300 2900 4650 2900
Wire Wire Line
	5250 2050 5250 2900
Wire Wire Line
	1750 2850 1750 2900
Wire Wire Line
	1850 3250 2000 3250
Wire Wire Line
	4300 1950 4500 1950
Wire Wire Line
	3400 3150 3500 3150
Wire Wire Line
	3550 3050 3400 3050
Wire Wire Line
	3400 3050 3400 3150
Wire Wire Line
	2900 1100 2750 1100
Wire Wire Line
	5150 900  5650 900 
Wire Wire Line
	5650 900  5650 950 
Wire Wire Line
	5150 1250 5150 1300
Wire Wire Line
	5150 1300 5650 1300
Wire Wire Line
	5650 1300 5650 1250
Wire Wire Line
	5400 1250 5400 1350
Connection ~ 5400 1300
Wire Wire Line
	2900 1850 2750 1850
Wire Wire Line
	3400 1550 3150 1550
Wire Wire Line
	1850 2950 1850 2900
Connection ~ 1850 2900
Wire Wire Line
	1650 6000 1650 6050
Wire Wire Line
	1750 6100 1750 6000
Wire Wire Line
	1850 6000 1850 6050
Wire Wire Line
	1850 6050 1950 6050
Wire Wire Line
	1950 6050 1950 6100
Wire Wire Line
	1650 5400 1650 5350
Wire Wire Line
	1950 6500 1950 6400
Wire Wire Line
	2600 6800 2600 7300
Wire Wire Line
	2600 7300 3450 7300
Wire Wire Line
	3300 6700 3550 6700
Wire Wire Line
	2850 7050 2850 7000
Connection ~ 3450 6700
Wire Wire Line
	1850 4950 1850 5400
Wire Wire Line
	1850 4950 2450 4950
Connection ~ 2350 4950
Wire Wire Line
	2650 4350 2350 4350
Wire Wire Line
	3150 4350 2850 4350
Wire Wire Line
	2350 4350 2350 4950
Wire Wire Line
	3150 4850 3150 4350
Wire Wire Line
	2150 5700 3700 5700
Wire Wire Line
	3600 5700 3600 4850
Wire Wire Line
	3600 4850 3550 4850
Wire Wire Line
	3250 4850 3150 4850
Connection ~ 3600 5700
Wire Wire Line
	4000 5700 4500 5700
Connection ~ 5250 5600
Wire Wire Line
	4750 5300 4750 5250
Wire Wire Line
	2850 6400 2850 6350
Wire Wire Line
	2900 4650 2900 4600
Wire Wire Line
	2900 5250 2900 5350
Wire Wire Line
	4750 5950 4750 5900
Connection ~ 5250 6250
Connection ~ 4300 5700
Wire Wire Line
	4300 5700 4300 6450
Wire Wire Line
	4600 6250 4300 6250
Connection ~ 4300 6250
Wire Wire Line
	4900 6250 5250 6250
Wire Wire Line
	5250 6450 4850 6450
Wire Wire Line
	4300 6450 4650 6450
Wire Wire Line
	5250 5600 5250 6450
Wire Wire Line
	1750 6500 1950 6500
Wire Wire Line
	1750 6500 1750 6400
Wire Wire Line
	1850 6500 1850 6600
Connection ~ 1850 6500
Wire Wire Line
	1850 6600 1900 6600
Wire Wire Line
	3850 6700 3900 6700
Wire Wire Line
	4100 6700 4350 6700
Wire Wire Line
	4300 5500 4500 5500
Wire Wire Line
	3350 5050 3150 5050
Wire Wire Line
	3450 7300 3450 6700
Wire Wire Line
	2900 4600 2750 4600
Connection ~ 5400 4400
Connection ~ 5400 4850
Wire Wire Line
	5150 4400 5150 4450
Wire Wire Line
	5150 4750 5150 4850
Wire Wire Line
	5650 4850 5650 4750
Wire Wire Line
	5150 4400 5650 4400
Wire Wire Line
	5150 4850 5650 4850
Wire Wire Line
	5650 4400 5650 4450
Wire Wire Line
	5400 4850 5400 4750
Wire Wire Line
	5400 4400 5400 4450
Wire Wire Line
	2900 5350 2750 5350
Wire Wire Line
	2100 6600 2200 6600
Wire Wire Line
	2500 6600 2600 6600
Wire Wire Line
	9750 5600 9700 5600
Wire Wire Line
	9700 5600 9700 6050
Wire Wire Line
	9700 6050 10550 6050
Wire Wire Line
	10550 6050 10550 5500
Wire Wire Line
	10550 5500 10450 5500
Wire Wire Line
	9600 5450 9600 5400
Wire Wire Line
	9600 5400 9750 5400
Wire Wire Line
	10000 5800 10000 5850
Wire Wire Line
	10000 5200 10000 5150
Wire Wire Line
	1300 2050 1350 2050
Wire Wire Line
	1300 2250 1350 2250
Wire Wire Line
	1350 5600 1300 5600
Wire Wire Line
	1350 5800 1300 5800
Wire Wire Line
	5350 5600 5200 5600
Wire Wire Line
	5200 2050 5400 2050
Connection ~ 2850 2950
Wire Wire Line
	2850 3900 2850 2950
Text HLabel 4950 3250 2    60   Input ~ 0
RL
$Comp
L R R16
U 1 1 571BA57D
P 5550 2050
F 0 "R16" V 5630 2050 50  0000 C CNN
F 1 "2.2k" V 5550 2050 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5480 2050 30  0001 C CNN
F 3 "" H 5550 2050 30  0000 C CNN
	1    5550 2050
	0    1    1    0   
$EndComp
$Comp
L R R27
U 1 1 571BA61B
P 5800 2300
F 0 "R27" V 5880 2300 50  0000 C CNN
F 1 "4.3k" V 5800 2300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5730 2300 30  0001 C CNN
F 3 "" H 5800 2300 30  0000 C CNN
	1    5800 2300
	-1   0    0    1   
$EndComp
Wire Wire Line
	5700 2050 5950 2050
Wire Wire Line
	5800 2050 5800 2150
$Comp
L GND #PWR034
U 1 1 571BAAEF
P 5800 2500
F 0 "#PWR034" H 5800 2250 50  0001 C CNN
F 1 "GND" H 5800 2350 50  0000 C CNN
F 2 "" H 5800 2500 60  0000 C CNN
F 3 "" H 5800 2500 60  0000 C CNN
	1    5800 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2450 5800 2500
Connection ~ 5800 2050
$Comp
L R R15
U 1 1 571BBF36
P 5500 5600
F 0 "R15" V 5580 5600 50  0000 C CNN
F 1 "2.2k" V 5500 5600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5430 5600 30  0001 C CNN
F 3 "" H 5500 5600 30  0000 C CNN
	1    5500 5600
	0    1    1    0   
$EndComp
$Comp
L R R26
U 1 1 571BBF3C
P 5750 5850
F 0 "R26" V 5830 5850 50  0000 C CNN
F 1 "4.3k" V 5750 5850 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5680 5850 30  0001 C CNN
F 3 "" H 5750 5850 30  0000 C CNN
	1    5750 5850
	-1   0    0    1   
$EndComp
Wire Wire Line
	5650 5600 5900 5600
Wire Wire Line
	5750 5600 5750 5700
$Comp
L GND #PWR035
U 1 1 571BBF44
P 5750 6050
F 0 "#PWR035" H 5750 5800 50  0001 C CNN
F 1 "GND" H 5750 5900 50  0000 C CNN
F 2 "" H 5750 6050 60  0000 C CNN
F 3 "" H 5750 6050 60  0000 C CNN
	1    5750 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 6000 5750 6050
Connection ~ 5750 5600
$EndSCHEMATC