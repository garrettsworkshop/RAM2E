EESchema Schematic File Version 4
LIBS:RAM2E-cache
EELAYER 26 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 2
Title "RAM2E"
Date "2019-10-13"
Rev "0.9"
Comp "Garrett's Workshop"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C_Small C4
U 1 1 5C4F04D1
P 2100 7500
F 0 "C4" H 2150 7550 50  0000 L CNN
F 1 "10u" H 2150 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 2100 7500 50  0001 C CNN
F 3 "~" H 2100 7500 50  0001 C CNN
	1    2100 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 5CB37AA0
P 2500 7500
F 0 "C5" H 2550 7550 50  0000 L CNN
F 1 "10u" H 2550 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 2500 7500 50  0001 C CNN
F 3 "~" H 2500 7500 50  0001 C CNN
	1    2500 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C7
U 1 1 5CB37AAE
P 3300 7500
F 0 "C7" H 3350 7550 50  0000 L CNN
F 1 "10u" H 3350 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 3300 7500 50  0001 C CNN
F 3 "~" H 3300 7500 50  0001 C CNN
	1    3300 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 7400 2900 7400
Wire Wire Line
	3300 7400 3700 7400
Wire Wire Line
	3700 7600 3300 7600
Wire Wire Line
	2900 7600 2500 7600
Connection ~ 2500 7400
Connection ~ 2500 7600
$Comp
L Device:C_Small C8
U 1 1 5CC13922
P 3700 7500
F 0 "C8" H 3750 7550 50  0000 L CNN
F 1 "10u" H 3750 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 3700 7500 50  0001 C CNN
F 3 "~" H 3700 7500 50  0001 C CNN
	1    3700 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C6
U 1 1 5D140E8E
P 2900 7500
F 0 "C6" H 2950 7550 50  0000 L CNN
F 1 "10u" H 2950 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 2900 7500 50  0001 C CNN
F 3 "~" H 2900 7500 50  0001 C CNN
	1    2900 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 7400 1700 7400
Wire Wire Line
	1300 7600 1700 7600
$Comp
L Device:C_Small C3
U 1 1 5D14D1AA
P 1700 7500
F 0 "C3" H 1750 7550 50  0000 L CNN
F 1 "10u" H 1750 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 1700 7500 50  0001 C CNN
F 3 "~" H 1700 7500 50  0001 C CNN
	1    1700 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 5D14D1B0
P 1300 7500
F 0 "C2" H 1350 7550 50  0000 L CNN
F 1 "10u" H 1350 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 1300 7500 50  0001 C CNN
F 3 "~" H 1300 7500 50  0001 C CNN
	1    1300 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	900  7600 1300 7600
Wire Wire Line
	1300 7400 900  7400
Connection ~ 1700 7400
Wire Wire Line
	1700 7400 2100 7400
Connection ~ 1700 7600
Wire Wire Line
	1700 7600 2100 7600
Connection ~ 2100 7400
Wire Wire Line
	2100 7400 2500 7400
Connection ~ 2100 7600
Wire Wire Line
	2100 7600 2500 7600
$Comp
L power:GND #PWR0105
U 1 1 5D1550D4
P 4100 7600
F 0 "#PWR0105" H 4100 7350 50  0001 C CNN
F 1 "GND" H 4100 7450 50  0000 C CNN
F 2 "" H 4100 7600 50  0001 C CNN
F 3 "" H 4100 7600 50  0001 C CNN
	1    4100 7600
	1    0    0    -1  
$EndComp
Connection ~ 1300 7400
Connection ~ 1300 7600
Wire Wire Line
	2900 7400 3300 7400
Connection ~ 2900 7400
Connection ~ 3300 7400
Wire Wire Line
	2900 7600 3300 7600
Connection ~ 3300 7600
Connection ~ 2900 7600
Connection ~ 900  7400
$Comp
L power:+5V #PWR0120
U 1 1 5C293BD7
P 900 7400
F 0 "#PWR0120" H 900 7250 50  0001 C CNN
F 1 "+5V" H 900 7550 50  0000 C CNN
F 2 "" H 900 7400 50  0001 C CNN
F 3 "" H 900 7400 50  0001 C CNN
	1    900  7400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 5D136B08
P 900 7500
F 0 "C1" H 950 7550 50  0000 L CNN
F 1 "10u" H 950 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 900 7500 50  0001 C CNN
F 3 "~" H 900 7500 50  0001 C CNN
	1    900  7500
	1    0    0    -1  
