EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 2
Title "GW4203B (RAM2E II)"
Date "2020-12-25"
Rev "1.3"
Comp "Garrett's Workshop"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C_Small C3
U 1 1 5D14D1AA
P 9000 1550
F 0 "C3" H 9050 1600 50  0000 L CNN
F 1 "10u" H 9050 1500 50  0000 L CNN
F 2 "stdpads:C_0805" H 9000 1550 50  0001 C CNN
F 3 "~" H 9000 1550 50  0001 C CNN
F 4 "C15850" H 9000 1550 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 9000 1550 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 1550 50  0001 C CNN "Notes"
	1    9000 1550
	1    0    0    -1  
$EndComp
Text Label 1900 7350 0    50   ~ 0
AN3
Text Label 1900 7050 0    50   ~ 0
~FRCTXT~
Connection ~ 1600 6900
Wire Wire Line
	1600 6900 1300 6900
Wire Wire Line
	1300 6900 1000 6900
Connection ~ 1300 6900
Wire Wire Line
	1000 6900 700  6900
Connection ~ 1000 6900
$Comp
L power:GND #PWR0132
U 1 1 5CC8BAFD
P 1600 6900
F 0 "#PWR0132" H 1600 6650 50  0001 C CNN
F 1 "GND" H 1605 6727 50  0000 C CNN
F 2 "" H 1600 6900 50  0001 C CNN
F 3 "" H 1600 6900 50  0001 C CNN
	1    1600 6900
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 5CC795A2
P 1000 6800
F 0 "H2" H 1100 6851 50  0000 L CNN
F 1 " " H 1100 6760 50  0000 L CNN
F 2 "stdpads:PasteHole_1.152mm_NPTH" H 1000 6800 50  0001 C CNN
F 3 "~" H 1000 6800 50  0001 C CNN
F 4 "DNP - mounting hole for solder paste printing" H 1000 6800 50  0001 C CNN "Notes"
	1    1000 6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 5CC53461
P 700 6800
F 0 "H1" H 800 6851 50  0000 L CNN
F 1 " " H 800 6760 50  0000 L CNN
F 2 "stdpads:PasteHole_1.152mm_NPTH" H 700 6800 50  0001 C CNN
F 3 "~" H 700 6800 50  0001 C CNN
F 4 "DNP - mounting hole for solder paste printing" H 700 6800 50  0001 C CNN "Notes"
	1    700  6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID4
U 1 1 5CC4DBDF
P 1200 7300
F 0 "FID4" H 1300 7346 50  0000 L CNN
F 1 "Fiducial" H 1300 7255 50  0000 L CNN
F 2 "stdpads:Fiducial" H 1200 7300 50  0001 C CNN
F 3 "~" H 1200 7300 50  0001 C CNN
F 4 "DNP - SMT vision system fiducial" H 1200 7300 50  0001 C CNN "Notes"
	1    1200 7300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID3
U 1 1 5CC4DBD8
P 700 7300
F 0 "FID3" H 800 7346 50  0000 L CNN
F 1 "Fiducial" H 800 7255 50  0000 L CNN
F 2 "stdpads:Fiducial" H 700 7300 50  0001 C CNN
F 3 "~" H 700 7300 50  0001 C CNN
F 4 "DNP - SMT vision system fiducial" H 700 7300 50  0001 C CNN "Notes"
	1    700  7300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID2
U 1 1 5CC4921D
P 1200 7100
F 0 "FID2" H 1300 7146 50  0000 L CNN
F 1 "Fiducial" H 1300 7055 50  0000 L CNN
F 2 "stdpads:Fiducial" H 1200 7100 50  0001 C CNN
F 3 "~" H 1200 7100 50  0001 C CNN
F 4 "DNP - SMT vision system fiducial" H 1200 7100 50  0001 C CNN "Notes"
	1    1200 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID1
U 1 1 5CC47A28
P 700 7100
F 0 "FID1" H 800 7146 50  0000 L CNN
F 1 "Fiducial" H 800 7055 50  0000 L CNN
F 2 "stdpads:Fiducial" H 700 7100 50  0001 C CNN
F 3 "~" H 700 7100 50  0001 C CNN
F 4 "DNP - SMT vision system fiducial" H 700 7100 50  0001 C CNN "Notes"
	1    700  7100
	1    0    0    -1  
$EndComp
Text Label 950  3750 2    50   ~ 0
~PRAS~
Text Label 950  4950 2    50   ~ 0
MD7
Text Label 1450 3450 0    50   ~ 0
~ENTMG~
Text Label 1450 3550 0    50   ~ 0
C7M
Text Label 1450 3650 0    50   ~ 0
GR
Text Label 1450 3750 0    50   ~ 0
~RA10~
Text Label 1450 3850 0    50   ~ 0
~RA9~
Text Label 1450 3950 0    50   ~ 0
~FRCTXT~
Text Label 1450 4050 0    50   ~ 0
SEGB
Text Label 1450 4150 0    50   ~ 0
Q3
Text Label 1450 4250 0    50   ~ 0
R~W~
Text Label 1450 4350 0    50   ~ 0
MA0
Text Label 1450 4450 0    50   ~ 0
AN3
Text Label 1450 4550 0    50   ~ 0
MA2
Text Label 1450 4650 0    50   ~ 0
MA3
Text Label 1450 4750 0    50   ~ 0
H0
Text Label 1450 4850 0    50   ~ 0
MA6
Text Label 1450 4950 0    50   ~ 0
VD0
Text Label 1450 5050 0    50   ~ 0
MD0
Text Label 1450 5150 0    50   ~ 0
MD1
Text Label 1450 5250 0    50   ~ 0
VD1
Text Label 1450 5350 0    50   ~ 0
VD2
Text Label 1450 5450 0    50   ~ 0
MD2
Text Label 1450 5550 0    50   ~ 0
MD3
Text Label 1450 5650 0    50   ~ 0
VD3
Text Label 1450 5750 0    50   ~ 0
~CASEN~
Text Label 1450 5850 0    50   ~ 0
PHI1
Text Label 1450 5950 0    50   ~ 0
R~W~80
Text Label 1450 6050 0    50   ~ 0
~LDPS~
Text Label 1450 6150 0    50   ~ 0
~PCAS~
Text Label 1450 6250 0    50   ~ 0
C14M
$Comp
L power:GND #PWR0107
U 1 1 5CFDD282
P 1450 6350
F 0 "#PWR0107" H 1450 6100 50  0001 C CNN
F 1 "GND" H 1450 6200 50  0000 C CNN
F 2 "" H 1450 6350 50  0001 C CNN
F 3 "" H 1450 6350 50  0001 C CNN
	1    1450 6350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 5CFDC1A5
P 950 6350
F 0 "#PWR0106" H 950 6200 50  0001 C CNN
F 1 "+5V" V 950 6500 50  0000 L CNN
F 2 "" H 950 6350 50  0001 C CNN
F 3 "" H 950 6350 50  0001 C CNN
	1    950  6350
	0    -1   -1   0   
$EndComp
Text Label 950  6250 2    50   ~ 0
~ENVID~
Text Label 950  6150 2    50   ~ 0
~SEROUT~
Text Label 950  6050 2    50   ~ 0
~ALTVID~
Text Label 950  5950 2    50   ~ 0
~EN80~
Text Label 950  5850 2    50   ~ 0
~80VID~
Text Label 950  5750 2    50   ~ 0
~CLRGAT~
Text Label 950  5650 2    50   ~ 0
PHI0
Text Label 950  5250 2    50   ~ 0
VD5
Text Label 950  5550 2    50   ~ 0
VD4
Text Label 950  5450 2    50   ~ 0
MD4
Text Label 950  5350 2    50   ~ 0
MD5
Text Label 950  5150 2    50   ~ 0
VD6
Text Label 950  5050 2    50   ~ 0
MD6
Text Label 950  4850 2    50   ~ 0
VD7
Text Label 950  4750 2    50   ~ 0
MA5
Text Label 950  4650 2    50   ~ 0
MA4
Text Label 950  4550 2    50   ~ 0
ROMEN2
Text Label 950  4450 2    50   ~ 0
ROMEN1
Text Label 950  4350 2    50   ~ 0
MA1
Text Label 950  4250 2    50   ~ 0
MA7
Text Label 950  4150 2    50   ~ 0
SEGA
Text Label 950  4050 2    50   ~ 0
~WNDW~
Text Label 950  3950 2    50   ~ 0
~C07X~
Text Label 950  3850 2    50   ~ 0
VC
Text Label 950  3650 2    50   ~ 0
~SYNC~
Text Label 950  3550 2    50   ~ 0
Vid7M
Text Label 950  3450 2    50   ~ 0
C3M58
$Comp
L Connector_Generic:Conn_02x30_Counter_Clockwise J1
U 1 1 5CFB6FE3
P 1150 4850
F 0 "J1" H 1200 6467 50  0000 C CNN
F 1 "AppleIIeAux" H 1200 6376 50  0000 C CNN
F 2 "stdpads:AppleIIeAux_Edge" H 1150 4850 50  0001 C CNN
F 3 "~" H 1150 4850 50  0001 C CNN
F 4 "DNP - edge connector" H 1150 4850 50  0001 C CNN "Notes"
	1    1150 4850
	1    0    0    -1  
$EndComp
$Sheet
S 9750 6350 500  150 
U 5E93A857
F0 "Docs" 50
F1 "Docs.sch" 50
$EndSheet
$Comp
L GW_RAM:SDRAM-16Mx16-TSOP2-54 U2
U 1 1 5E74FE5D
P 9000 4850
F 0 "U2" H 9000 6000 50  0000 C CNN
F 1 "W9812G6KH-6" V 9000 4850 50  0000 C CNN
F 2 "stdpads:TSOP-II-54_22.2x10.16mm_P0.8mm" H 9000 3200 50  0001 C CIN
F 3 "" H 9000 4600 50  0001 C CNN
F 4 "C62379" H 9000 4850 50  0001 C CNN "LCSC Part"
F 5 "Winbond W9812G6KH-6, Winbond W9812G6KH-6I, Winbond W9825G6KH-6, Winbond W9825G6KH-6I, ISSI IS42S16160J-6TL, ISSI IS42S16160J-6TLI, Micron MT48LC16M16A2P-6A :G, Micron MT48LC16M16A2P-6A IT:G" H 9000 4850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "Most 166 MHz 128/256 Mbit SDRAM is acceptable." H 9000 4850 50  0001 C CNN "Notes"
	1    9000 4850
	1    0    0    -1  
