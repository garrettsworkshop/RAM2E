module RAM2E_UFM(C14M, S, FS, CS,
                 RWSel, D,
                 RWMask, LEDEN,
				 CmdRWMaskSet, CmdLEDSet,
                 ChipCmdNum);
	input C14M;
	input [3:0] S;
    input [15:0] FS;
    input [2:0] CS;
	input RWSel;
	input [7:0] D;
    output reg [7:0] RWMask;
    output reg LEDEN;
    input CmdRWMaskSet;
    input CmdLEDSet;

    /* Chip ID */
    output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFF; // MAX
    //output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFE; // SPI
    //output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFD; // MachXO2
    
    /* RAMWorks register control - Altera MAX */
    reg CmdBitbangMAX = 0; // Set by user command. Loads UFM outputs next RWSel
    reg CmdPrgmMAX = 0; // Set by user command. Programs UFM
    reg CmdEraseMAX = 0; // Set by user command. Erases UFM
    always @(posedge C14M) begin
        if (S==4'hC && RWSel) begin
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Altera MAX II/V commands
                CmdBitbangMAX <=  D[7:0]==8'hEA;
                if (!CmdEraseMAX && !CmdPrgmMAX) begin
                    if (D[7:0]==8'hEE) CmdEraseMAX <= 1;
                    if (D[7:0]==8'hEF) CmdPrgmMAX <= 1;
                end

                // SPI commands
                //CmdBitbangSPI <= D[7:0]==8'hEB;

                // MachXO2 commands
                //CmdBitbangMXO2 <= D[7:0]==8'hEC;
                //CmdExecMXO2 <= D[7:0]==8'hED;
            end else begin // Reset command triggers
                CmdBitbangMAX <= 0;
            end
        end
    end


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

    /* UFM control */
    reg UFMProgStart;
    always @(posedge C14M) begin
        if (S==4'h0) begin
            if ((FS[15:13]==3'b101) || 
                (FS[15:13]==3'b111 && UFMReqErase)) begin
                // In states AXXX-BXXX and also EXXX-FXXX if erase/wrap req'd
                // shift in 0's to address register
                ARCLK <= FS[0]; // Clock address register
                DRCLK <= 1'b0; // Don't clock data register
                ARShift <= 1'b1; // Shift address registers
                DRDIn <= 1'b0; // Don't care DRDIn
                DRShift <= 1'b0; // Don't care DRDShift
            end else if (!UFMInitDone && 
                FS[15:13]==3'b110 && FS[4:1]==4'h4) begin
                // In states CXXX-DXXX (substep 4)
                // Xfer to data reg (repeat 256x 1x)
                ARCLK <= 1'b0; // Don't clock address register
                DRCLK <= FS[0]; // Clock data register
                ARShift <= 1'b0; // Don't care ARShift
                DRDIn <= 1'b0; // Don't care DRDIn
                DRShift <= 1'b0; // Don't care DRShift
            end else if (!UFMInitDone && 
                FS[15:13]==3'b110 && (FS[4:1]==4'h7 || FS[4]==1'b1)) begin
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
                DRDIn <= D[6];
                DRCLKPulse <= D[7];
                DRCLK <= 1'b0;
            end else begin
                DRCLKPulse <= 1'b0;
                DRCLK <= DRCLKPulse;
            end

            // Volatile settings command execution
            if (RWSel && S==4'hC) begin
                // LED control
                if (CmdLEDSet) LEDEN <= D[0];
                // Set capacity mask
                if (CmdRWMaskSet) RWMask[7:0] <= {D[7], ~D[6:0]};
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
endmodule