$EndComp
Text Label 7700 3250 0    50   ~ 0
MA5
Text Label 7700 3350 0    50   ~ 0
MA3
Text Label 7700 3450 0    50   ~ 0
MA1
Text Label 7700 3150 0    50   ~ 0
MA6
Text Label 7700 3050 0    50   ~ 0
MA4
Text Label 7700 2950 0    50   ~ 0
MA2
Text Label 7700 3550 0    50   ~ 0
MA7
Text Label 7700 3650 0    50   ~ 0
RA8
Text Label 7700 3750 0    50   ~ 0
RA9
Text Label 7700 2850 0    50   ~ 0
MA0
Text Label 6900 3950 2    50   ~ 0
R~WE~
$Comp
L power:GND #PWR0157
U 1 1 5C27FF04
P 6900 4050
F 0 "#PWR0157" H 6900 3800 50  0001 C CNN
F 1 "GND" H 6900 3900 50  0000 C CNN
F 2 "" H 6900 4050 50  0001 C CNN
F 3 "" H 6900 4050 50  0001 C CNN
	1    6900 4050
	-1   0    0    -1  
$EndComp
Text Label 6900 2950 2    50   ~ 0
RD0
Text Label 6900 3650 2    50   ~ 0
RD7
Text Label 6900 3850 2    50   ~ 0
~RAS~
Text Label 6900 3750 2    50   ~ 0
~CAS~
Text Label 6900 4050 2    50   ~ 0
~OE~
Text Label 7700 3850 0    50   ~ 0
RA10
Text Label 6900 3250 2    50   ~ 0
RD3
Text Label 6900 3450 2    50   ~ 0
RD5
Text Label 6900 3350 2    50   ~ 0
RD4
Text Label 7700 3950 0    50   ~ 0
RA11
Text Label 6900 3150 2    50   ~ 0
RD2
Text Label 6900 3050 2    50   ~ 0
RD1
Text Label 6900 3550 2    50   ~ 0
RD6
$Comp
L power:GND #PWR0101
U 1 1 5DCDF099
P 7700 4050
F 0 "#PWR0101" H 7700 3800 50  0001 C CNN
F 1 "GND" H 7700 3900 50  0000 C CNN
F 2 "" H 7700 4050 50  0001 C CNN
F 3 "" H 7700 4050 50  0001 C CNN
	1    7700 4050
	-1   0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 5DCDF4F4
P 6900 2850
F 0 "#PWR0102" H 6900 2700 50  0001 C CNN
F 1 "+5V" H 6900 3000 50  0000 C CNN
F 2 "" H 6900 2850 50  0001 C CNN
F 3 "" H 6900 2850 50  0001 C CNN
	1    6900 2850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5800 7350 5800 7650
Text Label 5800 7650 0    50   ~ 0
AN3
Text Label 5800 7350 0    50   ~ 0
~FRCTXT~
Connection ~ 5500 7200
Wire Wire Line
	5500 7200 5200 7200
Wire Wire Line
	5200 7200 4900 7200
Connection ~ 5200 7200
Wire Wire Line
	4900 7200 4600 7200
Connection ~ 4900 7200
$Comp
L power:GND #PWR0132
U 1 1 5CC8BAFD
P 5500 7200
F 0 "#PWR0132" H 5500 6950 50  0001 C CNN
F 1 "GND" H 5505 7027 50  0000 C CNN
F 2 "" H 5500 7200 50  0001 C CNN
F 3 "" H 5500 7200 50  0001 C CNN
	1    5500 7200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 5CC7E0C0
P 5500 7100
F 0 "H4" H 5600 7151 50  0000 L CNN
F 1 " " H 5600 7060 50  0000 L CNN
F 2 "stdpads:PasteHole_1.1mm_PTH" H 5500 7100 50  0001 C CNN
F 3 "~" H 5500 7100 50  0001 C CNN
	1    5500 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 5CC7E0B9
P 5200 7100
F 0 "H3" H 5300 7151 50  0000 L CNN
F 1 " " H 5300 7060 50  0000 L CNN
F 2 "stdpads:PasteHole_1.1mm_PTH" H 5200 7100 50  0001 C CNN
F 3 "~" H 5200 7100 50  0001 C CNN
	1    5200 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 5CC795A2
P 4900 7100
F 0 "H2" H 5000 7151 50  0000 L CNN
F 1 " " H 5000 7060 50  0000 L CNN
F 2 "stdpads:PasteHole_1.1mm_PTH" H 4900 7100 50  0001 C CNN
F 3 "~" H 4900 7100 50  0001 C CNN
	1    4900 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 5CC53461
P 4600 7100
F 0 "H1" H 4700 7151 50  0000 L CNN
F 1 " " H 4700 7060 50  0000 L CNN
F 2 "stdpads:PasteHole_1.1mm_PTH" H 4600 7100 50  0001 C CNN
F 3 "~" H 4600 7100 50  0001 C CNN
	1    4600 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID4