$EndComp
$Comp
L GW_Logic:74245 U3
U 1 1 5E8972EF
P 3000 1500
F 0 "U3" H 3000 2100 50  0000 C CNN
F 1 "74LVC245APW" H 3000 900 50  0000 C CNN
F 2 "stdpads:TSSOP-20_4.4x6.5mm_P0.65mm" H 3000 850 50  0001 C TNN
F 3 "" H 3000 1600 60  0001 C CNN
F 4 "C6082" H 3000 1500 50  0001 C CNN "LCSC Part"
F 5 "NXP 74LVC245APW, TI SN74LVC245APW" H 3000 1500 50  0001 C CNN "Mfg. Part Numbers"
	1    3000 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1650 2600 1650
Wire Wire Line
	2400 1850 2600 1850
Wire Wire Line
	2400 1750 2600 1750
Wire Wire Line
	2400 2950 2600 2950
Wire Wire Line
	2400 3150 2600 3150
Wire Wire Line
	2400 1350 2600 1350
Text Label 2400 1650 0    50   ~ 0
MA2
Text Label 2400 1850 0    50   ~ 0
MA3
Text Label 2400 3150 0    50   ~ 0
MA6
Text Label 2400 1750 0    50   ~ 0
MA4
Text Label 2400 2950 0    50   ~ 0
MA5
Text Label 2400 1350 0    50   ~ 0
MA7
Wire Wire Line
	2400 1550 2600 1550
Wire Wire Line
	2400 1450 2600 1450
Text Label 2400 1550 0    50   ~ 0
MA0
Text Label 2400 1450 0    50   ~ 0
MA1
Text Label 2150 2450 2    50   ~ 0
C14M
$Comp
L power:GND #PWR0101
U 1 1 5E96CE9C
P 2600 1950
F 0 "#PWR0101" H 2600 1700 50  0001 C CNN
F 1 "GND" H 2600 1800 50  0000 C CNN
F 2 "" H 2600 1950 50  0001 C CNN
F 3 "" H 2600 1950 50  0001 C CNN
	1    2600 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0102
U 1 1 5E9711FB
P 3400 1050
F 0 "#PWR0102" H 3400 900 50  0001 C CNN
F 1 "+3V3" H 3400 1200 50  0000 C CNN
F 2 "" H 3400 1050 50  0001 C CNN
F 3 "" H 3400 1050 50  0001 C CNN
	1    3400 1050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5E9BEAE2
P 3600 850
F 0 "#PWR0104" H 3600 600 50  0001 C CNN
F 1 "GND" H 3600 700 50  0000 C CNN
F 2 "" H 3600 850 50  0001 C CNN
F 3 "" H 3600 850 50  0001 C CNN
	1    3600 850 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 850  3600 850 
Wire Wire Line
	3400 1150 3500 1150
Text Label 9700 3850 2    50   ~ 0
RD0
Text Label 9700 4550 2    50   ~ 0
RD7
Text Label 9700 4150 2    50   ~ 0
RD3
Text Label 9700 4350 2    50   ~ 0
RD5
Text Label 9700 4250 2    50   ~ 0
RD4
Text Label 9700 4050 2    50   ~ 0
RD2
Text Label 9700 3950 2    50   ~ 0
RD1
Text Label 9700 4450 2    50   ~ 0
RD6
Wire Wire Line
	9700 3850 9500 3850
Wire Wire Line
	9700 3950 9500 3950
Wire Wire Line
	9700 4050 9500 4050
Wire Wire Line
	9700 4150 9500 4150
Wire Wire Line
	9700 4250 9500 4250
Wire Wire Line
	9700 4350 9500 4350
Wire Wire Line
	9700 4550 9500 4550
Wire Wire Line
	9700 4450 9500 4450
Text Label 8500 4650 2    50   ~ 0
RA5
Text Label 8500 4450 2    50   ~ 0
RA3
Text Label 8500 4250 2    50   ~ 0
RA1
Text Label 8500 4750 2    50   ~ 0
RA6
Text Label 8500 4550 2    50   ~ 0
RA4
Text Label 8500 4350 2    50   ~ 0
RA2
Text Label 8500 4850 2    50   ~ 0
RA7
Text Label 8500 4950 2    50   ~ 0
RA8
Text Label 8500 5050 2    50   ~ 0
RA9
Text Label 8500 4150 2    50   ~ 0
RA0
Text Label 8500 5150 2    50   ~ 0
RA10
Wire Wire Line
	8500 5050 8300 5050
Wire Wire Line
	8500 4950 8300 4950
Wire Wire Line
	8500 4150 8300 4150
Wire Wire Line
	8500 4350 8300 4350
Wire Wire Line
	8500 4550 8300 4550
Wire Wire Line
	8500 4750 8300 4750
Wire Wire Line
	8500 4650 8300 4650
Wire Wire Line
	8500 4450 8300 4450
Wire Wire Line
	8500 4250 8300 4250
Wire Wire Line
	8500 4850 8300 4850
Text Label 8500 5450 2    50   ~ 0
BA0
Wire Wire Line
	8500 5450 8300 5450
Text Label 8500 5550 2    50   ~ 0
BA1
Wire Wire Line
	8500 5550 8300 5550
Text Label 8500 5750 2    50   ~ 0
CKE
Text Label 8500 5850 2    50   ~ 0
RCLK
Text Label 9700 5550 2    50   ~ 0
DQMH
Text Label 9700 5450 2    50   ~ 0
DQML
Wire Wire Line
	9700 5550 9500 5550
Wire Wire Line
	9700 5450 9500 5450
Text Label 9500 5850 0    50   ~ 0
~CS~
Text Label 9500 5950 0    50   ~ 0
~WE~
Text Label 9500 6050 0    50   ~ 0
~CAS~
Text Label 9500 6150 0    50   ~ 0
~RAS~
$Comp
L power:GND #PWR0105
U 1 1 5ED42454
P 8500 6150
F 0 "#PWR0105" H 8500 5900 50  0001 C CNN
F 1 "GND" H 8500 6000 50  0000 C CNN
F 2 "" H 8500 6150 50  0001 C CNN
F 3 "" H 8500 6150 50  0001 C CNN
	1    8500 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 6150 8500 6050
Connection ~ 8500 6150
Entry Wire Line
	8300 5550 8200 5650
Entry Wire Line
	8300 5450 8200 5550
Wire Bus Line
	8200 5550 8200 5650
Entry Wire Line
	8300 4150 8200 4250
Entry Wire Line
	8300 4350 8200 4450
Entry Wire Line
	8300 4250 8200 4350
Entry Wire Line
	8300 4550 8200 4650
Entry Wire Line
	8300 4450 8200 4550
Entry Wire Line
	8300 4750 8200 4850
Entry Wire Line
	8300 4650 8200 4750
Entry Wire Line
	8300 4950 8200 5050
Entry Wire Line
	8300 4850 8200 4950
Entry Wire Line
	8300 5150 8200 5250
Entry Wire Line
	8300 5050 8200 5150
$Comp
L power:+3V3 #PWR0109
U 1 1 5EE4E808
P 8500 3850
F 0 "#PWR0109" H 8500 3700 50  0001 C CNN
F 1 "+3V3" H 8515 4023 50  0000 C CNN
F 2 "" H 8500 3850 50  0001 C CNN
F 3 "" H 8500 3850 50  0001 C CNN
	1    8500 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 3950 8500 3850
Connection ~ 8500 3850
Wire Wire Line
	8500 5150 8300 5150
Text Label 3400 1350 0    50   ~ 0
~C07X~in
Text Label 3400 2950 0    50   ~ 0
R~W~80in
Text Label 3400 2850 0    50   ~ 0
~EN80~in
Text Label 3400 1250 0    50   ~ 0
R~W~in
Text Label 3400 3150 0    50   ~ 0
PHI1in
Text Label 9700 5350 2    50   ~ 0
RD0
Text Label 9700 4650 2    50   ~ 0
RD7
Text Label 9700 5050 2    50   ~ 0
RD3
Text Label 9700 4850 2    50   ~ 0
RD5
Text Label 9700 4950 2    50   ~ 0
RD4
Text Label 9700 5150 2    50   ~ 0
RD2
Text Label 9700 5250 2    50   ~ 0
RD1
Text Label 9700 4750 2    50   ~ 0
RD6
Wire Wire Line
	9700 5350 9500 5350
Wire Wire Line
	9700 5250 9500 5250
Wire Wire Line
	9700 5150 9500 5150
Wire Wire Line
	9700 5050 9500 5050
Wire Wire Line
	9700 4950 9500 4950
Wire Wire Line
	9700 4850 9500 4850
Wire Wire Line
	9700 4650 9500 4650
Wire Wire Line
	9700 4750 9500 4750
$Comp
L power:+3V3 #PWR0110
U 1 1 5EFCDA09
P 2600 1050
F 0 "#PWR0110" H 2600 900 50  0001 C CNN
F 1 "+3V3" H 2600 1200 50  0000 C CNN
F 2 "" H 2600 1050 50  0001 C CNN
F 3 "" H 2600 1050 50  0001 C CNN
	1    2600 1050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5EF65B99
P 2600 3250
F 0 "#PWR0111" H 2600 3000 50  0001 C CNN
F 1 "GND" H 2600 3100 50  0000 C CNN
F 2 "" H 2600 3250 50  0001 C CNN
F 3 "" H 2600 3250 50  0001 C CNN
	1    2600 3250
	1    0    0    -1  
$EndComp
Text Label 3600 5050 2    50   ~ 0
V~OE~
Wire Wire Line
	3400 5050 3600 5050
$Comp
L power:+5V #PWR0114
U 1 1 5F2BCE3B
P 3400 4950
F 0 "#PWR0114" H 3400 4800 50  0001 C CNN
F 1 "+5V" H 3400 5100 50  0000 C CNN
F 2 "" H 3400 4950 50  0001 C CNN
F 3 "" H 3400 4950 50  0001 C CNN
	1    3400 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5F2BCA80
P 2600 5850
F 0 "#PWR0115" H 2600 5600 50  0001 C CNN
F 1 "GND" H 2600 5700 50  0000 C CNN
F 2 "" H 2600 5850 50  0001 C CNN
F 3 "" H 2600 5850 50  0001 C CNN
	1    2600 5850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3600 5350 3400 5350
Wire Wire Line
	3600 5150 3400 5150
Wire Wire Line
	3600 5750 3400 5750
Wire Wire Line
	3600 5250 3400 5250
Text Label 3600 5250 2    50   ~ 0
Vout3
Text Label 3600 5750 2    50   ~ 0
Vout0
Text Label 3600 5150 2    50   ~ 0
Vout7
Text Label 3600 5350 2    50   ~ 0
Vout6
Wire Wire Line
	2400 5250 2600 5250
Wire Wire Line
	2400 5050 2600 5050
Wire Wire Line
	2400 5650 2600 5650
Wire Wire Line
	2400 5350 2600 5350
