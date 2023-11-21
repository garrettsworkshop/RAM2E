module RAM2E(C14M, PHI1, LED, 
             nWE, nWE80, nEN80, nC07X,
             Ain, Din, Dout, nDOE, Vout, nVOE,
             CKE, nCS, nRAS, nCAS, nRWE,
             BA, RA, RD, DQML, DQMH);

    /* Clocks */
    input C14M, PHI1;
    
    /* SDRAM clock output */
    output RCLK;
    ODDRXE rclk_oddr(.D0(1'b0), .D1(1'b1), 
        .SCLK(C14M), .RST(1'b0), .Q(RCLK));
    
    /* Control inputs */
    input nWE, nWE80, nEN80, nC07X;

    /* Activity LED */
    reg LEDEN = 0;
    output LED;
    assign LED = !(!nEN80 && LEDEN && Ready);

    /* Address Bus */
    input [7:0] Ain; // Multiplexed DRAM address input
    
    /* 6502 Data Bus */
    input [7:0] Din; // 6502 data bus inputs
    reg DOEEN = 0; // 6502 data bus output enable from state machine
    output nDOE;
    assign nDOE = !(!nEN80 && nWE && DOEEN); // 6502 data bus output enable
    output reg [7:0] Dout; // 6502 data Bus output
    
    /* Video Data Bus */
    output nVOE;
    assign nVOE = !(!PHI1); /// Video data bus output enable
    output reg [7:0] Vout; // Video data bus

    /* SDRAM */
    output reg CKE = 0;
    output nCS;
    assign nCS = 0;
    output reg nRAS = 1, nCAS = 1, nRWE = 1;
    output reg [1:0] BA;
    output reg [11:0] RA;
    output reg DQML = 1, DQMH = 1;
    wire RDOE = !nEN80 && !nWE80;
    inout [7:0] RD;
    assign RD[7:0] = RDOE ? Din[7:0] : 8'bZ;
    
    /* RAMWorks Bank Register and Capacity Mask */
    reg [7:0] RWBank = 0; // RAMWorks bank register
    reg [7:0] RWMask = 0; // RAMWorks bank reg. capacity mask
    reg RWSel = 0; // RAMWorks bank register select
    reg CmdRWMaskSet = 0; // RAMWorks Mask register set flag
    // Causes RWBank to be zeroed next RWSel access
    //reg CmdSetRWBankFFMAX = 0;
    //reg CmdSetRWBankFFSPI = 0;
    reg CmdSetRWBankFFMXO2 = 0;
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

    /* UFM State and User Command Triggers */
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
            CKE <= !nEN80;
            
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
            CKE <= !nEN80;
            
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
            CKE <= !nEN80;
            
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
                    //CmdSetRWBankFFMAX ||
                    //CmdSetRWBankFFSPI ||
                    CmdSetRWBankFFMXO2 ||
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
                    //CmdSetRWBankFFMAX <=  Din[7:0]==8'hFF;
                    //CmdSetRWBankFFSPI <=  Din[7:0]==8'hFE;
                    CmdSetRWBankFFMXO2 <= Din[7:0]==8'hFD;
                    CmdSetRWBankFFLED <=  Din[7:0]==8'hF0;

                    CmdRWMaskSet <= Din[7:0]==8'hE0;
                    CmdLEDSet <=    Din[7:0]==8'hE2;
                    CmdLEDGet <=    Din[7:0]==8'hE3;

                    //CmdBitbangMAX <=  Din[7:0]==8'hEA;
                    //CmdBitbangSPI <=  Din[7:0]==8'hEB;
                    CmdBitbangMXO2 <= Din[7:0]==8'hEC;
                    CmdExecMXO2 <= Din[7:0]==8'hED;

                    //if (Din[7:0]==8'hEE) CmdEraseMAX <= 1;
                    //if (Din[7:0]==8'hEF) CmdPrgmMAX <= 1;
                end else begin // Reset command triggers
                    //CmdSetRWBankFFMAX <= 0;
                    //CmdSetRWBankFFSPI <= 0;
                    CmdSetRWBankFFMXO2 <= 0;
                    CmdSetRWBankFFLED <= 0;
                    CmdRWMaskSet <= 0;
                    CmdLEDSet <= 0;
                    CmdLEDGet <= 0;
                    //CmdBitbangMAX <= 0;
                    //CmdBitbangSPI <= 0;
                    CmdBitbangMXO2 <= 0;
                    CmdExecMXO2 <= 0;
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