U 1 1 5CC4DBDF
P 5100 7600
F 0 "FID4" H 5200 7646 50  0000 L CNN
F 1 "Fiducial" H 5200 7555 50  0000 L CNN
F 2 "stdpads:Fiducial" H 5100 7600 50  0001 C CNN
F 3 "~" H 5100 7600 50  0001 C CNN
	1    5100 7600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID3
U 1 1 5CC4DBD8
P 4600 7600
F 0 "FID3" H 4700 7646 50  0000 L CNN
F 1 "Fiducial" H 4700 7555 50  0000 L CNN
F 2 "stdpads:Fiducial" H 4600 7600 50  0001 C CNN
F 3 "~" H 4600 7600 50  0001 C CNN
	1    4600 7600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID2
U 1 1 5CC4921D
P 5100 7400
F 0 "FID2" H 5200 7446 50  0000 L CNN
F 1 "Fiducial" H 5200 7355 50  0000 L CNN
F 2 "stdpads:Fiducial" H 5100 7400 50  0001 C CNN
F 3 "~" H 5100 7400 50  0001 C CNN
	1    5100 7400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID1
U 1 1 5CC47A28
P 4600 7400
F 0 "FID1" H 4700 7446 50  0000 L CNN
F 1 "Fiducial" H 4700 7355 50  0000 L CNN
F 2 "stdpads:Fiducial" H 4600 7400 50  0001 C CNN
F 3 "~" H 4600 7400 50  0001 C CNN
	1    4600 7400
	1    0    0    -1  
$EndComp
Text Label 1750 3650 2    50   ~ 0
~PRAS~
Text Label 1750 4850 2    50   ~ 0
MD7
Text Label 2250 3350 0    50   ~ 0
~ENTMG~
Text Label 2250 3450 0    50   ~ 0
C7M
Text Label 2250 3550 0    50   ~ 0
GR
Text Label 2250 3650 0    50   ~ 0
~RA10~
Text Label 2250 3750 0    50   ~ 0
~RA9~
Text Label 2250 3850 0    50   ~ 0
~FRCTXT~
Text Label 2250 3950 0    50   ~ 0
SEGB
Text Label 2250 4050 0    50   ~ 0
Q3
Text Label 2250 4150 0    50   ~ 0
R~W~
Text Label 2250 4250 0    50   ~ 0
MA0
Text Label 2250 4350 0    50   ~ 0
AN3
Text Label 2250 4450 0    50   ~ 0
MA2
Text Label 2250 4550 0    50   ~ 0
MA3
Text Label 2250 4650 0    50   ~ 0
H0
Text Label 2250 4750 0    50   ~ 0
MA6
Text Label 2250 4850 0    50   ~ 0
VD0
Text Label 2250 4950 0    50   ~ 0
MD0
Text Label 2250 5050 0    50   ~ 0
MD1
Text Label 2250 5150 0    50   ~ 0
VD1
Text Label 2250 5250 0    50   ~ 0
VD2
Text Label 2250 5350 0    50   ~ 0
MD2
Text Label 2250 5450 0    50   ~ 0
MD3
Text Label 2250 5550 0    50   ~ 0
VD3
Text Label 2250 5650 0    50   ~ 0
~CASEN~
Text Label 2250 5750 0    50   ~ 0
PHI1
Text Label 2250 5850 0    50   ~ 0
R~W~80
Text Label 2250 5950 0    50   ~ 0
~LDPS~
Text Label 2250 6050 0    50   ~ 0
~PCAS~
Text Label 2250 6150 0    50   ~ 0
C14M
$Comp
L power:GND #PWR0107
U 1 1 5CFDD282
P 2250 6250
F 0 "#PWR0107" H 2250 6000 50  0001 C CNN
F 1 "GND" H 2250 6100 50  0000 C CNN
F 2 "" H 2250 6250 50  0001 C CNN
F 3 "" H 2250 6250 50  0001 C CNN
	1    2250 6250
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 5CFDC1A5
P 1750 6250
F 0 "#PWR0106" H 1750 6100 50  0001 C CNN
F 1 "+5V" V 1750 6400 50  0000 L CNN
F 2 "" H 1750 6250 50  0001 C CNN
F 3 "" H 1750 6250 50  0001 C CNN
	1    1750 6250
	0    -1   -1   0   