Wire Wire Line
	2400 5550 2600 5550
Wire Wire Line
	2400 5150 2600 5150
Wire Wire Line
	2400 5750 2600 5750
Wire Wire Line
	2400 5450 2600 5450
Text Label 2400 5150 0    50   ~ 0
VD3
Text Label 2400 5550 0    50   ~ 0
VD2
Text Label 2400 5350 0    50   ~ 0
VD1
Text Label 2400 5650 0    50   ~ 0
VD0
Text Label 2400 5050 0    50   ~ 0
VD7
Text Label 2400 5250 0    50   ~ 0
VD6
Text Label 2400 5750 0    50   ~ 0
VD4
Text Label 2400 5450 0    50   ~ 0
VD5
Wire Wire Line
	2600 4950 2500 4950
Wire Wire Line
	2500 4750 2400 4750
Wire Wire Line
	2500 4950 2500 4750
$Comp
L power:GND #PWR0116
U 1 1 5F256D51
P 2400 4750
F 0 "#PWR0116" H 2400 4500 50  0001 C CNN
F 1 "GND" H 2400 4600 50  0000 C CNN
F 2 "" H 2400 4750 50  0001 C CNN
F 3 "" H 2400 4750 50  0001 C CNN
	1    2400 4750
	-1   0    0    -1  
$EndComp
$Comp
L GW_Logic:74245 U6
U 1 1 5F24DF9F
P 3000 5400
F 0 "U6" H 3000 6000 50  0000 C CNN
F 1 "74AHCT245PW" H 3000 4800 50  0000 C CNN
F 2 "stdpads:TSSOP-20_4.4x6.5mm_P0.65mm" H 3000 4750 50  0001 C TNN
F 3 "" H 3000 5500 60  0001 C CNN
F 4 "C173388" H 3000 5400 50  0001 C CNN "LCSC Part"
F 5 "NXP 74AHCT245PW, TI SN74AHCT245PW" H 3000 5400 50  0001 C CNN "Mfg. Part Numbers"
	1    3000 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 6250 2500 6250
Wire Wire Line
	2500 6050 2400 6050
Wire Wire Line
	2500 6250 2500 6050
$Comp
L power:GND #PWR0117
U 1 1 5EFCFDAF
P 2400 6050
F 0 "#PWR0117" H 2400 5800 50  0001 C CNN
F 1 "GND" H 2400 5900 50  0000 C CNN
F 2 "" H 2400 6050 50  0001 C CNN
F 3 "" H 2400 6050 50  0001 C CNN
	1    2400 6050
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0118
U 1 1 5EFCDE61
P 2600 3650
F 0 "#PWR0118" H 2600 3500 50  0001 C CNN
F 1 "+3V3" H 2600 3800 50  0000 C CNN
F 2 "" H 2600 3650 50  0001 C CNN
F 3 "" H 2600 3650 50  0001 C CNN
	1    2600 3650
	1    0    0    -1  
$EndComp
Text Label 3600 6350 2    50   ~ 0
D~OE~
Wire Wire Line
	3400 6350 3600 6350
Wire Wire Line
	3400 3750 3500 3750
Wire Wire Line
	3500 3550 3600 3550
Wire Wire Line
	3500 3750 3500 3550
$Comp
L power:GND #PWR0119
U 1 1 5E984F7D
P 3600 3550
F 0 "#PWR0119" H 3600 3300 50  0001 C CNN
F 1 "GND" H 3600 3400 50  0000 C CNN
F 2 "" H 3600 3550 50  0001 C CNN
F 3 "" H 3600 3550 50  0001 C CNN
	1    3600 3550
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0120
U 1 1 5E970889
P 3400 3650
F 0 "#PWR0120" H 3400 3500 50  0001 C CNN
F 1 "+3V3" H 3400 3800 50  0000 C CNN
F 2 "" H 3400 3650 50  0001 C CNN
F 3 "" H 3400 3650 50  0001 C CNN
	1    3400 3650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0121
U 1 1 5E96E887
P 3400 6250
F 0 "#PWR0121" H 3400 6100 50  0001 C CNN
F 1 "+5V" H 3400 6400 50  0000 C CNN
F 2 "" H 3400 6250 50  0001 C CNN
F 3 "" H 3400 6250 50  0001 C CNN
	1    3400 6250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 5E96D883
P 2600 7150
F 0 "#PWR0122" H 2600 6900 50  0001 C CNN
F 1 "GND" H 2600 7000 50  0000 C CNN
F 2 "" H 2600 7150 50  0001 C CNN
F 3 "" H 2600 7150 50  0001 C CNN
	1    2600 7150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 5E96D37A
P 2600 4550
F 0 "#PWR0123" H 2600 4300 50  0001 C CNN
F 1 "GND" H 2600 4400 50  0000 C CNN
F 2 "" H 2600 4550 50  0001 C CNN
F 3 "" H 2600 4550 50  0001 C CNN
	1    2600 4550
	1    0    0    -1  
$EndComp
Text Label 2400 3950 0    50   ~ 0
MD0
Text Label 2400 4050 0    50   ~ 0
MD1
Text Label 2400 4250 0    50   ~ 0
MD2
Text Label 2400 4150 0    50   ~ 0
MD3
Text Label 2400 6450 0    50   ~ 0
MD4
Text Label 2400 6350 0    50   ~ 0
MD5
Text Label 2400 3850 0    50   ~ 0
MD6
Text Label 2400 3750 0    50   ~ 0
MD7
Wire Wire Line
	2400 3750 2600 3750
Wire Wire Line
	2400 3850 2600 3850
Wire Wire Line
	2400 6350 2600 6350
Wire Wire Line
	2400 6450 2600 6450
Wire Wire Line
	2400 4150 2600 4150
Wire Wire Line
	2400 4250 2600 4250
Wire Wire Line
	2400 4050 2600 4050
Wire Wire Line
	2400 3950 2600 3950
$Comp
L GW_Logic:74245 U5
U 1 1 5E8F097C
P 3000 4100
F 0 "U5" H 3000 4700 50  0000 C CNN
F 1 "74LVC245APW" H 3000 3500 50  0000 C CNN
F 2 "stdpads:TSSOP-20_4.4x6.5mm_P0.65mm" H 3000 3450 50  0001 C TNN
F 3 "" H 3000 4200 60  0001 C CNN
F 4 "C6082" H 3000 4100 50  0001 C CNN "LCSC Part"
F 5 "NXP 74LVC245APW, TI SN74LVC245APW" H 3000 4100 50  0001 C CNN "Mfg. Part Numbers"
	1    3000 4100
	1    0    0    -1  
$EndComp
$Comp
L GW_Logic:74245 U7
U 1 1 5E8FF16F
P 3000 6700
F 0 "U7" H 3000 7300 50  0000 C CNN
F 1 "74AHCT245PW" H 3000 6100 50  0000 C CNN
F 2 "stdpads:TSSOP-20_4.4x6.5mm_P0.65mm" H 3000 6050 50  0001 C TNN
F 3 "" H 3000 6800 60  0001 C CNN
F 4 "C173388" H 3000 6700 50  0001 C CNN "LCSC Part"
F 5 "NXP 74AHCT245PW, TI SN74AHCT245PW" H 3000 6700 50  0001 C CNN "Mfg. Part Numbers"
	1    3000 6700
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0124
U 1 1 5F38A85E
P 3400 2350
F 0 "#PWR0124" H 3400 2200 50  0001 C CNN
F 1 "+3V3" H 3400 2500 50  0000 C CNN
F 2 "" H 3400 2350 50  0001 C CNN
F 3 "" H 3400 2350 50  0001 C CNN
	1    3400 2350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0125
U 1 1 5F3A345F
P 2600 2350
F 0 "#PWR0125" H 2600 2200 50  0001 C CNN
F 1 "+3V3" H 2600 2500 50  0000 C CNN
F 2 "" H 2600 2350 50  0001 C CNN
F 3 "" H 2600 2350 50  0001 C CNN
	1    2600 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 5F3A4A01
P 3600 2350
F 0 "#PWR0126" H 3600 2100 50  0001 C CNN
F 1 "GND" H 3600 2200 50  0000 C CNN
F 2 "" H 3600 2350 50  0001 C CNN
F 3 "" H 3600 2350 50  0001 C CNN
	1    3600 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 2350 3600 2350
Wire Wire Line
	3400 2450 3500 2450
Text Label 2600 3050 2    50   ~ 0
PHI1
Text Label 2600 2750 2    50   ~ 0
~EN80~
Text Label 2600 2850 2    50   ~ 0
R~W~80
Wire Wire Line
	3600 1750 3400 1750
Wire Wire Line
	3600 1950 3400 1950
Wire Wire Line
	3600 1850 3400 1850
Wire Wire Line
	3600 3050 3400 3050
Wire Wire Line
	3600 1450 3400 1450
Text Label 3600 1750 2    50   ~ 0
Ain2
Text Label 3600 1950 2    50   ~ 0
Ain3
Text Label 3600 3250 2    50   ~ 0
Ain6
Text Label 3600 1850 2    50   ~ 0
Ain4
Text Label 3600 3050 2    50   ~ 0
Ain5
Text Label 3600 1450 2    50   ~ 0
Ain7
Wire Wire Line
	3600 1550 3400 1550
Text Label 3600 1650 2    50   ~ 0
Ain0
Text Label 3600 1550 2    50   ~ 0
Ain1
Wire Wire Line
	3600 1650 3400 1650
Text Label 2600 1150 2    50   ~ 0
R~W~
Text Label 2600 1250 2    50   ~ 0
~C07X~
Wire Wire Line
	7700 1750 7700 1550
$Comp
L Device:C_Small C1
U 1 1 5D136B08
P 7400 1550
F 0 "C1" H 7450 1600 50  0000 L CNN
F 1 "10u" H 7450 1500 50  0000 L CNN
F 2 "stdpads:C_0805" H 7400 1550 50  0001 C CNN
F 3 "~" H 7400 1550 50  0001 C CNN
F 4 "C15850" H 7400 1550 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 7400 1550 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 1550 50  0001 C CNN "Notes"
	1    7400 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 5FADEA9C
P 8600 2050
F 0 "C12" H 8650 2100 50  0000 L CNN
F 1 "2u2" H 8650 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 8600 2050 50  0001 C CNN
F 3 "~" H 8600 2050 50  0001 C CNN
F 4 "C23630" H 8600 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8600 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 2050 50  0001 C CNN "Notes"
	1    8600 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C7
U 1 1 5FAD060F
P 7400 2050
F 0 "C7" H 7450 2100 50  0000 L CNN
F 1 "2u2" H 7450 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 7400 2050 50  0001 C CNN
F 3 "~" H 7400 2050 50  0001 C CNN
F 4 "C23630" H 7400 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7400 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 2050 50  0001 C CNN "Notes"
	1    7400 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C16
