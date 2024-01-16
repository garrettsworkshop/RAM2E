module RAM2E_UFM(C14M, S, FS, CS, Ready,
                 RWSel, D,
                 RWMask, LEDEN,
                 CmdRWMaskSet, CmdLEDSet,
                 ChipCmdNum);
    input C14M;
    input [3:0] S;
    input [15:0] FS;
    input [2:0] CS;
	input Ready;
    input RWSel;
    input [7:0] D;
    output reg [7:0] RWMask;
    output reg LEDEN;
    input CmdRWMaskSet;
    input CmdLEDSet;

    /* Chip ID */
    //output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFF; // MAX
    //output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFE; // SPI
    output [7:0] ChipCmdNum; assign ChipCmdNum[7:0] = 8'hFD; // MachXO2

    /* RAMWorks register control - Lattice MachXO2 */
    reg CmdBitbangMXO2 = 0;
    reg CmdExecMXO2 = 0;
    always @(posedge C14M) begin

        if (S==4'hC && RWSel) begin
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Altera MAX II/V commands
                //CmdBitbangMAX <=  D[7:0]==8'hEA;
                //if (!CmdEraseMAX && !CmdPrgmMAX) begin
                //    if (D[7:0]==8'hEE) CmdEraseMAX <= 1;
                //    if (D[7:0]==8'hEF) CmdPrgmMAX <= 1;
                //end

                // SPI commands
                //CmdBitbangSPI <= D[7:0]==8'hEB;

                // MachXO2 commands
                CmdBitbangMXO2 <= D[7:0]==8'hEC;
                CmdExecMXO2 <= D[7:0]==8'hED;
            end else begin // Reset command triggers
                CmdBitbangMXO2 <= 0;
                CmdExecMXO2 <= 0;
            end
        end
    end

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
                    end 1: begin // Enable config interface - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h74;
                        wb_req <= 1;
                    end 2: begin // Enable config interface - operand 1/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h08;
                        wb_req <= 1;
                    end 3: begin // Enable config interface - operand 2/3
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 4: begin // Enable config interface - operand 3/3
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
                    end 49: begin // Disable config interface - command
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h26;
                        wb_req <= 1;
                    end 50: begin // Disable config interface - operand 1/2
                        wb_we <= 1'b1;
                        wb_adr[7:0] <= 8'h71;
                        wb_dati[7:0] <= 8'h00;
                        wb_req <= 1;
                    end 51: begin // Disable config interface - operand 2/2
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

            // Volatile settings command execution
            if (RWSel && S==4'hC) begin
                // LED control
                if (CmdLEDSet) LEDEN <= D[0];
                // Set capacity mask
                if (CmdRWMaskSet) RWMask[7:0] <= {D[7], ~D[6:0]};
            end

            // EFB commands
            if (RWSel && S==4'hC) begin
                // Set EFB address
                if (CmdBitbangMXO2) begin
                    wb_adr[7:0] <= D[7:0];
                    wb_dati[7:0] <= wb_adr[7:0];
                end

                // Excecute EFB R/W cycle
                if (CmdExecMXO2) begin
                    wb_we <= D[0];
                    wb_cyc_stb <= 1;
                end else if (wb_ack) wb_cyc_stb <= 0;
            end
        end
    end
endmodule