$EndComp
Text Label 1750 6150 2    50   ~ 0
~ENVID~
Text Label 1750 6050 2    50   ~ 0
~SEROUT~
Text Label 1750 5950 2    50   ~ 0
~ALTVID~
Text Label 1750 5850 2    50   ~ 0
~EN80~
Text Label 1750 5750 2    50   ~ 0
~80VID~
Text Label 1750 5650 2    50   ~ 0
~CLRGAT~
Text Label 1750 5550 2    50   ~ 0
PHI0
Text Label 1750 5150 2    50   ~ 0
VD5
Text Label 1750 5450 2    50   ~ 0
VD4
Text Label 1750 5350 2    50   ~ 0
MD4
Text Label 1750 5250 2    50   ~ 0
MD5
Text Label 1750 5050 2    50   ~ 0
VD6
Text Label 1750 4950 2    50   ~ 0
MD6
Text Label 1750 4750 2    50   ~ 0
VD7
Text Label 1750 4650 2    50   ~ 0
MA5
Text Label 1750 4550 2    50   ~ 0
MA4
Text Label 1750 4450 2    50   ~ 0
ROMEN2
Text Label 1750 4350 2    50   ~ 0
ROMEN1
Text Label 1750 4250 2    50   ~ 0
MA1
Text Label 1750 4150 2    50   ~ 0
MA7
Text Label 1750 4050 2    50   ~ 0
SEGA
Text Label 1750 3950 2    50   ~ 0
~WNDW~
Text Label 1750 3850 2    50   ~ 0
~C07X~
Text Label 1750 3750 2    50   ~ 0
VC
Text Label 1750 3550 2    50   ~ 0
~SYNC~
Text Label 1750 3450 2    50   ~ 0
Vid7M
Text Label 1750 3350 2    50   ~ 0
C3M58
$Comp
L Connector_Generic:Conn_02x30_Counter_Clockwise J1
U 1 1 5CFB6FE3
P 1950 4750
F 0 "J1" H 2000 6367 50  0000 C CNN
F 1 "AppleIIeAux" H 2000 6276 50  0000 C CNN
F 2 "stdpads:AppleIIeAux_Edge" H 1950 4750 50  0001 C CNN
F 3 "~" H 1950 4750 50  0001 C CNN
	1    1950 4750
	1    0    0    -1  
$EndComp
Text Label 4600 1750 2    50   ~ 0
C3M58
Text Label 4600 1850 2    50   ~ 0
C7M
Wire Wire Line
	6150 2350 6100 2350
Wire Wire Line
	6150 1950 6100 1950
Wire Wire Line
	6100 2050 6150 2050
Wire Wire Line
	6150 2150 6100 2150
Wire Wire Line
	6100 2250 6150 2250
Text Label 4600 1950 2    50   ~ 0
~PRAS~
Wire Wire Line
	4600 2350 4600 2450
Text Label 4600 2350 2    50   ~ 0
Q3
$Comp
L power:+5V #PWR0135
U 1 1 5CBD2E73
P 5700 1350
F 0 "#PWR0135" H 5700 1200 50  0001 C CNN
F 1 "+5V" H 5700 1500 50  0000 C CNN
F 2 "" H 5700 1350 50  0001 C CNN
F 3 "" H 5700 1350 50  0001 C CNN
	1    5700 1350
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 5CBD373F
P 5000 5450
F 0 "#PWR0136" H 5000 5200 50  0001 C CNN
F 1 "GND" H 5000 5300 50  0000 C CNN
F 2 "" H 5000 5450 50  0001 C CNN
F 3 "" H 5000 5450 50  0001 C CNN
	1    5000 5450
	-1   0    0    -1  
$EndComp
Text Label 6100 3450 0    50   ~ 0
RD0
Text Label 6100 3550 0    50   ~ 0
RD1
Text Label 6100 3650 0    50   ~ 0
RD2
Text Label 6100 3750 0    50   ~ 0
RD3
Text Label 6100 2950 0    50   ~ 0
RD4
Text Label 6100 3050 0    50   ~ 0
RD5
Text Label 6100 3150 0    50   ~ 0
RD6
$Comp
L GW_PLD.lib:EPM7128SL84 U1
U 1 1 5CFBB2C9
P 5350 3350
F 0 "U1" H 5350 5531 50  0000 C CNN
F 1 "EPM7128SL84" H 5350 5440 50  0000 C CNN
F 2 "stdpads:PLCC-84" H 5200 3550 50  0001 C CNN
F 3 "" H 5200 3550 50  0001 C CNN
	1    5350 3350
	-1   0    0    -1  