U 1 1 5FAE0531
P 9400 3250
F 0 "C16" H 9450 3300 50  0000 L CNN
F 1 "2u2" H 9450 3200 50  0000 L CNN
F 2 "stdpads:C_0603" H 9400 3250 50  0001 C CNN
F 3 "~" H 9400 3250 50  0001 C CNN
F 4 "C23630" H 9400 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9400 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9400 3250 50  0001 C CNN "Notes"
	1    9400 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C24
U 1 1 5FAEC760
P 7800 2850
F 0 "C24" H 7850 2900 50  0000 L CNN
F 1 "2u2" H 7850 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 7800 2850 50  0001 C CNN
F 3 "~" H 7800 2850 50  0001 C CNN
F 4 "C23630" H 7800 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7800 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7800 2850 50  0001 C CNN "Notes"
	1    7800 2850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0129
U 1 1 5FB1E84E
P 7400 1950
F 0 "#PWR0129" H 7400 1800 50  0001 C CNN
F 1 "+3V3" H 7400 2100 50  0000 C CNN
F 2 "" H 7400 1950 50  0001 C CNN
F 3 "" H 7400 1950 50  0001 C CNN
	1    7400 1950
	1    0    0    -1  
$EndComp
Connection ~ 7400 1950
$Comp
L Device:C_Small C13
U 1 1 5FB22AA1
P 9000 2050
F 0 "C13" H 9050 2100 50  0000 L CNN
F 1 "2u2" H 9050 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 9000 2050 50  0001 C CNN
F 3 "~" H 9000 2050 50  0001 C CNN
F 4 "C23630" H 9000 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9000 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 2050 50  0001 C CNN "Notes"
	1    9000 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C8
U 1 1 5FB22AA7
P 7800 2050
F 0 "C8" H 7850 2100 50  0000 L CNN
F 1 "2u2" H 7850 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 7800 2050 50  0001 C CNN
F 3 "~" H 7800 2050 50  0001 C CNN
F 4 "C23630" H 7800 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7800 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7800 2050 50  0001 C CNN "Notes"
	1    7800 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C17
U 1 1 5FB22AB3
P 7800 2450
F 0 "C17" H 7850 2500 50  0000 L CNN
F 1 "2u2" H 7850 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 7800 2450 50  0001 C CNN
F 3 "~" H 7800 2450 50  0001 C CNN
F 4 "C23630" H 7800 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7800 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7800 2450 50  0001 C CNN "Notes"
	1    7800 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C25
U 1 1 5FB22AB9
P 8200 2850
F 0 "C25" H 8250 2900 50  0000 L CNN
F 1 "2u2" H 8250 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 8200 2850 50  0001 C CNN
F 3 "~" H 8200 2850 50  0001 C CNN
F 4 "C23630" H 8200 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8200 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8200 2850 50  0001 C CNN "Notes"
	1    8200 2850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0131
U 1 1 5FB22ACE
P 7400 2350
F 0 "#PWR0131" H 7400 2200 50  0001 C CNN
F 1 "+3V3" H 7400 2500 50  0000 C CNN
F 2 "" H 7400 2350 50  0001 C CNN
F 3 "" H 7400 2350 50  0001 C CNN
	1    7400 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C14
U 1 1 5FB36CB2
P 9400 2050
F 0 "C14" H 9450 2100 50  0000 L CNN
F 1 "2u2" H 9450 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 9400 2050 50  0001 C CNN
F 3 "~" H 9400 2050 50  0001 C CNN
F 4 "C23630" H 9400 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9400 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9400 2050 50  0001 C CNN "Notes"
	1    9400 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C10
U 1 1 5FB36CB8
P 7400 3250
F 0 "C10" H 7450 3300 50  0000 L CNN
F 1 "2u2" H 7450 3200 50  0000 L CNN
F 2 "stdpads:C_0603" H 7400 3250 50  0001 C CNN
F 3 "~" H 7400 3250 50  0001 C CNN
F 4 "C23630" H 7400 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7400 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 3250 50  0001 C CNN "Notes"
	1    7400 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C22
U 1 1 5FB36CBE
P 9400 2450
F 0 "C22" H 9450 2500 50  0000 L CNN
F 1 "2u2" H 9450 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 9400 2450 50  0001 C CNN
F 3 "~" H 9400 2450 50  0001 C CNN
F 4 "C23630" H 9400 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9400 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9400 2450 50  0001 C CNN "Notes"
	1    9400 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C18
U 1 1 5FB36CC4
P 8200 2450
F 0 "C18" H 8250 2500 50  0000 L CNN
F 1 "2u2" H 8250 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 8200 2450 50  0001 C CNN
F 3 "~" H 8200 2450 50  0001 C CNN
F 4 "C23630" H 8200 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8200 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8200 2450 50  0001 C CNN "Notes"
	1    8200 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C26
U 1 1 5FB36CCA
P 8600 2850
F 0 "C26" H 8650 2900 50  0000 L CNN
F 1 "2u2" H 8650 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 8600 2850 50  0001 C CNN
F 3 "~" H 8600 2850 50  0001 C CNN
F 4 "C23630" H 8600 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8600 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 2850 50  0001 C CNN "Notes"
	1    8600 2850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0134
U 1 1 5FB36CDF
P 7400 2750
F 0 "#PWR0134" H 7400 2600 50  0001 C CNN
F 1 "+3V3" H 7400 2900 50  0000 C CNN
F 2 "" H 7400 2750 50  0001 C CNN
F 3 "" H 7400 2750 50  0001 C CNN
	1    7400 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C15
U 1 1 5FB36CEC
P 7400 2450
F 0 "C15" H 7450 2500 50  0000 L CNN
F 1 "2u2" H 7450 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 7400 2450 50  0001 C CNN
F 3 "~" H 7400 2450 50  0001 C CNN
F 4 "C23630" H 7400 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7400 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 2450 50  0001 C CNN "Notes"
	1    7400 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C11
U 1 1 5FB36CF2
P 7800 3250
F 0 "C11" H 7850 3300 50  0000 L CNN
F 1 "2u2" H 7850 3200 50  0000 L CNN
F 2 "stdpads:C_0603" H 7800 3250 50  0001 C CNN
F 3 "~" H 7800 3250 50  0001 C CNN
F 4 "C23630" H 7800 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7800 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7800 3250 50  0001 C CNN "Notes"
	1    7800 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C23
U 1 1 5FB36CF8
P 7400 2850
F 0 "C23" H 7450 2900 50  0000 L CNN
F 1 "2u2" H 7450 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 7400 2850 50  0001 C CNN
F 3 "~" H 7400 2850 50  0001 C CNN
F 4 "C23630" H 7400 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 7400 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 2850 50  0001 C CNN "Notes"
	1    7400 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 1750 7700 1750
Wire Wire Line
	7400 1350 7400 1450
Wire Wire Line
	7400 1750 7400 1650
Wire Wire Line
	9000 1450 9000 1350
Wire Wire Line
	7400 1350 7700 1350
$Comp
L power:+5V #PWR0139
U 1 1 5F93DE25
P 7400 1350
F 0 "#PWR0139" H 7400 1200 50  0001 C CNN
F 1 "+5V" H 7400 1500 50  0000 C CNN
F 2 "" H 7400 1350 50  0001 C CNN
F 3 "" H 7400 1350 50  0001 C CNN
	1    7400 1350
	1    0    0    -1  
$EndComp
Connection ~ 7400 1350
$Comp
L power:+3V3 #PWR0140
U 1 1 5F90B2C0
P 8600 1350
F 0 "#PWR0140" H 8600 1200 50  0001 C CNN
F 1 "+3V3" H 8600 1500 50  0000 C CNN
F 2 "" H 8600 1350 50  0001 C CNN
F 3 "" H 8600 1350 50  0001 C CNN
	1    8600 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 2150 7800 2150
Wire Wire Line
	7400 1950 7800 1950
Connection ~ 7800 1950
Wire Wire Line
	7800 1950 8200 1950
Connection ~ 7800 2150
Wire Wire Line
	7800 2150 8200 2150
$Comp
L Device:C_Small C9
U 1 1 5FDCD964
P 8200 2050
F 0 "C9" H 8250 2100 50  0000 L CNN
F 1 "2u2" H 8250 2000 50  0000 L CNN
F 2 "stdpads:C_0603" H 8200 2050 50  0001 C CNN
F 3 "~" H 8200 2050 50  0001 C CNN
F 4 "C23630" H 8200 2050 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8200 2050 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8200 2050 50  0001 C CNN "Notes"
	1    8200 2050
	1    0    0    -1  
$EndComp
Connection ~ 8200 1950
Connection ~ 8200 2150
Connection ~ 8200 2350
Connection ~ 8200 2550
Text Label 6900 5050 2    50   ~ 0
RD0
Text Label 6900 4350 2    50   ~ 0
RD7
Text Label 6900 4550 2    50   ~ 0
RD5
Text Label 6900 4650 2    50   ~ 0
RD4
Text Label 6900 4850 2    50   ~ 0
RD2
Text Label 6900 4950 2    50   ~ 0
RD1
Text Label 6900 4450 2    50   ~ 0
RD6
Wire Wire Line
	6700 4550 6900 4550
Text Label 6900 4750 2    50   ~ 0
RD3
$Comp
L power:GND #PWR0108
U 1 1 603045A0
P 9400 2150
F 0 "#PWR0108" H 9400 1900 50  0001 C CNN
F 1 "GND" H 9400 2000 50  0000 C CNN
F 2 "" H 9400 2150 50  0001 C CNN
F 3 "" H 9400 2150 50  0001 C CNN
	1    9400 2150
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 603045AC
P 9400 2550
F 0 "#PWR0130" H 9400 2300 50  0001 C CNN
F 1 "GND" H 9400 2400 50  0000 C CNN
F 2 "" H 9400 2550 50  0001 C CNN
F 3 "" H 9400 2550 50  0001 C CNN
	1    9400 2550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0133
U 1 1 603045B8
P 9400 2950
F 0 "#PWR0133" H 9400 2700 50  0001 C CNN
F 1 "GND" H 9400 2800 50  0000 C CNN
F 2 "" H 9400 2950 50  0001 C CNN
F 3 "" H 9400 2950 50  0001 C CNN
	1    9400 2950
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C19
U 1 1 5FB36CFE
P 9000 3250
F 0 "C19" H 9050 3300 50  0000 L CNN
F 1 "2u2" H 9050 3200 50  0000 L CNN
F 2 "stdpads:C_0603" H 9000 3250 50  0001 C CNN
F 3 "~" H 9000 3250 50  0001 C CNN
F 4 "C23630" H 9000 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9000 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 3250 50  0001 C CNN "Notes"
	1    9000 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C21
