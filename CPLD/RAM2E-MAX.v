module RAM2E(C14M, PHI1, LED, 
             nWE, nWE80, nEN80, nC07X,
             Ain, Din, Dout, nDOE, Vout, nVOE,
             CKEout, nCSout, nRASout, nCASout, nRWEout,
             BA, RAout, DQML, DQMH, RD);

    /* Clocks */
    input C14M, PHI1;
    
    /* Control inputs */
    input nWE, nWE80, nEN80, nC07X;

    /* Activity LED */
    reg LEDEN = 0;
    output LED; assign LED = !(!nEN80 && LEDEN && Ready);

    /* Address Bus */
    input [7:0] Ain; // Multiplexed DRAM address input
    
    /* 6502 Data Bus */
    input [7:0] Din; // 6502 data bus inputs
    reg DOEEN; 
    always @(posedge C14M) begin
        DOEEN <= /*(S==4'h8) || (S==4'h9) || (S==4'hA) ||*/ (S==4'hB) ||
                   (S==4'hC) || (S==4'hD) || (S==4'hE) ||   (S==4'hF);
    end
    output nDOE; assign nDOE = !(!nEN80 && nWE && DOEEN);
    output [7:0] Dout; assign Dout[7:0] = RD[7:0];
    
    /* Video Data Bus */
    reg VOEEN;
    always @(posedge C14M) begin
        VOEEN <=                                   (S==4'h7) ||
            (S==4'h8) || (S==4'h9) || (S==4'hA) || (S==4'hB) ||
            (S==4'hC) || (S==4'hD) || (S==4'hE) || (S==4'hF);
    end
    output nVOE; assign nVOE = !(!PHI1 && VOEEN);
    output reg [7:0] Vout; // Video data bus
    always @(posedge C14M) if (S==4'h6) Vout[7:0] <= RD[7:0];

    /* SDRAM */
    reg CKE = 1;
	//reg nCS = 1;
    reg nRAS = 1, nCAS = 1, nRWE = 1;
    output reg [1:0] BA;
    reg [11:0] RA;
    output reg DQML = 1, DQMH = 1;
    inout [7:0] RD;
    assign RD[7:0] = Ready ? (!nWE80 ? Din[7:0] : 8'bZ) : 8'h00;

    /* SDRAM falling edge outputs */
	output reg CKEout;
    output nCSout; assign nCSout = 0;
    output reg nRASout = 1, nCASout = 1, nRWEout = 1;
    output reg [11:0] RAout;
    always @(negedge C14M) begin
        CKEout <= CKE;
        nRASout <= nRAS;
        nCASout <= nCAS;
        nRWEout <= nRWE;
        RAout <= RA;
    end
    
    /* RAMWorks Bank Register and Capacity Mask */
    reg [7:0] RWBank = 0; // RAMWorks bank register
    reg [7:0] RWMask = 0; // RAMWorks bank reg. capacity mask
    reg RWSel = 0; // RAMWorks bank register select
    always @(posedge C14M) begin
        if (S==4'h9) RWSel <= RA[0] && !RA[3] && !nWE && !nC07X;
    end
    reg CmdRWMaskSet = 0; // RAMWorks Mask register set flag
    // Causes RWBank to be zeroed next RWSel access
    reg CmdSetRWBankFFChip = 0;
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
    reg UFMRTPBusy = 0;
    always @(posedge C14M) UFMRTPBusy <= UFMBusy || RTPBusy;
    reg UFMInitDone = 0; // 1 if UFM initialization finished
    reg UFMReqErase = 0; // 1 if UFM requires erase
    reg DRCLKPulse = 0; // Set by user command. Causes DRCLK pulse next C14M

    /* User Command Triggers */
    reg CmdBitbangMAX = 0; // Set by user command. Loads UFM outputs next RWSel
    //reg CmdBitbangSPI = 0;
    //reg CmdBitbangMXO2 = 0;
    //reg CmdExecMXO2 = 0;
    reg CmdPrgmMAX = 0; // Set by user command. Programs UFM
    reg CmdEraseMAX = 0; // Set by user command. Erases UFM

    /* State Counters */
    reg PHI1reg = 0; // Saved PHI1 at last rising clock edge
    reg Ready = 0; // 1 if done with init sequence (S0) and enter S1-S15
    reg [15:0] FS = 0; // Fast state counter
    wire RefReq = FS[5:4]==0; // Refresh request based on fast state counter
    reg [3:0] S = 0; // IIe State counter

    /* State Counters */
    always @(posedge C14M) begin
        // Increment fast state counter
        FS <= FS+16'h0001;
        // Synchronize Apple state counter to S1 when just entering PHI1
        PHI1reg <= PHI1; // Save old PHI1
        S <= (PHI1 && !PHI1reg && Ready) ? 4'h1 : 
             (S==4'h0) ? 4'h0 :
             (S==4'hF) ? 4'hF : S+4'h1;
        // Begin normal operation after 64k init cycles (~4.59ms)
        if (FS[15:0]==16'hFFFF) Ready <= 1'b1;
    end

    /* Command sequence control */
    always @(posedge C14M) begin
        if (S==4'hC) begin
            if (RWSel) begin
                CmdTout <= 0; // Reset command timeout if RWSel accessed
                // Recognize command sequence and advance CS state
                if ((CS==3'h0 && Din[7:0]==8'hFF) ||
                    (CS==3'h1 && Din[7:0]==8'h00) ||
                    (CS==3'h2 && Din[7:0]==8'h55) ||
                    (CS==3'h3 && Din[7:0]==8'hAA) ||
                    (CS==3'h4 && Din[7:0]==8'hC1) ||
                    (CS==3'h5 && Din[7:0]==8'hAD) ||
                     CS==3'h6 || CS==3'h7) CS <= CS+3'h1;
                else CS <= 0; // Back to beginning if it's not right
            end else begin
                CmdTout <= CmdTout+3'h1; // Increment command timeout
                // If command sequence times out, reset sequence state
                if (CmdTout==3'h7) CS <= 0;
            end
        end
    end

    /* UFM Control */
    reg UFMProgStart;
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
            // Reset UFMProgStart
            UFMProgStart <= 1'b0; 
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

            // Volatile settings command execution
            if (RWSel && S==4'hC) begin
                // LED control
                if (CmdLEDSet) LEDEN <= Din[0];
                // Set capacity mask
                if (CmdRWMaskSet) RWMask[7:0] <= {Din[7], ~Din[6:0]};
            end

            // UFM programming sequence
            if (S==4'h1) begin
                if (!UFMProgStart && !UFMRTPBusy) begin
                    if (CmdPrgmMAX) begin
                        UFMErase <= UFMReqErase;
                        UFMProgStart <= 1;
                    end else if (CmdEraseMAX) UFMErase <= 1;
                end else if (UFMProgStart && !UFMRTPBusy) begin
                    UFMErase <= 0;
                    if (!UFMErase) UFMProgram <= 1;
                end
            end
        end
    end
    
    /* RAMWorks register control - bank, LED, etc. */
    always @(posedge C14M) begin
        if (S==4'hC && RWSel) begin
            // Latch RAMWorks bank if accessed
            if ((CmdSetRWBankFFLED) ||
                (CmdSetRWBankFFChip) ||
                (CmdLEDGet && LEDEN)) RWBank <= 8'hFF;
            else RWBank <= Din[7:0] & {RWMask[7], ~RWMask[6:0]};
            
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Board has LED detect command
                CmdSetRWBankFFLED <= Din[7:0]==8'hF0;

                // Volatile commands
                CmdRWMaskSet <=      Din[7:0]==8'hE0;
                CmdLEDSet <=         Din[7:0]==8'hE2;
                CmdLEDGet <=         Din[7:0]==8'hE3;
            end else begin // Reset command triggers
                CmdSetRWBankFFLED <= 0;
                CmdRWMaskSet <= 0;
                CmdLEDSet <= 0;
                CmdLEDGet <= 0;
            end
        end
    end

    /* RAMWorks register control - Altera MAX */
    always @(posedge C14M) begin
        if (S==4'hC && RWSel) begin
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Chip detection commands
                CmdSetRWBankFFChip <= Din[7:0]==8'hFF; // MAX
                //CmdSetRWBankFFChip <= Din[7:0]==8'hFE; // SPI
                //CmdSetRWBankFFChip <= Din[7:0]==8'hFD; // MachXO2

                // Altera MAX II/V commands
                CmdBitbangMAX <=  Din[7:0]==8'hEA;
                if (!CmdEraseMAX && !CmdPrgmMAX) begin
                    if (Din[7:0]==8'hEE) CmdEraseMAX <= 1;
                    if (Din[7:0]==8'hEF) CmdPrgmMAX <= 1;
                end

                // SPI commands
                //CmdBitbangSPI <= Din[7:0]==8'hEB;

                // MachXO2 commands
                //CmdBitbangMXO2 <= Din[7:0]==8'hEC;
                //CmdExecMXO2 <= Din[7:0]==8'hED;
            end else begin // Reset command triggers
                CmdSetRWBankFFChip <= 0;
                CmdBitbangMAX <= 0;
                //CmdBitbangSPI <= 0;
                //CmdBitbangMXO2 <= 0;
                //CmdExecMXO2 <= 0;
            end
        end
    end

    /* SDRAM Control */
    always @(posedge C14M) case (S)
        4'h0: begin
            CKE <= 1'b1;
            if (!FS[15] || FS[0]) begin
                // NOP
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else case (FS[4:1])
                4'h0: begin
                    // PC all
                    nRAS <= 1'b0;
                    nCAS <= 1'b1;
                    nRWE <= 1'b0;
                end 4'h1: begin
                    // LDM
                    nRAS <= 1'b0;
                    nCAS <= 1'b0;
                    nRWE <= 1'b0;
                end 4'h2: begin
                    // NOP
                    nRAS <= 1'b1;
                    nCAS <= 1'b1;
                    nRWE <= 1'b1;
                end 4'h3, 4'h4, 4'h5, 4'h6, 
                    4'h7, 4'h8, 4'h9, 4'hA: begin
                    // AREF
                    nRAS <= 1'b0;
                    nCAS <= 1'b0;
                    nRWE <= 1'b1;
                end 4'hB: begin
                    // ACT
                    nRAS <= 1'b0;
                    nCAS <= 1'b1;
                    nRWE <= 1'b1;
                end 4'hC, 4'hD: begin
                    // WR
                    nRAS <= 1'b1;
                    nCAS <= 1'b0;
                    nRWE <= 1'b0;
                end 4'hE: begin
                    // NOP
                    nRAS <= 1'b1;
                    nCAS <= 1'b1;
                    nRWE <= 1'b1;
                end 4'hF: begin
                    // PC all
                    nRAS <= 1'b0;
                    nCAS <= 1'b1;
                    nRWE <= 1'b0;
                end
            endcase
            case (FS[4:3])
                2'b00, 2'b01: begin
                    // Mode register contents
                    BA[1:0] <= 2'b00;   // Reserved
                    RA[11] <= 1'b0;     // Reserved
                    RA[10] <= !FS[1];   // reserved / "all"
                    RA[9] <= 1'b1;      // "1" for single write mode
                    RA[8] <= 1'b0;      // Reserved
                    RA[7] <= 1'b0;      // "0" for not test mode
                    RA[6:4] <= 3'b010;  // "2" for CAS latency 2
                    RA[3] <= 1'b0;      // "0" for sequential burst (not used)
                    RA[2:0] <= 3'b000;  // "0" for burst length 1 (no burst)
                end 2'b10: begin
                    BA[1:0] <= 2'b00;
                    RA[11:8] <= 4'h0;
                    RA[7:0] <= FS[14:7];
                end 2'b11: begin
                    BA[1:0] <= 2'b00;
                    RA[11:3] <= 9'h000;
                    RA[2:1] <= FS[6:5];
                    RA[0] <= FS[1];
                end
            endcase
            DQML <= !FS[15];
            DQMH <= !FS[15];
        end 4'h1: begin
            // NOP CKE
            CKE <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            BA[1:0] <= 2'b00;
            RA[11:8] <= 4'b0000;
            // Hold RA[7:0]
            DQML <= 1'b0;
            DQMH <= 1'b1;
        end 4'h2: begin
            // ACT CKE
            CKE <= 1'b1;
            nRAS <= 1'b0;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA
            // Hold DQMs
        end 4'h3: begin
            // RD CKE
            CKE <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b0;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA[11:8]
            RA[7:0] <= Ain[7:0];
            // Hold DQMs
        end 4'h4: begin
            // PC all CKE
            CKE <= 1'b1;
            nRAS <= 1'b0;
            nCAS <= 1'b1;
            nRWE <= 1'b0;
            // Hold BA
            // Hold RA[11]
            RA[10] <= 1'b1; // "all"
            // Hold RA[9:0]
            // Hold DQMs
        end 4'h5: begin
            if (RefReq) begin
                // AREF CKE
                CKE <= 1'b1;
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
            end else begin
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            // Hold BA
            // Hold RA
            // Hold DQMs
        end 4'h6: begin
            // NOP CKD
            CKE <= 1'b0;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA
            // Hold DQMs
        end 4'h7: begin
            // Can't check EN80 at this time
            if (nWE) begin // Read / idle
                // NOP CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else begin // Write / idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            BA[1:0] <= RWBank[6:5];
            RA[11:8] <= RWBank[4:1];
            RA[7:0] <= Ain[7:0];
            // Hold DQMs
        end 4'h8: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else if (nWE) begin // Read
                // ACT CKE
                CKE <= 1'b1;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else begin // Write
                // NOP CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            // Hold BA
            // Hold RA
            // Hold DQMs
        end 4'h9: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else if (nWE) begin // Read
                // RD CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
            end else begin // Write
                // ACT CKE
                CKE <= 1'b1;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            // Hold BA
            RA[11:9] <= 3'b000; // no auto-precharge
            RA[8] <= RWBank[7];
            RA[7:0] <= Ain[7:0];
            DQMH <= !RWBank[0];
            DQMH <=  RWBank[0];
        end 4'hA: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
                // Hold RA[10]
            end else if (nWE) begin // Read
                // PC all CKD
                CKE <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
                RA[10] <= 1'b1;
            end else begin // Write
                // WR CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b0;
                nRWE <= 1'b0;
                RA[10] <= 1'b0;
            end
            // Hold BA
            // Hold RA[11,9:0]
            // Hold DQMs
        end 4'hB: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else if (nWE) begin // Read
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end else begin // Write
                // NOP CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            // Hold BA
            // Hold RA[11:0]
            // Hold DQMs
        end 4'hC: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
                // Hold RA[10]
            end else if (nWE) begin // Read
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
                // Hold RA[10]
            end else begin // Write
                // PC all CKD
                CKE <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
                RA[10] <= 1'b1; // "all"
            end
            // Hold BA
            // Hold RA[11,9:0]
            // Hold RA[7:0]
            // Hold DQMs
        end 4'hD: begin
            // NOP CKD
            CKE <= 1'b0;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA[11:0]
            // Hold DQMs
        end 4'hE, 4'hF: begin
            // NOP CKD
            CKE <= 1'b0;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA[11:8]
            RA[7:0] <= Ain[7:0]; // Latch row address for next video read
            // Hold DQMs
        end
    endcase
endmodule