$EndComp
Text Label 6100 3950 0    50   ~ 0
~RAS~
Text Label 6100 2850 0    50   ~ 0
~CAS~
Text Label 6100 4150 0    50   ~ 0
RA8
Text Label 6100 4050 0    50   ~ 0
RA9
Text Label 6100 2650 0    50   ~ 0
RA10
Text Label 6100 3850 0    50   ~ 0
R~WE~
Text Label 4600 2750 2    50   ~ 0
~PCAS~
Text Label 6100 2750 0    50   ~ 0
RA11
Text Label 6100 3250 0    50   ~ 0
RD7
Text Label 4600 5150 2    50   ~ 0
VD7
Text Label 4600 4950 2    50   ~ 0
VD0
Text Label 4600 4350 2    50   ~ 0
VD1
Text Label 4600 4050 2    50   ~ 0
VD2
Text Label 4600 3450 2    50   ~ 0
VD3
Text Label 4600 3750 2    50   ~ 0
VD4
Text Label 4600 4650 2    50   ~ 0
VD6
Text Label 4600 4850 2    50   ~ 0
MD0
Text Label 4600 4550 2    50   ~ 0
MD1
Text Label 4600 3950 2    50   ~ 0
MD2
Text Label 4600 3550 2    50   ~ 0
MD3
Text Label 4600 5050 2    50   ~ 0
MD7
Text Label 4600 3850 2    50   ~ 0
MD4
Text Label 4600 4150 2    50   ~ 0
MD5
Text Label 4600 4750 2    50   ~ 0
MD6
Text Label 4600 2950 2    50   ~ 0
PHI1
Text Label 4600 2550 2    50   ~ 0
C14M
Text Label 4600 3150 2    50   ~ 0
~EN80~
Text Label 4600 2050 2    50   ~ 0
~C07X~
Text Label 4600 2850 2    50   ~ 0
R~W~80
Text Label 4600 3050 2    50   ~ 0
~CASEN~
Text Label 4600 3250 2    50   ~ 0
PHI0
Text Label 4600 2250 2    50   ~ 0
AN3
Text Label 4600 2150 2    50   ~ 0
R~W~
Wire Wire Line
	4600 2650 4600 2550
Wire Wire Line
	6100 1850 6150 1850
Wire Wire Line
	6150 1650 6100 1650
NoConn ~ 6100 1750
NoConn ~ 6100 2550
NoConn ~ 4600 4450
NoConn ~ 4600 3650
Wire Wire Line
	6150 1100 6150 1650
Wire Wire Line
	6150 1950 6150 1850
Wire Wire Line
	6150 2150 6150 2050
Wire Wire Line
	6150 2350 6150 2250
NoConn ~ 6100 2450
Text Label 6100 4450 0    50   ~ 0
MA1
Text Label 6100 4250 0    50   ~ 0
MA7
Text Label 6100 4350 0    50   ~ 0
MA0
Text Label 6100 4550 0    50   ~ 0
MA2
Text Label 6100 4750 0    50   ~ 0
MA4
Text Label 6100 4850 0    50   ~ 0
MA5
Text Label 6100 4650 0    50   ~ 0
MA3
$Comp
L Device:R_Small R1
U 1 1 5E545933
P 4250 1550
F 0 "R1" H 4200 1600 50  0000 R CNN
F 1 "1k2" H 4200 1500 50  0000 R CNN
F 2 "stdpads:R_0805" H 4250 1550 50  0001 C CNN
F 3 "~" H 4250 1550 50  0001 C CNN
	1    4250 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 1450 4250 1100
Connection ~ 4250 1650
Wire Wire Line
	4250 1650 4600 1650
Wire Wire Line
	4250 1100 6150 1100
$Comp
L power:GND #PWR0103
U 1 1 5E5EB414
P 4250 1850
F 0 "#PWR0103" H 4250 1600 50  0001 C CNN
F 1 "GND" H 4250 1700 50  0000 C CNN
F 2 "" H 4250 1850 50  0001 C CNN
F 3 "" H 4250 1850 50  0001 C CNN
	1    4250 1850
	1    0    0    -1  
$EndComp
Text Label 6100 4950 0    50   ~ 0
MA6
$Comp
L GW_RAM.lib:DRAM-2Mx8-SOP-28 U2
U 1 1 5DA22C4C
P 7300 3450
F 0 "U2" H 7300 4200 50  0000 C CNN
F 1 "DRAM_2Mx8" H 7300 2700 50  0000 C CNN
F 2 "stdpads:SOJ-28-300mil" H 7300 2600 50  0001 C CNN
F 3 "https://www.alliancememory.com/wp-content/uploads/pdf/AS6C8008.pdf" H 7300 2900 50  0001 C CNN
	1    7300 3450
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C10
U 1 1 5D463FD5
P 4100 7500
F 0 "C10" H 4150 7550 50  0000 L CNN
F 1 "10u" H 4150 7450 50  0000 L CNN
F 2 "stdpads:C_0805" H 4100 7500 50  0001 C CNN
F 3 "~" H 4100 7500 50  0001 C CNN
	1    4100 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 7400 3700 7400
Connection ~ 3700 7400
Wire Wire Line
	3700 7600 4100 7600
Connection ~ 3700 7600
Connection ~ 4100 7600
$Comp
L Device:C_Small C9
U 1 1 5E597D43
P 4250 1750
F 0 "C9" H 4300 1800 50  0000 L CNN
F 1 "10p" H 4300 1700 50  0000 L CNN
F 2 "stdpads:C_0805" H 4250 1750 50  0001 C CNN
F 3 "~" H 4250 1750 50  0001 C CNN
	1    4250 1750
	-1   0    0    -1  