U 1 1 5FB22AAD
P 9000 2450
F 0 "C21" H 9050 2500 50  0000 L CNN
F 1 "2u2" H 9050 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 9000 2450 50  0001 C CNN
F 3 "~" H 9000 2450 50  0001 C CNN
F 4 "C23630" H 9000 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9000 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 2450 50  0001 C CNN "Notes"
	1    9000 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C20
U 1 1 5FAE052B
P 8600 2450
F 0 "C20" H 8650 2500 50  0000 L CNN
F 1 "2u2" H 8650 2400 50  0000 L CNN
F 2 "stdpads:C_0603" H 8600 2450 50  0001 C CNN
F 3 "~" H 8600 2450 50  0001 C CNN
F 4 "C23630" H 8600 2450 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8600 2450 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 2450 50  0001 C CNN "Notes"
	1    8600 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C28
U 1 1 603A0238
P 9400 2850
F 0 "C28" H 9450 2900 50  0000 L CNN
F 1 "2u2" H 9450 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 9400 2850 50  0001 C CNN
F 3 "~" H 9400 2850 50  0001 C CNN
F 4 "C23630" H 9400 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9400 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9400 2850 50  0001 C CNN "Notes"
	1    9400 2850
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C27
U 1 1 603A0244
P 9000 2850
F 0 "C27" H 9050 2900 50  0000 L CNN
F 1 "2u2" H 9050 2800 50  0000 L CNN
F 2 "stdpads:C_0603" H 9000 2850 50  0001 C CNN
F 3 "~" H 9000 2850 50  0001 C CNN
F 4 "C23630" H 9000 2850 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 9000 2850 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 2850 50  0001 C CNN "Notes"
	1    9000 2850
	1    0    0    -1  
$EndComp
Text Label 6700 3750 0    50   ~ 0
~WE~
Text Label 6700 4250 0    50   ~ 0
~CAS~
Text Label 6700 3850 0    50   ~ 0
~CS~
Text Label 6700 5150 0    50   ~ 0
BA0
Text Label 8500 5250 2    50   ~ 0
RA11
Entry Wire Line
	8300 5250 8200 5350
Wire Wire Line
	8300 5250 8500 5250
Text Label 6700 3250 0    50   ~ 0
BA1
Text Label 3950 2250 0    50   ~ 0
RCLK
Text Label 6700 3150 0    50   ~ 0
RA9
Text Label 6700 2450 0    50   ~ 0
RA8
Text Label 6700 2250 0    50   ~ 0
RA0
Text Label 6700 2050 0    50   ~ 0
RA7
Text Label 6700 2850 0    50   ~ 0
RA1
Text Label 6700 2750 0    50   ~ 0
RA6
Text Label 6700 2650 0    50   ~ 0
RA2
Text Label 6700 2550 0    50   ~ 0
RA5
Text Label 6700 2350 0    50   ~ 0
RA3
Text Label 6700 2150 0    50   ~ 0
RA4
Wire Wire Line
	6900 4950 6700 4950
Wire Wire Line
	6900 5050 6700 5050
Wire Wire Line
	6900 4350 6700 4350
Wire Wire Line
	6900 4450 6700 4450
Wire Wire Line
	6900 4650 6700 4650
Wire Wire Line
	6900 4850 6700 4850
Wire Wire Line
	6900 4750 6700 4750
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J2
U 1 1 5EC5BECD
P 1150 2700
F 0 "J2" H 1200 3000 50  0000 C CNN
F 1 "JTAG" H 1200 2400 50  0000 C CNN
F 2 "stdpads:TC2050" H 1150 2700 50  0001 C CNN
F 3 "~" H 1150 2700 50  0001 C CNN
F 4 "DNP - test pad connector" H 1150 2700 50  0001 C CNN "Notes"
	1    1150 2700
	1    0    0    -1  
$EndComp
Text Label 4600 5850 2    50   ~ 0
TMS
Text Label 4600 5950 2    50   ~ 0
TDI
Text Label 4600 6050 2    50   ~ 0
TCKr
Text Label 4600 6150 2    50   ~ 0
TDO
Text Label 950  2600 2    50   ~ 0
TMS
Text Label 950  2700 2    50   ~ 0
TDI
Text Label 950  2500 2    50   ~ 0
TCK
Text Label 950  2800 2    50   ~ 0
TDO
$Comp
L power:GND #PWR0142
U 1 1 5ECB57FA
P 1450 2500
F 0 "#PWR0142" H 1450 2250 50  0001 C CNN
F 1 "GND" H 1450 2350 50  0000 C CNN
F 2 "" H 1450 2500 50  0001 C CNN
F 3 "" H 1450 2500 50  0001 C CNN
	1    1450 2500
	-1   0    0    1   
$EndComp
$Comp
L power:+3V3 #PWR0143
U 1 1 5ECB6670
P 1550 2700
F 0 "#PWR0143" H 1550 2550 50  0001 C CNN
F 1 "+3V3" H 1550 2850 50  0000 C CNN
F 2 "" H 1550 2700 50  0001 C CNN
F 3 "" H 1550 2700 50  0001 C CNN
	1    1550 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 2700 1450 2700
NoConn ~ 1450 2800
NoConn ~ 950  2900
Wire Wire Line
	1900 6900 1600 6900
Wire Wire Line
	3600 3250 3400 3250
Text Label 3950 2550 0    50   ~ 0
ACLK
Text Label 2400 6850 0    50   ~ 0
MD0
Text Label 2400 6750 0    50   ~ 0
MD1
Text Label 2400 6950 0    50   ~ 0
MD6
Text Label 2400 7050 0    50   ~ 0
MD7
Wire Wire Line
	2400 7050 2600 7050
Wire Wire Line
	2400 6950 2600 6950
Wire Wire Line
	2400 6750 2600 6750
Wire Wire Line
	2400 6850 2600 6850
Wire Wire Line
	4400 3450 4600 3450
Wire Wire Line
	4400 3550 4600 3550
Wire Wire Line
	4400 3350 4600 3350
Wire Wire Line
	4400 3250 4600 3250
Text Label 4400 3250 0    50   ~ 0
Din7
Text Label 4400 3350 0    50   ~ 0
Din6
Text Label 4400 3550 0    50   ~ 0
Din1
Text Label 4400 3450 0    50   ~ 0
Din0
Wire Wire Line
	6900 6150 6700 6150
Wire Wire Line
	6900 6050 6700 6050
Text Label 6900 6050 2    50   ~ 0
Dout7
Text Label 6900 6150 2    50   ~ 0
Dout6
Text Label 2400 4350 0    50   ~ 0
MD4
Text Label 2400 4450 0    50   ~ 0
MD5
Wire Wire Line
	2400 4450 2600 4450
Wire Wire Line
	2400 4350 2600 4350
Text Label 4400 3850 0    50   ~ 0
Din4
Text Label 4400 3950 0    50   ~ 0
Din5
Wire Wire Line
	4400 3950 4600 3950
Wire Wire Line
	4400 3850 4600 3850
Text Label 2400 6550 0    50   ~ 0
MD2
Text Label 2400 6650 0    50   ~ 0
MD3
Wire Wire Line
	2400 6650 2600 6650
Wire Wire Line
	2400 6550 2600 6550
Wire Wire Line
	4400 3750 4600 3750
Wire Wire Line
	4400 3650 4600 3650
Text Label 4400 3650 0    50   ~ 0
Din3
Text Label 4400 3750 0    50   ~ 0
Din2
Wire Wire Line
	3600 5650 3400 5650
Wire Wire Line
	3600 5550 3400 5550
Text Label 3600 5650 2    50   ~ 0
Vout2
Text Label 3600 5450 2    50   ~ 0
Vout1
Text Label 3600 5850 2    50   ~ 0
Vout4
Text Label 3600 5550 2    50   ~ 0
Vout5
Wire Wire Line
	3600 5850 3400 5850
Wire Wire Line
	3600 5450 3400 5450
Wire Wire Line
	8200 1950 8600 1950
Wire Wire Line
	8200 2150 8600 2150
Wire Wire Line
	7400 3150 7800 3150
Wire Wire Line
	9000 3150 9400 3150
Wire Wire Line
	9400 3350 9000 3350
Wire Wire Line
	7800 3350 7400 3350
Connection ~ 9000 3350
$Comp
L power:GND #PWR0135
U 1 1 5FD2BEA7
P 9400 3350
F 0 "#PWR0135" H 9400 3100 50  0001 C CNN
F 1 "GND" H 9400 3200 50  0000 C CNN
F 2 "" H 9400 3350 50  0001 C CNN
F 3 "" H 9400 3350 50  0001 C CNN
	1    9400 3350
	-1   0    0    -1  
$EndComp
Connection ~ 8600 1950
Connection ~ 8600 2150
Wire Wire Line
	7400 2550 7800 2550
Wire Wire Line
	7400 2350 7800 2350
Connection ~ 9000 1950
Connection ~ 9000 2150
Connection ~ 9400 2150
Wire Wire Line
	8600 1950 9000 1950
Wire Wire Line
	8600 2150 9000 2150
Wire Wire Line
	9000 1950 9400 1950
Wire Wire Line
	9000 2150 9400 2150
Connection ~ 7400 2350
Connection ~ 7800 2350
Wire Wire Line
	7800 2350 8200 2350
Connection ~ 7800 2550
Wire Wire Line
	7800 2550 8200 2550
Wire Wire Line
	8200 2350 8600 2350
Wire Wire Line
	8200 2550 8600 2550
Connection ~ 8600 2350
Wire Wire Line
	8600 2350 9000 2350
Connection ~ 8600 2550
Wire Wire Line
	8600 2550 9000 2550
Connection ~ 9000 2350
Wire Wire Line
	9000 2350 9400 2350
Connection ~ 9000 2550
Wire Wire Line
	9000 2550 9400 2550
Connection ~ 9400 2550
Wire Wire Line
	7400 2950 7800 2950
Wire Wire Line
	7400 2750 7800 2750
Connection ~ 7400 2750
Connection ~ 7800 2750
Connection ~ 7800 2950
Wire Wire Line
	7800 2950 8200 2950
Wire Wire Line
	7800 2750 8200 2750
Connection ~ 8200 2750
Wire Wire Line
	8200 2750 8600 2750
Connection ~ 8200 2950
Wire Wire Line
	8200 2950 8600 2950
Connection ~ 8600 2750
Wire Wire Line
	8600 2750 9000 2750
Connection ~ 8600 2950
Wire Wire Line
	8600 2950 9000 2950
Connection ~ 9000 2750
Wire Wire Line
	9000 2750 9400 2750
Connection ~ 9000 2950
Wire Wire Line
	9000 2950 9400 2950
