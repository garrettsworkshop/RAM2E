module RAM2E(C14M, PHI1, LED, 
             nWE, nWE80, nEN80, nC07X,
             Ain, Din, Dout, nDOE, Vout, nVOE,
             CKE, nCS, nRAS, nCAS, nRWE,
             BA, RA, RD, DQML, DQMH);

    /* Clocks */
    input C14M, PHI1;
    
    /* Control inputs */
    input nWE, nWE80, nEN80, nC07X;
    
    /* Delay for EN80 signal */
    //output DelayOut = 1'b0;
    //input DelayIn;
    wire EN80 = !nEN80;

    /* Activity LED */
    reg LEDEN = 0;
    output LED;
    assign LED = !(!nEN80 && LEDEN);

    /* Address Bus */
    input [7:0] Ain; // Multiplexed DRAM address input
    
    /* 6502 Data Bus */
    input [7:0] Din; // 6502 data bus inputs
    reg DOEEN = 0; // 6502 data bus output enable from state machine
    output nDOE;
    assign nDOE = !(EN80 && nWE && DOEEN); // 6502 data bus output enable
    output reg [7:0] Dout; // 6502 data Bus output
    
    /* Video Data Bus */
    output nVOE;
    assign nVOE = !(!PHI1); /// Video data bus output enable
    output reg [7:0] Vout; // Video data bus

    /* SDRAM */
    output reg CKE = 0;
    output reg nCS = 1, nRAS = 1, nCAS = 1, nRWE = 1;
    output reg [1:0] BA;
    output reg [11:0] RA;
    output reg DQML = 1, DQMH = 1;
    wire RDOE = EN80 && !nWE80;
    inout [7:0] RD;
    assign RD[7:0] = RDOE ? Din[7:0] : 8'bZ;
    
    /* RAMWorks Bank Register and Capacity Mask */
    reg [7:0] RWBank = 0; // RAMWorks bank register
    reg [7:0] RWMask = 0; // RAMWorks bank reg. capacity mask
    reg RWSel = 0; // RAMWorks bank register select
    reg CmdRWMaskSet = 0; // RAMWorks Mask register set flag
    // Causes RWBank to be zeroed next RWSel access
    reg CmdSetRWBankFFMAX = 0;
    //reg CmdSetRWBankFFSPI = 0;
    //reg CmdSetRWBankFFMXO2 = 0;
    reg CmdSetRWBankFFLED = 0;
    reg CmdLEDSet = 0;
    reg CmdLEDGet = 0;
    
    /* Command Sequence Detector */
    reg [2:0] CS = 0; // Command sequence state
    reg [2:0] CmdTout = 0; // Command sequence timeout

    /* UFM Interface */
    reg [15:8] UFMD = 0; // *Parallel* UFM data register
    reg ARCLK = 0; // UFM address register clock
    // UFM address register data input tied to 0
    reg ARShift = 0; // 1 to Shift UFM address in, 0 to increment
    reg DRCLK = 0; // UFM data register clock
    reg DRDIn = 0; // UFM data register input
    reg DRShift = 0; // 1 to shift UFM out, 0 to load from current address
    reg UFMErase = 0; // Rising edge starts erase. UFM+RTP must not be busy
    reg UFMProgram = 0; // Rising edge starts program. UFM+RTP must not be busy
    wire UFMBusy; // 1 if UFM is doing user operation. Asynchronous
    wire RTPBusy; // 1 if real-time programming in progress. Asynchronous
    wire DRDOut; // UFM data output
    // UFM oscillator always enabled
    wire UFMOsc; // UFM oscillator output (3.3-5.5 MHz)
    UFM UFM_inst ( // UFM IP block (for Altera MAX II and MAX V)
        .arclk (ARCLK),
        .ardin (1'b0),
        .arshft (ARShift),
        .drclk (DRCLK),
        .drdin (DRDIn),
        .drshft (DRShift),
        .erase (UFMErase),
        .oscena (1'b1),
        .program (UFMProgram),
        .busy (UFMBusy),
        .drdout (DRDOut),
        .osc (UFMOsc),
        .rtpbusy (RTPBusy));
    reg UFMBusyReg = 0; // UFMBusy registered to sync with C14M
    reg RTPBusyReg = 0; // RTPBusy registered to sync with C14M

    /* UFM State and User Command Triggers */
    reg UFMInitDone = 0; // 1 if UFM initialization finished
    reg UFMReqErase = 0; // 1 if UFM requires erase
    reg CmdBitbangMAX = 0; // Set by user command. Loads UFM outputs next RWSel
    //reg CmdBitbangSPI = 0;
    //reg CmdBitbangMXO2 = 0;
    //reg CmdExecMXO2 = 0;
    reg CmdPrgmMAX = 0; // Set by user command. Programs UFM
    reg CmdEraseMAX = 0; // Set by user command. Erases UFM
    reg DRCLKPulse = 0; // Set by user command. Causes DRCLK pulse next C14M

    /* State Counters */
    reg PHI1reg = 0; // Saved PHI1 at last rising clock edge
    reg Ready = 0; // 1 if done with init sequence (S0) and enter S1-S15
    reg [15:0] FS = 0; // Fast state counter
    reg [3:0] S = 0; // IIe State counter

    /* State Counters */
    always @(posedge C14M) begin
        // Increment fast state counter
        FS <= FS+16'h0001;
        // Synchronize Apple state counter to S1 when just entering PHI1
        PHI1reg <= PHI1; // Save old PHI1
        S <= (PHI1 && !PHI1reg && Ready) ? 4'h1 : 
            S==4'h0 ? 4'h0 :
            S==4'hF ? 4'hF : S+4'h1;
    end

    /* UFM Control */
    always @(posedge C14M) begin // Synchronize asynchronous UFM signals
        UFMBusyReg <= UFMBusy; RTPBusyReg <= RTPBusy;
    end
    always @(posedge C14M) begin
        if (S==4'h0) begin
            if ((FS[15:13]==3'b101) || (FS[15:13]==3'b111 && UFMReqErase)) begin
                // In states AXXX-BXXX and also EXXX-FXXX if erase/wrap req'd
                // shift in 0's to address register
                ARCLK <= FS[0]; // Clock address register
                DRCLK <= 1'b0; // Don't clock data register
                ARShift <= 1'b1; // Shift address registers
                DRDIn <= 1'b0; // Don't care DRDIn
                DRShift <= 1'b0; // Don't care DRDShift
            end else if (!UFMInitDone && FS[15:13]==3'b110 && FS[4:1]==4'h4) begin
                // In states CXXX-DXXX (substep 4)
                // Xfer to data reg (repeat 256x 1x)
                ARCLK <= 1'b0; // Don't clock address register
                DRCLK <= FS[0]; // Clock data register
                ARShift <= 1'b0; // Don't care ARShift
                DRDIn <= 1'b0; // Don't care DRDIn
                DRShift <= 1'b0; // Don't care DRShift
            end else if (!UFMInitDone && FS[15:13]==3'b110 && (FS[4:1]==4'h7 || FS[4]==1'b1)) begin
                // In states CXXX-DXXX (substeps 8-F)
                // Save UFM D15-8, shift out D14-7 (repeat 256x 8x)
                DRCLK <= FS[0]; // Clock data register
                ARShift <= 1'b0; // ARShift is 0 because we want to increment
                DRDIn <= 1'b0; // Don't care what to shift into data register
                DRShift <= 1'b1; // Shift data register
                // Shift into UFMD
                if (FS[0]) UFMD[15:8] <= {UFMD[14:8], DRDOut};

                // Compare and store mask
                if (FS[4:1]==4'hF) begin
                    ARCLK <= FS[0]; // Clock address register to increment
                    // If byte is erased (0xFF, i.e. all 1's, is erased)...
                    if (UFMD[15:8]==8'hFF && DRDOut==1'b1) begin
                        // Current UFM address is where we want to store
                        UFMInitDone <= 1'b1; // Quit iterating
                    // Otherwise byte is valid setting (i.e. some bit is 0)...
                    end else begin
                        // Set RWMask, but if saved mask is 0x80, store ~0xFF
                        if (UFMD[15:8]==8'b10000000) begin
                            RWMask[7:0] <= {1'b1, ~7'h7F};
                        end else RWMask[7:0] <= {UFMD[15], ~UFMD[14:8]};
                        // Set LED setting
                        LEDEN <= DRDOut ^ UFMD[15];
                        // If last byte in sector...
                        if (FS[12:5]==8'hFF) begin
                            UFMReqErase <= 1'b1; // Mark need to erase
                        end
                    end
                end else ARCLK <= 1'b0; // Don't clock address register
            end else begin
                ARCLK <= 1'b0;
                DRCLK <= 1'b0;
                ARShift <= 1'b0;
                DRDIn <= 1'b0;
                DRShift <= 1'b0;
            end

            // Don't erase or program UFM during initialization 
            UFMErase <= 1'b0;
            UFMProgram <= 1'b0;
            // Keep DRCLK pulse control disabled during init
            DRCLKPulse <= 1'b0;
        end else begin
            // Can only shift UFM data register now
            ARCLK <= 1'b0;
            ARShift <= 1'b0;
            DRShift <= 1'b1;

            // UFM bitbang control
            if (CmdBitbangMAX && RWSel && S==4'hC) begin
                DRDIn <= Din[6];
                DRCLKPulse <= Din[7];
                DRCLK <= 1'b0;
            end else begin
                DRCLKPulse <= 1'b0;
                DRCLK <= DRCLKPulse;
            end

            if (RWSel && S==4'hC) begin
                // LED control
                if (CmdLEDSet) LEDEN <= Din[0];
                
                // Set capacity mask
                if (CmdRWMaskSet) RWMask[7:0] <= {Din[7], ~Din[6:0]};
            end

            // UFM programming sequence
            if (CmdPrgmMAX || CmdEraseMAX) begin
                if (!UFMBusyReg && !RTPBusyReg) begin
                    if (UFMReqErase || CmdEraseMAX) UFMErase <= 1'b1;
                    else if (CmdPrgmMAX) UFMProgram <= 1'b1;
                end else if (UFMBusyReg) UFMReqErase <= 1'b0;
            end
        end
    end

    /* SDRAM Control */
    always @(posedge C14M) begin
        if (S==4'h0) begin 
            // SDRAM initialization
            if (FS[15:0]==16'hFFC0) begin
                // Precharge All
                nCS <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
                RA[10] <= 1'b1; // "all"
            end else if (FS[15:4]==16'hFFD && FS[0]==1'b0) begin // Repeat 8x
                // Auto-refresh
                nCS <= 1'b0;    
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
                RA[10] <= 1'b0;
            end else if (FS[15:0]==16'hFFE8) begin
                // Set Mode Register
                nCS <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b0;
                RA[10] <= 1'b0; // Reserved in mode register
            end else if (FS[15:4]==12'hFFF && FS[0]==1'b0) begin // Repeat 8x
                // Auto-refresh
                nCS <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
                RA[10] <= 1'b0;
            end else begin // Otherwise send no-op
                // NOP
                nCS <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
                RA[10] <= 1'b0;
            end
            // Enable SDRAM clock after 65,280 cycles (~4.56ms)
            CKE <= FS[15:8] == 8'hFF;

            // Mode register contents
            BA[1:0] <= 2'b00;       // Reserved
            RA[11] <= 1'b0;         // Reserved
            // RA[10] set above ^
            RA[9] <= 1'b1;          // "1" for single write mode
            RA[8] <= 1'b0;          // Reserved
            RA[7] <= 1'b0;          // "0" for not test mode
            RA[6:4] <= 3'b010;      // "2" for CAS latency 2
            RA[3] <= 1'b0;          // "0" for sequential burst (not used)
            RA[2:0] <= 3'b000;      // "0" for burst length 1 (no burst)

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;

            // Begin normal operation after 128k init cycles (~9.15ms)
            if (FS == 16'hFFFF) Ready <= 1'b1;
        end else if (S==4'h1) begin
            // Enable clock
            CKE <= 1'b1;

            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h2) begin
            // Enable clock
            CKE <= 1'b1;
            
            // Activate
            nCS <= 1'b0;
            nRAS <= 1'b0;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // SDRAM bank 0, high-order row address is 0
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;
            // Row address is as previously latched

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h3) begin
            // Enable clock
            CKE <= 1'b1;
            
            // Read
            nCS <= 1'b0;
            nRAS <= 1'b1;
            nCAS <= 1'b0;
            nRWE <= 1'b1;

            // SDRAM bank 0, RA[11,9:8] don't care
            BA[1:0] <= 2'b00;
            RA[11] <= 1'b0;
            RA[10] <= 1'b1; // (A10 set to auto-precharge)
            RA[9] <= 1'b0;
            RA[8] <= 1'b0;
            // Latch column address for read command
            RA[7:0] <= Ain[7:0];

            // Read low byte (high byte is +4MB in ramworks)
            DQML <= 1'b0;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h4) begin
            // Enable clock
            CKE <= 1'b1;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h5) begin
            // Enable clock
            CKE <= 1'b1;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h6) begin
            // Enable clock
            CKE <= 1'b1;
            
            if (FS[5:4]==0) begin
                // Auto-refresh
                nCS <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
            end else begin
                // NOP
                nCS <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h7) begin
            // Enable clock
            CKE <= 1'b1;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;
            // Latch row address for activate command
            RA[7:0] <= Ain[7:0];

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h8) begin
            // Enable clock if '245 output enabled
            CKE <= EN80;
            
            // Activate if '245 output enabled
            nCS <= nEN80;
            nRAS <= 1'b0;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // SDRAM bank, RA[11:8] determine by RamWorks bank
            BA[1:0] <= RWBank[5:4];
            RA[11:8] <= RWBank[3:0];
            // Row address is as previously latched

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'h9) begin
            // Enable clock if '245 output enabled
            CKE <= EN80;
            
            // Read/Write if '245 output enabled
            nCS <= nEN80;
            nRAS <= 1'b1;
            nCAS <= 1'b0;
            nRWE <= nWE80;

            // SDRAM bank still determined by RamWorks, RA[11,9:8] don't care
            BA[1:0] <= RWBank[5:4];
            RA[11] <= 1'b0;
            RA[10] <= 1'b1; // (A10 set to auto-precharge)
            RA[9] <= 1'b0;
            RA[8] <= RWBank[7];
            // Latch column address for R/W command
            RA[7:0] <= Ain[7:0];

            // Latch RAMWorks low nybble write select using old row address
            RWSel <= RA[0] && !RA[3] && !nWE && !nC07X;

            // Mask according to RAMWorks bank (high byte is +4MB)
            DQML <=  RWBank[6];
            DQMH <= !RWBank[6];
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'hA) begin
            // Enable clock if '245 output enabled
            CKE <= EN80;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Inhibit data bus output
            DOEEN <= 1'b0;
        end else if (S==4'hB) begin
            // Disable clock
            CKE <= 1'b0;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Enable data bus output
            DOEEN <= 1'b1;
        end else if (S==4'hC) begin
            // Disable clock
            CKE <= 1'b0;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Enable data bus output
            DOEEN <= 1'b1;

            // RAMWorks Bank Register Select
            if (RWSel) begin
                // Latch RAMWorks bank if accessed
                if (CmdSetRWBankFFLED ||
                    CmdSetRWBankFFMAX ||
                    //CmdSetRWBankFFSPI ||
                    //CmdSetRWBankFFMXO2 ||
                     (CmdLEDGet && LEDEN)) RWBank <= 8'hFF;
                else RWBank <= Din[7:0] & {RWMask[7], ~RWMask[6:0]};

                // Recognize command sequence and advance CS state
                if ((CS==3'h0 && Din[7:0]==8'hFF) ||
                    (CS==3'h1 && Din[7:0]==8'h00) ||
                    (CS==3'h2 && Din[7:0]==8'h55) ||
                    (CS==3'h3 && Din[7:0]==8'hAA) ||
                    (CS==3'h4 && Din[7:0]==8'hC1) ||
                    (CS==3'h5 && Din[7:0]==8'hAD) ||
                     CS==3'h6 || CS==3'h7) CS <= CS+3'h1;
                else CS <= 0; // Back to beginning if it's not right
                
                if (CS==3'h6) begin // Recognize and submit command in CS6
                    CmdSetRWBankFFMAX <=  Din[7:0]==8'hFF;
                    //CmdSetRWBankFFSPI <=  Din[7:0]==8'hFE;
                    //CmdSetRWBankFFMXO2 <= Din[7:0]==8'hFD;
                    CmdSetRWBankFFLED <=  Din[7:0]==8'hF0;

                    CmdRWMaskSet <= Din[7:0]==8'hE0;
                    CmdLEDSet <=    Din[7:0]==8'hE2;
                    CmdLEDGet <=    Din[7:0]==8'hE3;

                    CmdBitbangMAX <=  Din[7:0]==8'hEA;
                    //CmdBitbangSPI <=  Din[7:0]==8'hEB;
                    //CmdBitbangMXO2 <= Din[7:0]==8'hEC;
                    //CmdExecMXO2 <= Din[7:0]==8'hED;

                    if (Din[7:0]==8'hEE) CmdEraseMAX <= 1;
                    if (Din[7:0]==8'hEF) CmdPrgmMAX <= 1;
                end else begin // Reset command triggers
                    CmdSetRWBankFFMAX <= 0;
                    //CmdSetRWBankFFSPI <= 0;
                    //CmdSetRWBankFFMXO2 <= 0;
                    CmdSetRWBankFFLED <= 0;
                    CmdRWMaskSet <= 0;
                    CmdLEDSet <= 0;
                    CmdLEDGet <= 0;
                    CmdBitbangMAX <= 0;
                    //CmdBitbangSPI <= 0;
                    //CmdBitbangMXO2 <= 0;
                    //CmdExecMXO2 <= 0;
                end

                CmdTout <= 0; // Reset command timeout if RWSel accessed
            end else begin 
                CmdTout <= CmdTout+3'h1; // Increment command timeout
                // If command sequence times out, reset sequence state
                if (CmdTout==3'h7) CS <= 0;
            end
        end else if (S==4'hD) begin
            // Disable clock
            CKE <= 1'b0;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Enable data bus output
            DOEEN <= 1'b1;
        end else if (S==4'hE) begin
            // Disable clock
            CKE <= 1'b0;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;
            // Latch row address for next video read
            RA[7:0] <= Ain[7:0];

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Enable data bus output
            DOEEN <= 1'b1;
        end else if (S==4'hF) begin
            // Disable clock
            CKE <= 1'b0;
            
            // NOP
            nCS <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;

            // Don't care bank, RA[11:8]
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;
            // Latch row address for next video read
            RA[7:0] <= Ain[7:0];

            // Mask everything
            DQML <= 1'b1;
            DQMH <= 1'b1;
            
            // Enable data bus output
            DOEEN <= 1'b1;
        end 
    end
    always @(negedge C14M) begin
        // Latch video and read data outputs
        if (S==4'h6) Vout[7:0] <= RD[7:0];
        if (S==4'hC) Dout[7:0] <= RD[7:0];
    end
endmodule