$EndComp
$Sheet
S 9750 6350 500  150 
U 5E93A857
F0 "Docs" 50
F1 "Docs.sch" 50
$EndSheet
Text Label 4600 4250 2    50   ~ 0
VD5
Text Label 4050 4450 2    50   ~ 0
VD0
Entry Wire Line
	3850 5150 3750 5250
Entry Wire Line
	3850 5050 3750 5150
Entry Wire Line
	3850 4950 3750 5050
Entry Wire Line
	3850 4850 3750 4950
Entry Wire Line
	3850 4750 3750 4850
Entry Wire Line
	3850 4650 3750 4750
Entry Wire Line
	3850 4550 3750 4650
Entry Wire Line
	3850 4450 3750 4550
Wire Wire Line
	4050 4450 3850 4450
Wire Wire Line
	4050 4550 3850 4550
Wire Wire Line
	4050 4650 3850 4650
Wire Wire Line
	4050 4750 3850 4750
Wire Wire Line
	4050 4850 3850 4850
Wire Wire Line
	4050 4950 3850 4950
Wire Wire Line
	4050 5050 3850 5050
Wire Wire Line
	4050 5150 3850 5150
Text Label 4050 5150 2    50   ~ 0
VD7
Text Label 4050 5050 2    50   ~ 0
VD6
Text Label 4050 4950 2    50   ~ 0
VD5
Text Label 4050 4850 2    50   ~ 0
VD4
Text Label 4050 4750 2    50   ~ 0
VD3
Text Label 4050 4650 2    50   ~ 0
VD2
Text Label 4050 4550 2    50   ~ 0
VD1
Wire Wire Line
	7700 3850 7900 3850
Wire Wire Line
	7700 3750 7900 3750
Wire Wire Line
	7700 3650 7900 3650
Entry Wire Line
	8000 3950 7900 3850
Entry Wire Line
	8000 3850 7900 3750
Entry Wire Line
	8000 3750 7900 3650
Text Label 2850 3550 0    50   ~ 0
MD1
Text Label 2850 3650 0    50   ~ 0
MD2
Text Label 2850 3750 0    50   ~ 0
MD3
Text Label 2850 3850 0    50   ~ 0
MD4
Text Label 2850 3950 0    50   ~ 0
MD5
Text Label 2850 4050 0    50   ~ 0
MD6
Text Label 2850 4150 0    50   ~ 0
MD7
Wire Wire Line
	2850 4150 3050 4150
Wire Wire Line
	2850 4050 3050 4050
Wire Wire Line
	2850 3950 3050 3950
Wire Wire Line
	2850 3850 3050 3850
Wire Wire Line
	2850 3750 3050 3750
Wire Wire Line
	2850 3650 3050 3650
Wire Wire Line
	2850 3550 3050 3550
Entry Wire Line
	3050 3450 3150 3550
Entry Wire Line
	3050 3550 3150 3650
Entry Wire Line
	3050 3650 3150 3750
Entry Wire Line
	3050 3750 3150 3850
Entry Wire Line
	3050 3850 3150 3950
Entry Wire Line
	3050 3950 3150 4050
Entry Wire Line
	3050 4050 3150 4150
Entry Wire Line
	3050 4150 3150 4250
Text Label 2850 4550 0    50   ~ 0
VD1
Text Label 2850 4650 0    50   ~ 0
VD2
Text Label 2850 4750 0    50   ~ 0
VD3
Text Label 2850 4850 0    50   ~ 0
VD4
Text Label 2850 4950 0    50   ~ 0
VD5
Text Label 2850 5050 0    50   ~ 0
VD6
Text Label 2850 5150 0    50   ~ 0
VD7
Wire Wire Line
	2850 5150 3050 5150
Wire Wire Line
	2850 5050 3050 5050
Wire Wire Line
	2850 4950 3050 4950
Wire Wire Line
	2850 4850 3050 4850
Wire Wire Line
	2850 4750 3050 4750
Wire Wire Line
	2850 4650 3050 4650
Wire Wire Line
	2850 4550 3050 4550
Wire Wire Line
	2850 4450 3050 4450
Entry Wire Line
	3050 4450 3150 4550
Entry Wire Line
	3050 4550 3150 4650
Entry Wire Line
	3050 4650 3150 4750
Entry Wire Line
	3050 4750 3150 4850
Entry Wire Line
	3050 4850 3150 4950
Entry Wire Line
	3050 4950 3150 5050
Entry Wire Line
	3050 5050 3150 5150
Entry Wire Line
	3050 5150 3150 5250