Connection ~ 9400 2950
Connection ~ 9400 3350
$Comp
L power:+5V #PWR0145
U 1 1 5FE48C73
P 7400 3150
F 0 "#PWR0145" H 7400 3000 50  0001 C CNN
F 1 "+5V" H 7400 3300 50  0000 C CNN
F 2 "" H 7400 3150 50  0001 C CNN
F 3 "" H 7400 3150 50  0001 C CNN
	1    7400 3150
	1    0    0    -1  
$EndComp
Connection ~ 7400 3150
Connection ~ 7800 3350
Wire Wire Line
	7800 3150 8200 3150
Connection ~ 7800 3150
$Comp
L Device:C_Small C29
U 1 1 5FE97ED3
P 8200 3250
F 0 "C29" H 8250 3300 50  0000 L CNN
F 1 "10u" H 8250 3200 50  0000 L CNN
F 2 "stdpads:C_0805" H 8200 3250 50  0001 C CNN
F 3 "~" H 8200 3250 50  0001 C CNN
F 4 "C15850" H 8200 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 8200 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8200 3250 50  0001 C CNN "Notes"
	1    8200 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 3350 8200 3350
Wire Wire Line
	1900 7250 1900 7350
Wire Wire Line
	3600 6950 3400 6950
Wire Wire Line
	3600 6850 3400 6850
Wire Wire Line
	3600 7050 3400 7050
Wire Wire Line
	3600 7150 3400 7150
Text Label 3600 7150 2    50   ~ 0
Dout7
Text Label 3600 7050 2    50   ~ 0
Dout6
Text Label 3600 6850 2    50   ~ 0
Dout1
Text Label 3600 6950 2    50   ~ 0
Dout0
Text Label 3600 6550 2    50   ~ 0
Dout4
Text Label 3600 6450 2    50   ~ 0
Dout5
Wire Wire Line
	3600 6450 3400 6450
Wire Wire Line
	3600 6550 3400 6550
Wire Wire Line
	3600 6650 3400 6650
Wire Wire Line
	3600 6750 3400 6750
Text Label 3600 6750 2    50   ~ 0
Dout3
Text Label 3600 6650 2    50   ~ 0
Dout2
$Comp
L GW_Logic:74245 U4
U 1 1 5F3A2248
P 3000 2800
F 0 "U4" H 3000 3400 50  0000 C CNN
F 1 "74LVC245APW" H 3000 2200 50  0000 C CNN
F 2 "stdpads:TSSOP-20_4.4x6.5mm_P0.65mm" H 3000 2150 50  0001 C TNN
F 3 "" H 3000 2900 60  0001 C CNN
F 4 "C6082" H 3000 2800 50  0001 C CNN "LCSC Part"
F 5 "NXP 74LVC245APW, TI SN74LVC245APW" H 3000 2800 50  0001 C CNN "Mfg. Part Numbers"
	1    3000 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R7
U 1 1 5E94455C
P 2200 7150
F 0 "R7" H 2150 7200 50  0000 R CNN
F 1 "DNP" H 2150 7100 50  0000 R CNN
F 2 "stdpads:R_0805" H 2200 7150 50  0001 C CNN
F 3 "~" H 2200 7150 50  0001 C CNN
	1    2200 7150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2200 7250 1900 7250
Connection ~ 1900 7250
Wire Wire Line
	1900 7050 2200 7050
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 5CC7E0B9
P 1300 6800
F 0 "H3" H 1400 6851 50  0000 L CNN
F 1 " " H 1400 6760 50  0000 L CNN
F 2 "stdpads:PasteHole_1.152mm_NPTH" H 1300 6800 50  0001 C CNN
F 3 "~" H 1300 6800 50  0001 C CNN
F 4 "DNP - mounting hole for solder paste printing" H 1300 6800 50  0001 C CNN "Notes"
	1    1300 6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 5CC7E0C0
P 1600 6800
F 0 "H4" H 1700 6851 50  0000 L CNN
F 1 " " H 1700 6760 50  0000 L CNN
F 2 "stdpads:PasteHole_1.152mm_NPTH" H 1600 6800 50  0001 C CNN
F 3 "~" H 1600 6800 50  0001 C CNN
F 4 "DNP - mounting hole for solder paste printing" H 1600 6800 50  0001 C CNN "Notes"
	1    1600 6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H5
U 1 1 5ED15A93
P 1900 6800
F 0 "H5" H 2000 6851 50  0000 L CNN
F 1 " " H 2000 6760 50  0000 L CNN
F 2 "stdpads:PasteHole_1.1mm_PTH" H 1900 6800 50  0001 C CNN
F 3 "~" H 1900 6800 50  0001 C CNN
F 4 "DNP - mounting hole" H 1900 6800 50  0001 C CNN "Notes"
	1    1900 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0146
U 1 1 5FAF09E9
P 8500 5350
F 0 "#PWR0146" H 8500 5100 50  0001 C CNN
F 1 "GND" H 8500 5200 50  0000 C CNN
F 2 "" H 8500 5350 50  0001 C CNN
F 3 "" H 8500 5350 50  0001 C CNN
	1    8500 5350
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C5
U 1 1 5CB37AA0
P 9000 950
F 0 "C5" H 9050 1000 50  0000 L CNN
F 1 "10u" H 9050 900 50  0000 L CNN
F 2 "stdpads:C_0805" H 9000 950 50  0001 C CNN
F 3 "~" H 9000 950 50  0001 C CNN
F 4 "C15850" H 9000 950 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 9000 950 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 9000 950 50  0001 C CNN "Notes"
	1    9000 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0138
U 1 1 5FD6B01D
P 9000 1750
F 0 "#PWR0138" H 9000 1500 50  0001 C CNN
F 1 "GND" H 9000 1600 50  0000 C CNN
F 2 "" H 9000 1750 50  0001 C CNN
F 3 "" H 9000 1750 50  0001 C CNN
	1    9000 1750
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 5C4F04D1
P 8600 950
F 0 "C4" H 8650 1000 50  0000 L CNN
F 1 "10u" H 8650 900 50  0000 L CNN
F 2 "stdpads:C_0805" H 8600 950 50  0001 C CNN
F 3 "~" H 8600 950 50  0001 C CNN
F 4 "C15850" H 8600 950 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 8600 950 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 950 50  0001 C CNN "Notes"
	1    8600 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 1750 9000 1650
Wire Wire Line
	8600 1750 7700 1750
$Comp
L GW_Power:AP2125 U8
U 1 1 5F5E8C45
P 8150 1450
F 0 "U8" H 8150 1700 50  0000 C CNN
F 1 "XC6206P332MR" H 8150 1200 50  0000 C CNN
F 2 "stdpads:SOT-23" H 8150 1150 50  0001 C TNN
F 3 "" H 8150 1350 60  0001 C CNN
F 4 "C5446" H 8150 1450 50  0001 C CNN "LCSC Part"
F 5 "Torex XC6206P332MR" H 8150 1450 50  0001 C CNN "Mfg. Part Numbers"
	1    8150 1450
	1    0    0    -1  
$EndComp
Connection ~ 7700 1750
$Comp
L Device:C_Small C2
U 1 1 5F4A1C4C
P 8600 1550
F 0 "C2" H 8650 1600 50  0000 L CNN
F 1 "10u" H 8650 1500 50  0000 L CNN
F 2 "stdpads:C_0805" H 8600 1550 50  0001 C CNN
F 3 "~" H 8600 1550 50  0001 C CNN
F 4 "C15850" H 8600 1550 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 8600 1550 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 1550 50  0001 C CNN "Notes"
	1    8600 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 1450 8600 1350
Wire Wire Line
	8600 1750 9000 1750
Wire Wire Line
	9000 1350 8600 1350
Wire Wire Line
	8600 1750 8600 1650
NoConn ~ 3400 2650
Connection ~ 2600 3250
$Comp
L Device:C_Small C6
U 1 1 5F6B9584
P 7400 950
F 0 "C6" H 7450 1000 50  0000 L CNN
F 1 "10u" H 7450 900 50  0000 L CNN
F 2 "stdpads:C_0805" H 7400 950 50  0001 C CNN
F 3 "~" H 7400 950 50  0001 C CNN
F 4 "C15850" H 7400 950 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL21A106KAYNNNE" H 7400 950 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 7400 950 50  0001 C CNN "Notes"
	1    7400 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 750  7400 850 
Wire Wire Line
	7400 1150 7400 1050
Wire Wire Line
	9000 850  9000 750 
$Comp
L power:+5V #PWR0103
U 1 1 5F6B958F
P 7400 750
F 0 "#PWR0103" H 7400 600 50  0001 C CNN
F 1 "+5V" H 7400 900 50  0000 C CNN
F 2 "" H 7400 750 50  0001 C CNN
F 3 "" H 7400 750 50  0001 C CNN
	1    7400 750 
	1    0    0    -1  
$EndComp
Connection ~ 7400 750 
$Comp
L power:GND #PWR0127
U 1 1 5F6B95AE
P 9000 1150
F 0 "#PWR0127" H 9000 900 50  0001 C CNN
F 1 "GND" H 9000 1000 50  0000 C CNN
F 2 "" H 9000 1150 50  0001 C CNN
F 3 "" H 9000 1150 50  0001 C CNN
	1    9000 1150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9000 1150 9000 1050
Wire Wire Line
	8600 850  8600 750 
Wire Wire Line
	8600 1150 9000 1150
Wire Wire Line
	9000 750  8600 750 
Wire Wire Line
	8600 1150 8600 1050
Wire Wire Line
	8600 1150 8150 1150
$Comp
L Regulator_Linear:AP2127K-1.2 U9
U 1 1 5F6DD402
P 8150 850
F 0 "U9" H 8150 850 50  0000 C BNN
F 1 "AP2127K-1.2TRG1" H 8150 1050 50  0000 C BNN
F 2 "stdpads:SOT-23-5" H 8150 1175 50  0001 C CNN
F 3 "" H 8150 950 50  0001 C CNN
F 4 "" H 8150 850 50  0001 C CNN "LCSC Part"
F 5 "" H 8150 850 50  0001 C CNN "Mfg. Part Numbers"
	1    8150 850 
	1    0    0    -1  
$EndComp
Connection ~ 8150 1150
Wire Wire Line
	7400 1150 8150 1150
Wire Wire Line
	7850 750  7850 850 
Wire Wire Line
	7400 750  7850 750 
Connection ~ 7850 750 
Wire Wire Line
	8600 750  8450 750 
