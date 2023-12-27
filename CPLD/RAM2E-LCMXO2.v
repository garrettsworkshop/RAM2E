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
    reg wb_rst;
    reg wb_cyc_stb;
    reg wb_req;
    reg wb_we;
    reg [7:0] wb_adr;
    reg [7:0] wb_dati;
    wire wb_ack;
    wire [7:0] wb_dato;
    wire ufm_irq;
    REFB ufmefb(
        .wb_clk_i(C14M),
        .wb_rst_i(wb_rst),
        .wb_cyc_i(wb_cyc_stb),
        .wb_stb_i(wb_cyc_stb),
        .wb_we_i(wb_we),
        .wb_adr_i(wb_adr),
        .wb_dat_i(wb_dati),
        .wb_dat_o(wb_dato),
        .wb_ack_o(wb_ack),
        .wbc_ufm_irq(ufm_irq));

    /* User Command Triggers */
    //reg CmdBitbangMAX = 0; // Set by user command. Loads UFM outputs next RWSel
    //reg CmdBitbangSPI = 0;
    reg CmdBitbangMXO2 = 0;
    reg CmdExecMXO2 = 0;
    //reg CmdPrgmMAX = 0; // Set by user command. Programs UFM
    //reg CmdEraseMAX = 0; // Set by user command. Erases UFM

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
    always @(posedge C14M) begin
        if (S==4'h0) begin
            if (FS[15:14]==2'b00) wb_rst <= 1'b1;
            else if (FS[15:14]==2'b01) wb_rst <= 1'b0;
            else if (FS[15:14]==2'b10) begin
                wb_rst <= 1'b0;
                if (wb_ack || (FS[7:0]==0)) wb_cyc_stb <= 0;
                else if ((FS[7:0]==1) && wb_req) wb_cyc_stb <= 1;
                case (FS[13:8])
                    0: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 1: begin // Enable configuration interface - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h74;
                        wb_req <= 1;
                    end 2: begin // Enable configuration interface - operand 1/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h08;
                        wb_req <= 1;
                    end 3: begin // Enable configuration interface - operand 2/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 4: begin // Enable configuration interface - operand 3/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 5: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;

                    end 6: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 7: begin // Poll status register - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h3C;
                        wb_req <= 1;
                    end 8: begin // Poll status register - operand 1/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 9: begin // Poll status register - operand 2/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 10: begin // Poll status register - operand 3/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 11, 12, 13, 14: begin // Read status register 1-4
                        wb_we <= 1'b0;
                        wb_adr[7:0] <= 8'h73;
                        wb_dati[7:0] <= 8'h3C;
                        wb_req <= 1;
                    end 15: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;

                    end 16: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 17: begin // Set UFM address - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'hB4;
                        wb_req <= 1;
                    end 18: begin // Set UFM address - operand 1/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 19: begin // Set UFM address - operand 2/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 20: begin // Set UFM address - operand 3/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 21: begin // Set UFM address - data 1/4
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h40;
                        wb_req <= 1;
                    end 22: begin // Set UFM address - data 2/4
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 23: begin // Set UFM address - data 3/4
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 24: begin // Set UFM address - data 4/4
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 190;
                        wb_req <= 1;
                    end 25: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;

                    end 26: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 27: begin // Read UFM page - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'hCA;
                        wb_req <= 1;
                    end 28: begin // Read UFM page - operand 1/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h10;
                        wb_req <= 1;
                    end 29: begin // Read UFM page - operand 2/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 30: begin // Read UFM page - operand 3/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h01;
                        wb_req <= 1;
                    end 31: begin // Read UFM page - data 0
                        wb_we <= 1'b0;
                        wb_adr[7:0] <= 8'h73;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                        if (wb_ack) RWMask[7:0] <= wb_dato[7:0];
                    end 32: begin // Read UFM page - data 1
                        wb_we <= 1'b0;
                        wb_adr[7:0] <= 8'h73;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                        if (wb_ack) LEDEN <= wb_dato[0];
                    end         33, 34,
                        35, 36, 37, 38,
                        39, 40, 41, 42,
                        43, 44, 45, 46: begin // Read UFM page - data 2-15
                        wb_we <= 1'b0;
                        wb_adr[7:0] <= 8'h73;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 47: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;

                    end 48: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 49: begin // Disable configuration interface - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h26;
                        wb_req <= 1;
                    end 50: begin // Disable configuration interface - operand 1/2
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 51: begin // Disable configuration interface - operand 2/2
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 52: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;

                    end 53: begin // Open frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h80;
                        wb_req <= 1;
                    end 54: begin // Bypass - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'hFF;
                        wb_req <= 1;
                    end 55: begin // Close frame
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end default: begin
                        wb_we <= 1'b0;
                        wb_adr[7:0] <= 8'h70;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 0;
                    end
                endcase
            end else begin
                wb_rst <= 1'b0;
                wb_cyc_stb <= 1'b0;
                wb_req <= 1'b0;
                wb_we <= 1'b0;
                wb_adr[7:0] <= 8'h00;
                wb_dati[7:0] <= 8'h00;
            end
        end else begin
            // UFM bitbang control
            wb_rst <= 1'b0;
            wb_req <= 1'b0;

            if (RWSel && S==4'hC) begin
                // LED control
                if (CmdLEDSet) LEDEN <= Din[0];
                
                // Set capacity mask
                if (CmdRWMaskSet) RWMask[7:0] <= {Din[7], ~Din[6:0]};

                // Set EFB address
                if (CmdBitbangMXO2) begin
                    wb_adr[7:0] <= Din[7:0];
                    wb_dati[7:0] <= wb_adr[7:0];
                end

                // Excecute EFB R/W cycle
                if (CmdExecMXO2) begin
                    wb_we <= Din[0];
                    wb_cyc_stb <= 1;
                end else if (wb_ack) wb_cyc_stb <= 0;
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

    /* RAMWorks register control - Lattice MachXO2 */
    always @(posedge C14M) begin
        if (S==4'hC && RWSel) begin
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Chip detection commands
                //CmdSetRWBankFFChip <= Din[7:0]==8'hFF; // MAX
                //CmdSetRWBankFFChip <= Din[7:0]==8'hFE; // SPI
                CmdSetRWBankFFChip <= Din[7:0]==8'hFD; // MachXO2

                // Altera MAX II/V commands
                //CmdBitbangMAX <=  Din[7:0]==8'hEA;
                //if (!CmdEraseMAX && !CmdPrgmMAX) begin
                //    if (Din[7:0]==8'hEE) CmdEraseMAX <= 1;
                //    if (Din[7:0]==8'hEF) CmdPrgmMAX <= 1;
                //end

                // SPI commands
                //CmdBitbangSPI <= Din[7:0]==8'hEB;

                // MachXO2 commands
                CmdBitbangMXO2 <= Din[7:0]==8'hEC;
                CmdExecMXO2 <= Din[7:0]==8'hED;
            end else begin // Reset command triggers
                CmdSetRWBankFFChip <= 0;
                //CmdBitbangMAX <= 0;
                //CmdBitbangSPI <= 0;
                CmdBitbangMXO2 <= 0;
                CmdExecMXO2 <= 0;
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