Text Label 2850 4450 0    50   ~ 0
VD0
Entry Wire Line
	3850 4150 3750 4250
Entry Wire Line
	3850 4050 3750 4150
Entry Wire Line
	3850 3950 3750 4050
Entry Wire Line
	3850 3850 3750 3950
Entry Wire Line
	3850 3750 3750 3850
Entry Wire Line
	3850 3650 3750 3750
Entry Wire Line
	3850 3550 3750 3650
Entry Wire Line
	3850 3450 3750 3550
Wire Wire Line
	4050 3450 3850 3450
Wire Wire Line
	4050 3550 3850 3550
Wire Wire Line
	4050 3650 3850 3650
Wire Wire Line
	4050 3750 3850 3750
Wire Wire Line
	4050 3850 3850 3850
Wire Wire Line
	4050 3950 3850 3950
Wire Wire Line
	4050 4050 3850 4050
Wire Wire Line
	4050 4150 3850 4150
Text Label 4050 4150 2    50   ~ 0
MD7
Text Label 4050 4050 2    50   ~ 0
MD6
Text Label 4050 3950 2    50   ~ 0
MD5
Text Label 4050 3850 2    50   ~ 0
MD4
Text Label 4050 3750 2    50   ~ 0
MD3
Text Label 4050 3650 2    50   ~ 0
MD2
Text Label 4050 3550 2    50   ~ 0
MD1
Text Label 4050 3450 2    50   ~ 0
MD0
Wire Wire Line
	2850 3450 3050 3450
Wire Bus Line
	3150 3550 3750 3550
Wire Bus Line
	3150 4550 3750 4550
Wire Wire Line
	6300 3450 6100 3450
Wire Wire Line
	6300 3550 6100 3550
Wire Wire Line
	6300 3650 6100 3650
Wire Wire Line
	6300 3750 6100 3750
Wire Wire Line
	6300 2950 6100 2950
Wire Wire Line
	6300 3050 6100 3050
Wire Wire Line
	6300 3150 6100 3150
Wire Wire Line
	6300 3250 6100 3250
Wire Wire Line
	7700 3950 7900 3950
Entry Wire Line
	8000 4050 7900 3950
Wire Wire Line
	6100 4150 6500 4150
Wire Wire Line
	6100 4050 6500 4050
Entry Wire Line
	6300 2950 6400 2850
Entry Wire Line
	6300 3050 6400 2950
Entry Wire Line
	6300 3150 6400 3050
Entry Wire Line
	6300 3250 6400 3150
Entry Wire Line
	6300 3450 6400 3350
Entry Wire Line
	6300 3550 6400 3450
Entry Wire Line
	6300 3650 6400 3550
Entry Wire Line
	6300 3750 6400 3650
Entry Wire Line
	6600 4050 6500 4150
Entry Wire Line
	6600 3950 6500 4050
Entry Wire Line
	6500 2650 6600 2550
Entry Wire Line
	6500 2750 6600 2650
Entry Wire Line
	6500 3650 6400 3550
Entry Wire Line
	6500 3550 6400 3450
Entry Wire Line
	6500 3450 6400 3350
Entry Wire Line
	6500 3350 6400 3250
Entry Wire Line
	6500 3250 6400 3150
Entry Wire Line
	6500 3150 6400 3050
Entry Wire Line
	6500 3050 6400 2950
Entry Wire Line
	6500 2950 6400 2850
Wire Wire Line
	6900 2950 6500 2950
Wire Wire Line
	6900 3050 6500 3050
Wire Wire Line
	6900 3150 6500 3150
Wire Wire Line
	6900 3250 6500 3250
Wire Wire Line
	6900 3350 6500 3350
Wire Wire Line
	6900 3450 6500 3450
Wire Wire Line
	6900 3550 6500 3550
Wire Wire Line
	6900 3650 6500 3650
Entry Wire Line
	8100 3550 8200 3650
Entry Wire Line
	8100 3450 8200 3550
Entry Wire Line
	8100 3350 8200 3450
Entry Wire Line
	8100 3250 8200 3350
Entry Wire Line
	8100 3150 8200 3250
Entry Wire Line
	8100 3050 8200 3150
Entry Wire Line
	8100 2950 8200 3050
Entry Wire Line
	8100 2850 8200 2950
Wire Wire Line
	7700 2850 8100 2850
Wire Wire Line
	7700 2950 8100 2950
Wire Wire Line
	7700 3050 8100 3050
Wire Wire Line
	7700 3150 8100 3150
Wire Wire Line
	7700 3250 8100 3250
Wire Wire Line
	7700 3350 8100 3350
Wire Wire Line
	7700 3450 8100 3450
Wire Wire Line
	7700 3550 8100 3550
Wire Wire Line
	6100 2650 6500 2650