Connection ~ 8600 750 
Connection ~ 8600 1350
Connection ~ 9000 1150
Connection ~ 9000 1750
Connection ~ 9000 750 
$Comp
L Device:R_Small R1
U 1 1 5FA85B84
P 9100 750
F 0 "R1" V 9050 750 50  0000 C BNN
F 1 "0 " V 9150 750 50  0000 C TNN
F 2 "stdpads:R_0805" H 9100 750 50  0001 C CNN
F 3 "~" H 9100 750 50  0001 C CNN
F 4 "C17477" V 9100 750 50  0001 C CNN "LCSC Part"
F 5 "Uniroyal 0805W8F2202T5E" H 9100 750 50  0001 C CNN "Mfg. Part Numbers"
F 6 "Any manufacturer's part is acceptable." H 9100 750 50  0001 C CNN "Notes"
	1    9100 750 
	0    1    1    0   
$EndComp
$Comp
L power:+3V3 #PWR0144
U 1 1 5FA8758E
P 9300 750
F 0 "#PWR0144" H 9300 600 50  0001 C CNN
F 1 "+3V3" H 9300 900 50  0000 C CNN
F 2 "" H 9300 750 50  0001 C CNN
F 3 "" H 9300 750 50  0001 C CNN
	1    9300 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 750  9200 750 
Wire Wire Line
	3500 850  3500 1150
Wire Wire Line
	3500 2350 3500 2450
Wire Wire Line
	3400 2750 3750 2750
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 608879CA
P 1050 1150
F 0 "J3" H 1050 1250 50  0000 C CNN
F 1 "C14M" H 1050 950 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1050 1150 50  0001 C CNN
F 3 "~" H 1050 1150 50  0001 C CNN
F 4 "DNP" H 1050 1150 50  0001 C CNN "Notes"
	1    1050 1150
	-1   0    0    -1  
$EndComp
Text Label 1250 1150 0    50   ~ 0
C14MB
$Comp
L power:GND #PWR0147
U 1 1 6088870C
P 1250 1250
F 0 "#PWR0147" H 1250 1000 50  0001 C CNN
F 1 "GND" H 1250 1100 50  0000 C CNN
F 2 "" H 1250 1250 50  0001 C CNN
F 3 "" H 1250 1250 50  0001 C CNN
	1    1250 1250
	1    0    0    -1  
$EndComp
Text Label 3950 2750 0    50   ~ 0
C14MB
$Comp
L Device:R_Small R2
U 1 1 6088A353
P 2250 2450
F 0 "R2" V 2400 2450 50  0000 C CNN
F 1 "47" V 2300 2450 50  0000 C TNN
F 2 "stdpads:R_0603" H 2250 2450 50  0001 C CNN
F 3 "~" H 2250 2450 50  0001 C CNN
F 4 "C23182" V 2250 2450 50  0001 C CNN "LCSC Part"
F 5 "Any manufacturer's part is acceptable." H 2250 2450 50  0001 C CNN "Notes"
F 6 "Uniroyal 0603WAF470JT5E" H 2250 2450 50  0001 C CNN "Mfg. Part Numbers"
	1    2250 2450
	0    1    -1   0   
$EndComp
Text Label 2600 2450 2    50   ~ 0
C14MR
Wire Wire Line
	2300 3250 2600 3250
Wire Wire Line
	2600 2550 2300 2550
Wire Wire Line
	2300 2550 2300 3250
Wire Wire Line
	2500 2650 2600 2650
Connection ~ 2500 2450
Wire Wire Line
	2350 2450 2500 2450
Wire Wire Line
	2600 2450 2500 2450
Wire Wire Line
	2500 2450 2500 2650
$Comp
L Device:R_Small R6
U 1 1 602F9D9A
P 1900 7150
F 0 "R6" H 1850 7200 50  0000 R CNN
F 1 "0" H 1850 7100 50  0000 R CNN
F 2 "stdpads:R_0805" H 1900 7150 50  0001 C CNN
F 3 "~" H 1900 7150 50  0001 C CNN
F 4 "C17477" H 1900 7150 50  0001 C CNN "LCSC Part"
F 5 "Uniroyal 0805W8F2202T5E" H 1900 7150 50  0001 C CNN "Mfg. Part Numbers"
F 6 "Any manufacturer's part is acceptable." H 1900 7150 50  0001 C CNN "Notes"
	1    1900 7150
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 5F2D98D8
P 5150 6450
F 0 "#PWR0113" H 5150 6200 50  0001 C CNN
F 1 "GND" H 5150 6300 50  0000 C CNN
F 2 "" H 5150 6450 50  0001 C CNN
F 3 "" H 5150 6450 50  0001 C CNN
	1    5150 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4150 4400 4150
Text Label 4400 4150 0    50   ~ 0
V~OE~
Text Label 6700 2950 0    50   ~ 0
RA10
Text Label 6700 3050 0    50   ~ 0
ACLK
Text Label 6700 3650 0    50   ~ 0
RA11
$Comp
L power:+1V2 #PWR0128
U 1 1 60C40167
P 6050 1650
F 0 "#PWR0128" H 6050 1500 50  0001 C CNN
F 1 "+1V2" H 6050 1800 50  0000 C CNN
F 2 "" H 6050 1650 50  0001 C CNN
F 3 "" H 6050 1650 50  0001 C CNN
	1    6050 1650
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0136
U 1 1 60C40FE4
P 5150 1650
F 0 "#PWR0136" H 5150 1500 50  0001 C CNN
F 1 "+3V3" H 5165 1823 50  0000 C CNN
F 2 "" H 5150 1650 50  0001 C CNN
F 3 "" H 5150 1650 50  0001 C CNN
	1    5150 1650
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0112
U 1 1 60CC99DE
P 9000 3150
F 0 "#PWR0112" H 9000 3000 50  0001 C CNN
F 1 "+1V2" H 9000 3300 50  0000 C CNN
F 2 "" H 9000 3150 50  0001 C CNN
F 3 "" H 9000 3150 50  0001 C CNN
	1    9000 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0137
U 1 1 60D524FA
P 8600 750
F 0 "#PWR0137" H 8600 600 50  0001 C CNN
F 1 "+1V2" H 8600 900 50  0000 C CNN
F 2 "" H 8600 750 50  0001 C CNN
F 3 "" H 8600 750 50  0001 C CNN
	1    8600 750 
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0150
U 1 1 60A1B93A
P 6700 1950
F 0 "#PWR0150" H 6700 1800 50  0001 C CNN
F 1 "+3V3" H 6700 2100 50  0000 C CNN
F 2 "" H 6700 1950 50  0001 C CNN
F 3 "" H 6700 1950 50  0001 C CNN
	1    6700 1950
	1    0    0    -1  
$EndComp
$Comp
L GW_RAM:SPIFlash-SO-8 U11
U 1 1 60A61FBE
P 5200 7350
F 0 "U11" H 5200 7700 50  0000 C CNN
F 1 "25F010" H 5200 7100 50  0000 C CNN
F 2 "stdpads:SOIC-8_5.3mm" H 5200 7050 50  0001 C TNN
F 3 "" H 5200 7350 50  0001 C TNN
	1    5200 7350
	1    0    0    -1  
$EndComp
Text Label 4650 7150 2    50   ~ 0
S~CS~
Text Label 5750 7350 0    50   ~ 0
SCK
Text Label 4650 7250 2    50   ~ 0
MISO
$Comp
L power:GND #PWR0151
U 1 1 60B665B9
P 4650 7450
F 0 "#PWR0151" H 4650 7200 50  0001 C CNN
F 1 "GND" H 4650 7300 50  0000 C CNN
F 2 "" H 4650 7450 50  0001 C CNN
F 3 "" H 4650 7450 50  0001 C CNN
	1    4650 7450
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0152
U 1 1 60B67ABA
P 5750 7150
F 0 "#PWR0152" H 5750 7000 50  0001 C CNN
F 1 "+3V3" H 5750 7300 50  0000 C CNN
F 2 "" H 5750 7150 50  0001 C CNN
F 3 "" H 5750 7150 50  0001 C CNN
	1    5750 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 7150 5750 7250
Connection ~ 5750 7150
$Comp
L power:+3V3 #PWR0153
U 1 1 60B8A317
P 4550 7450
F 0 "#PWR0153" H 4550 7300 50  0001 C CNN
F 1 "+3V3" H 4550 7600 50  0000 C CNN
F 2 "" H 4550 7450 50  0001 C CNN
F 3 "" H 4550 7450 50  0001 C CNN
	1    4550 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 7350 4600 7450
Wire Wire Line
	4600 7450 4550 7450
Text Label 4400 5050 0    50   ~ 0
D~OE~
Wire Wire Line
	4400 5050 4600 5050
Wire Wire Line
	4400 4650 4600 4650
Wire Wire Line
	6900 5750 6700 5750
Wire Wire Line
	4400 4550 4600 4550
Text Label 4400 4550 0    50   ~ 0
Vout3
Text Label 6900 5750 2    50   ~ 0
Vout0
Text Label 4400 4650 0    50   ~ 0
Vout6
Wire Wire Line
	6900 5550 6700 5550
Wire Wire Line
	4400 4850 4600 4850
Text Label 6900 5550 2    50   ~ 0
Vout2
Text Label 4400 4750 0    50   ~ 0
Vout1
Text Label 4400 4950 0    50   ~ 0
Vout4
Text Label 4400 4850 0    50   ~ 0
Vout5
Wire Wire Line
	4400 4950 4600 4950
Wire Wire Line
	4400 4750 4600 4750
Wire Wire Line
	3600 4050 3400 4050
Wire Wire Line
	3600 4150 3400 4150
Wire Wire Line
	3600 3950 3400 3950
Text Label 3600 3950 2    50   ~ 0
Din6
Text Label 3600 4150 2    50   ~ 0
Din1
Text Label 3600 4050 2    50   ~ 0
Din0
Text Label 3600 4450 2    50   ~ 0
Din4
Text Label 3600 4550 2    50   ~ 0
Din5
Wire Wire Line
	3600 4550 3400 4550
Wire Wire Line
	3600 4450 3400 4450
Wire Wire Line
	3600 4350 3400 4350
Wire Wire Line
	3600 4250 3400 4250
Text Label 3600 4250 2    50   ~ 0
Din3
Text Label 3600 4350 2    50   ~ 0
Din2
Wire Wire Line
	3600 3850 3400 3850
Text Label 3600 3850 2    50   ~ 0
Din7
Wire Wire Line
	4400 2750 4600 2750
Text Label 4400 2850 0    50   ~ 0
Ain2
Text Label 4400 2750 0    50   ~ 0
Ain1
Wire Wire Line
	4400 2850 4600 2850
Text Label 4400 2950 0    50   ~ 0
Ain3
Wire Wire Line
	4400 2950 4600 2950
Text Label 4600 3050 2    50   ~ 0
~C07X~in
Text Label 4600 3150 2    50   ~ 0
R~W~in
Text Label 4400 2650 0    50   ~ 0
Ain6
Wire Wire Line
	4400 2650 4600 2650