Wire Wire Line
	6100 2750 6500 2750
Wire Bus Line
	6600 2450 8000 2450
Text Label 2850 3450 0    50   ~ 0
MD0
Wire Bus Line
	3150 6250 6400 6250
Text Label 2850 5550 0    50   ~ 0
MA1
Text Label 2850 6150 0    50   ~ 0
MA7
Text Label 2850 5950 0    50   ~ 0
MA5
Text Label 2850 5850 0    50   ~ 0
MA4
Text Label 2850 6050 0    50   ~ 0
MA6
Text Label 2850 5750 0    50   ~ 0
MA3
Text Label 2850 5650 0    50   ~ 0
MA2
Text Label 2850 5450 0    50   ~ 0
MA0
Wire Wire Line
	2850 6150 3050 6150
Wire Wire Line
	2850 6050 3050 6050
Wire Wire Line
	2850 5950 3050 5950
Wire Wire Line
	2850 5850 3050 5850
Wire Wire Line
	2850 5750 3050 5750
Wire Wire Line
	2850 5650 3050 5650
Wire Wire Line
	2850 5550 3050 5550
Wire Wire Line
	2850 5450 3050 5450
Entry Wire Line
	3050 6150 3150 6250
Entry Wire Line
	3050 6050 3150 6150
Entry Wire Line
	3050 5950 3150 6050
Entry Wire Line
	3050 5850 3150 5950
Entry Wire Line
	3050 5750 3150 5850
Entry Wire Line
	3050 5650 3150 5750
Entry Wire Line
	3050 5550 3150 5650
Entry Wire Line
	3050 5450 3150 5550
Wire Wire Line
	5700 5450 5600 5450
Wire Wire Line
	5000 5450 5000 5500
Connection ~ 5000 5450
Connection ~ 5100 5450
Wire Wire Line
	5100 5450 5000 5450
Connection ~ 5200 5450
Wire Wire Line
	5200 5450 5100 5450
Connection ~ 5300 5450
Wire Wire Line
	5300 5450 5200 5450
Connection ~ 5400 5450
Wire Wire Line
	5400 5450 5300 5450
Connection ~ 5500 5450
Wire Wire Line
	5500 5450 5400 5450
Connection ~ 5600 5450
Wire Wire Line
	5600 5450 5500 5450
Wire Wire Line
	5000 1350 5100 1350
Connection ~ 5700 1350
Connection ~ 5100 1350
Wire Wire Line
	5100 1350 5200 1350
Connection ~ 5200 1350
Wire Wire Line
	5200 1350 5300 1350
Connection ~ 5300 1350
Wire Wire Line
	5300 1350 5400 1350
Connection ~ 5400 1350
Wire Wire Line
	5400 1350 5500 1350
Connection ~ 5500 1350
Wire Wire Line
	5500 1350 5600 1350
Connection ~ 5600 1350
Wire Wire Line
	5600 1350 5700 1350
Wire Bus Line
	6400 4350 8200 4350
Entry Wire Line
	6300 4250 6400 4350
Entry Wire Line
	6300 4350 6400 4450
Entry Wire Line
	6300 4450 6400 4550
Entry Wire Line
	6300 4550 6400 4650
Entry Wire Line
	6300 4650 6400 4750
Entry Wire Line
	6300 4750 6400 4850
Entry Wire Line
	6300 4850 6400 4950
Entry Wire Line
	6300 4950 6400 5050
Wire Wire Line
	6100 4250 6300 4250
Wire Wire Line
	6100 4350 6300 4350
Wire Wire Line
	6100 4450 6300 4450
Wire Wire Line
	6100 4550 6300 4550
Wire Wire Line
	6100 4650 6300 4650
Wire Wire Line
	6100 4750 6300 4750
Wire Wire Line
	6100 4850 6300 4850
Wire Wire Line
	6100 4950 6300 4950
Text Notes 6200 1650 0    50   ~ 0
DelayIn/Out[0]
Text Notes 6200 1950 0    50   ~ 0
DelayIn/Out[1]
Text Notes 6200 2150 0    50   ~ 0
DelayIn/Out[2]
Text Notes 6200 2350 0    50   ~ 0
DelayIn/Out[3]
Wire Bus Line
	6600 2450 6600 4050
Wire Bus Line
	8000 2450 8000 4050
Wire Bus Line
	3750 4550 3750 5250
Wire Bus Line
	3150 3550 3150 4250
Wire Bus Line
	3150 4550 3150 5250
Wire Bus Line
	3750 3550 3750 4250
Wire Bus Line
	6400 2850 6400 3650
Wire Bus Line
	3150 5550 3150 6250
Wire Bus Line
	8200 2950 8200 4350
Wire Bus Line
	6400 4350 6400 6250
$EndSCHEMATC