Text Label 4600 2550 2    50   ~ 0
PHI1in
Wire Wire Line
	4400 2450 4600 2450
Text Label 4400 2450 0    50   ~ 0
Ain4
Wire Wire Line
	4400 2250 4600 2250
Text Label 4400 2250 0    50   ~ 0
Ain0
Wire Wire Line
	4400 2350 4600 2350
Text Label 4400 2350 0    50   ~ 0
Ain5
Text Label 4600 1950 2    50   ~ 0
~EN80~in
Text Label 4600 2150 2    50   ~ 0
R~W~80in
Wire Wire Line
	4400 2050 4600 2050
Text Label 4400 2050 0    50   ~ 0
Ain7
Wire Wire Line
	4400 5650 4600 5650
Wire Wire Line
	4400 5550 4600 5550
Text Label 4400 5550 0    50   ~ 0
Dout1
Text Label 4400 5650 0    50   ~ 0
Dout0
Text Label 4400 5250 0    50   ~ 0
Dout4
Text Label 4400 5150 0    50   ~ 0
Dout5
Wire Wire Line
	4400 5150 4600 5150
Wire Wire Line
	4400 5250 4600 5250
Wire Wire Line
	4400 5350 4600 5350
Wire Wire Line
	4400 5450 4600 5450
Text Label 4400 5450 0    50   ~ 0
Dout3
Text Label 4400 5350 0    50   ~ 0
Dout2
Connection ~ 9000 3150
Wire Wire Line
	8200 3350 8600 3350
Connection ~ 8200 3350
$Comp
L Device:C_Small C30
U 1 1 6134BBDF
P 8600 3250
F 0 "C30" H 8650 3300 50  0000 L CNN
F 1 "2u2" H 8650 3200 50  0000 L CNN
F 2 "stdpads:C_0603" H 8600 3250 50  0001 C CNN
F 3 "~" H 8600 3250 50  0001 C CNN
F 4 "C23630" H 8600 3250 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 8600 3250 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 8600 3250 50  0001 C CNN "Notes"
	1    8600 3250
	1    0    0    -1  
$EndComp
Connection ~ 8600 3350
Wire Wire Line
	8600 3350 9000 3350
$Comp
L power:+3V3 #PWR0154
U 1 1 6134C43B
P 8600 3150
F 0 "#PWR0154" H 8600 3000 50  0001 C CNN
F 1 "+3V3" H 8600 3300 50  0000 C CNN
F 2 "" H 8600 3150 50  0001 C CNN
F 3 "" H 8600 3150 50  0001 C CNN
	1    8600 3150
	1    0    0    -1  
$EndComp
Text Label 5750 7450 0    50   ~ 0
MOSI
Text Label 6700 5950 0    50   ~ 0
MOSI
Text Label 6700 5850 0    50   ~ 0
SCK
Text Label 6700 5650 0    50   ~ 0
MISO
Text Label 6700 5450 0    50   ~ 0
S~CS~
Wire Wire Line
	6700 3950 6900 3950
Wire Wire Line
	6700 5250 6900 5250
Text Label 6900 5250 2    50   ~ 0
DQML
Text Label 6900 3950 2    50   ~ 0
DQMH
Text Label 6700 3350 0    50   ~ 0
CKE
Text Label 6700 4150 0    50   ~ 0
~RAS~
NoConn ~ 1450 2900
Wire Wire Line
	1450 2500 1450 2600
Connection ~ 1450 2500
Text Label 1050 1900 0    50   ~ 0
TCKr
$Comp
L power:GND #PWR0148
U 1 1 5EBEEA76
P 1250 2100
F 0 "#PWR0148" H 1250 1850 50  0001 C CNN
F 1 "GND" H 1250 1950 50  0000 C CNN
F 2 "" H 1250 2100 50  0001 C CNN
F 3 "" H 1250 2100 50  0001 C CNN
	1    1250 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R9
U 1 1 5EBE988D
P 950 2000
F 0 "R9" H 900 2050 50  0000 R CNN
F 1 "10k" H 900 1950 50  0000 R CNN
F 2 "stdpads:R_0603" H 950 2000 50  0001 C CNN
F 3 "~" H 950 2000 50  0001 C CNN
F 4 "C17560" H 950 2000 50  0001 C CNN "LCSC Part"
F 5 "Uniroyal 0805W8F2202T5E" H 950 2000 50  0001 C CNN "Mfg. Part Numbers"
F 6 "Any manufacturer's part is acceptable." H 950 2000 50  0001 C CNN "Notes"
	1    950  2000
	-1   0    0    -1  
$EndComp
$Comp
L GW_PLD:LCMXO640-TQFP-100 U1
U 1 1 627ADA3D
P 5650 4050
F 0 "U1" H 5650 4150 50  0000 C CNN
F 1 "LCMXO640-3TN100C" H 5650 4050 40  0000 C CNN
F 2 "stdpads:TQFP-100_14x14mm_P0.5mm" H 5650 3950 40  0001 C CNN
F 3 "" H 5650 4150 50  0001 C CNN
	1    5650 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 1650 6150 1650
Wire Wire Line
	5150 1650 5250 1650
Wire Wire Line
	5150 6450 5250 6450
Wire Wire Line
	5850 1650 5950 1650
Wire Wire Line
	5950 6450 6050 6450
Connection ~ 5150 1650
Connection ~ 5150 6450
Connection ~ 6050 1650
Wire Wire Line
	5250 6450 5350 6450
Connection ~ 5250 6450
Connection ~ 5950 6450
Connection ~ 5350 6450
Wire Wire Line
	5350 6450 5450 6450
Connection ~ 5450 6450
Wire Wire Line
	5450 6450 5550 6450
Connection ~ 5550 6450
Wire Wire Line
	5550 6450 5650 6450
Connection ~ 5650 6450
Wire Wire Line
	5650 6450 5750 6450
Connection ~ 5750 6450
Wire Wire Line
	5750 6450 5850 6450
Connection ~ 5850 6450
Wire Wire Line
	5850 6450 5950 6450
Wire Wire Line
	5750 1650 5650 1650
Connection ~ 5250 1650
Connection ~ 5350 1650
Wire Wire Line
	5350 1650 5250 1650
Connection ~ 5450 1650
Wire Wire Line
	5450 1650 5350 1650
Connection ~ 5550 1650
Wire Wire Line
	5550 1650 5450 1650
Connection ~ 5650 1650
Wire Wire Line
	5650 1650 5550 1650
Wire Wire Line
	5850 1650 5750 1650
Connection ~ 5850 1650
Connection ~ 5750 1650
Text Label 4400 4450 0    50   ~ 0
Vout7
Wire Wire Line
	4400 4450 4600 4450
$Comp
L Device:R_Small R5
U 1 1 6109D5DC
P 3850 2550
F 0 "R5" V 3900 2550 50  0000 C TNN
F 1 "47" V 4000 2550 50  0000 C CNN
F 2 "stdpads:R_0603" H 3850 2550 50  0001 C CNN
F 3 "~" H 3850 2550 50  0001 C CNN
F 4 "C23182" V 3850 2550 50  0001 C CNN "LCSC Part"
F 5 "Any manufacturer's part is acceptable." H 3850 2550 50  0001 C CNN "Notes"
F 6 "Uniroyal 0603WAF470JT5E" H 3850 2550 50  0001 C CNN "Mfg. Part Numbers"
	1    3850 2550
	0    1    -1   0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 6109DA5D
P 3850 2250
F 0 "R4" V 3900 2250 50  0000 C TNN
F 1 "47" V 4000 2250 50  0000 C CNN
F 2 "stdpads:R_0603" H 3850 2250 50  0001 C CNN
F 3 "~" H 3850 2250 50  0001 C CNN
F 4 "C23182" V 3850 2250 50  0001 C CNN "LCSC Part"
F 5 "Any manufacturer's part is acceptable." H 3850 2250 50  0001 C CNN "Notes"
F 6 "Uniroyal 0603WAF470JT5E" H 3850 2250 50  0001 C CNN "Mfg. Part Numbers"
	1    3850 2250
	0    1    -1   0   
$EndComp
Wire Wire Line
	3750 2250 3750 2550
Connection ~ 3750 2550
Wire Wire Line
	3400 2550 3750 2550
$Comp
L Device:R_Small R3
U 1 1 6081D682
P 3850 2750
F 0 "R3" V 3900 2750 50  0000 C TNN
F 1 "47" V 4000 2750 50  0000 C CNN
F 2 "stdpads:R_0603" H 3850 2750 50  0001 C CNN
F 3 "~" H 3850 2750 50  0001 C CNN
F 4 "C23182" V 3850 2750 50  0001 C CNN "LCSC Part"
F 5 "Any manufacturer's part is acceptable." H 3850 2750 50  0001 C CNN "Notes"
F 6 "Uniroyal 0603WAF470JT5E" H 3850 2750 50  0001 C CNN "Mfg. Part Numbers"
	1    3850 2750
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R8
U 1 1 61BEAE46
P 1750 750
F 0 "R8" V 1900 750 50  0000 C CNN
F 1 "47" V 1800 750 50  0000 C TNN
F 2 "stdpads:R_0603" H 1750 750 50  0001 C CNN
F 3 "~" H 1750 750 50  0001 C CNN
F 4 "C23182" V 1750 750 50  0001 C CNN "LCSC Part"
F 5 "Any manufacturer's part is acceptable." H 1750 750 50  0001 C CNN "Notes"
F 6 "Uniroyal 0603WAF470JT5E" H 1750 750 50  0001 C CNN "Mfg. Part Numbers"
	1    1750 750 
	0    1    -1   0   
$EndComp
Text Label 1650 750  2    50   ~ 0
TCK
Text Label 1850 750  0    50   ~ 0
TCKr
$Comp
L Device:C_Small C31
U 1 1 61C0B319
P 1250 2000
F 0 "C31" H 1300 2050 50  0000 L CNN
F 1 "2u2" H 1300 1950 50  0000 L CNN
F 2 "stdpads:C_0603" H 1250 2000 50  0001 C CNN
F 3 "~" H 1250 2000 50  0001 C CNN
F 4 "C23630" H 1250 2000 50  0001 C CNN "LCSC Part"
F 5 "Samsung CL10A225KO8NNNC" H 1250 2000 50  0001 C CNN "Mfg. Part Numbers"
F 6 "10V or higher. Any manufacturer's part is acceptable but Samsung, Murata, Yageo preferred." H 1250 2000 50  0001 C CNN "Notes"
	1    1250 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1900 1250 1900
Wire Wire Line
	1250 2100 950  2100
Connection ~ 1250 2100
Wire Bus Line
	8200 4250 8200 5350
$EndSCHEMATC
