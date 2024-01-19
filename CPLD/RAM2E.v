module RAM2E(C14M, PHI1, LED, 
             nWE, nWE80, nEN80, nC07X,
             Ain, Din, Dout, nDOE, Vout, nVOE,
             CKEout, nCSout, nRASout, nCASout, nRWEout,
             BA, RAout, DQML, DQMH, RD);

    /* Clocks */
    input C14M, PHI1;
    
    /* Control inputs */
    input nWE, nWE80, nEN80, nC07X;

    /* "Fast" (init) state counter */
    reg [15:0] FS = 0; always @(posedge C14M) FS <= FS+16'h0001;
    reg Ready = 0;
    always @(posedge C14M) if (FS[15:0]==16'hFFFF) Ready <= 1'b1;

    /* IIe state counter */
    reg [3:0] S = 0;
    reg PHI1r = 0; always @(posedge C14M) PHI1r <= PHI1;
    always @(posedge C14M) begin
        S <= (PHI1 && !PHI1r && Ready) ? 4'h1 :
             (S==4'h0) ? 4'h0 :
             (S==4'hF) ? 4'hF : S+4'h1;
    end

    /* Refresh counter */
    reg [2:0] RC;
    reg RefReq;
    always @(negedge PHI1) begin
        if (RC[2] && RC[1]) RC <= 0; // RC==6 || RC==7
        else RC <= RC+3'h1;
        RefReq <= RC==0;
    end

    /* Activity LED */
    wire LEDEN;
    output LED; assign LED = !(!nEN80 && LEDEN && Ready);

    /* DRAM multiplexed address bus input */
    input [7:0] Ain;
    
    /* 6502 data bus input/output */
    input [7:0] Din;
    reg DOEEN; 
    always @(posedge C14M) begin
        DOEEN <= S==4'hB || S==4'hC || S==4'hD || S==4'hE || S==4'hF ;
    end
    output nDOE; assign nDOE = !(!nEN80 && nWE && DOEEN);
    output [7:0] Dout; assign Dout[7:0] = RD[7:0];
    
    /* Video Data Bus */
    reg VOEEN;
    always @(posedge C14M) begin
        VOEEN <=                             S==4'h7 ||
            S==4'h8 || S==4'h9 || S==4'hA || S==4'hB ||
            S==4'hC || S==4'hD || S==4'hE || S==4'hF;
    end
    output nVOE; assign nVOE = !(!PHI1 && VOEEN);
    output reg [7:0] Vout; // Video data bus
    always @(negedge C14M) if (S==4'h6) Vout[7:0] <= RD[7:0];

    /* SDRAM bus */
    reg CKE = 1, nRAS = 1, nCAS = 1, nRWE = 1;
    output reg [1:0] BA;
    reg [11:0] RA;
    output reg DQML = 1, DQMH = 1;
    inout [7:0] RD;
    wire [7:0] RDout = Ready ? Din[7:0] : 8'h00;
    reg RDOE;
    always @(posedge C14M) begin 
        RDOE <= (!Ready) || (!nEN80 && !nWE && (S==4'hA || S==4'hB));
    end
    assign RD[7:0] = RDOE ? RDout[7:0] : 8'bZ;

    /* SDRAM falling edge command outputs */
    output nCSout; assign nCSout = 0;
    output reg CKEout = 1, nRASout = 1, nCASout = 1, nRWEout = 1;
    always @(negedge C14M) begin
        CKEout <= CKE;
        nRASout <= nRAS;
        nCASout <= nCAS;
        nRWEout <= nRWE;
    end

    /* SDRAM address outputs */
    output [11:0] RAout;
    reg [11:0] RAr; always @(negedge C14M) RAr <= RA;
    reg RAT; always @(negedge C14M) RAT <= S==4'hA;
    assign RAout[11:8] = RAr[11:8];
    assign RAout[7:0] = RAT ? Ain[7:0] : RAr[7:0];
    
    /* RAMWorks Bank Register and Capacity Mask */
    reg [7:0] RWBank = 0; // RAMWorks bank register
    wire [7:0] RWMask;
    reg RWSel = 0; // RAMWorks bank register select
    always @(posedge C14M) begin
        if (S==4'h9) RWSel <= RA[0] && !RA[3] && !nWE && !nC07X;
    end
    reg CmdRWMaskSet = 0; // RAMWorks Mask register set flag
    reg CmdSetRWBankFFLED = 0;
    reg CmdLEDSet = 0;
    reg CmdLEDGet = 0;
    
    /* Command Sequence Detector */
    reg [2:0] CS = 0; // Command sequence state
    reg [2:0] CmdTout = 0; // Command sequence timeout

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

    /* Chip-specific UFM interface */
    wire [7:0] ChipCmdNum;
    RAM2E_UFM ram2e_ufm (
        .C14M(C14M), .S(S), .FS(FS), .CS(CS), .Ready(Ready),
        .RWSel(RWSel), .D(Din),
        .RWMask(RWMask), .LEDEN(LEDEN),
        .CmdRWMaskSet(CmdRWMaskSet), .CmdLEDSet(CmdLEDSet),
        .ChipCmdNum(ChipCmdNum));

    /* RAMWorks register control - bank, LED, etc. */
    reg CmdSetRWBankFFChip;
    always @(posedge C14M) begin
        if (S==4'hC && RWSel) begin
            // Latch RAMWorks bank if accessed
            if ((CmdSetRWBankFFLED) || (CmdSetRWBankFFChip) ||
                (CmdLEDGet && LEDEN)) RWBank <= 8'hFF;
            else RWBank <= Din[7:0] & {RWMask[7], ~RWMask[6:0]};
            
            if (CS==3'h6) begin // Recognize and submit command in CS6
                // Chip detection command
                CmdSetRWBankFFChip <= Din[7:0]==ChipCmdNum[7:0];
                // LED exists detect command
                CmdSetRWBankFFLED <= Din[7:0]==8'hF0;
                // Volatile settings commands
                CmdRWMaskSet <=      Din[7:0]==8'hE0;
                CmdLEDSet <=         Din[7:0]==8'hE2;
                CmdLEDGet <=         Din[7:0]==8'hE3;
            end else begin // Reset command triggers
                CmdSetRWBankFFChip <= 0;
                CmdSetRWBankFFLED <= 0;
                CmdRWMaskSet <= 0;
                CmdLEDSet <= 0;
                CmdLEDGet <= 0;
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
            if (RefReq) begin // Refresh request
                // PC all CKE
                CKE <= 1'b1;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
            end else begin // No refresh request
                // PC all CKD
                CKE <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
            end
            // Hold BA
            // Hold RA[11,9:0]
            RA[10] <= 1'b1; // "all"
            // Hold DQMs
        end 4'h5: begin
            if (RefReq) begin // Refresh request
                // AREF CKE
                CKE <= 1'b1;
                nRAS <= 1'b0;
                nCAS <= 1'b0;
                nRWE <= 1'b1;
            end else begin // No refresh request
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
            // NOP CKE
            CKE <= 1'b1;
            nRAS <= 1'b1;
            nCAS <= 1'b1;
            nRWE <= 1'b1;
            // Hold BA
            // Hold RA[11:8]
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
                // ACT CKD
                CKE <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            BA[1:0] <= RWBank[6:5];
            RA[11:8] <= RWBank[4:1];
            // Hold RA[7:0]
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
                // NOP CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
            end
            // Hold BA
            RA[11:9] <= 3'b000; // no auto-precharge
            RA[8] <= RWBank[7];
            // RA[7:0] is transparent
            DQML <=  RWBank[0];
            DQMH <= !RWBank[0];
        end 4'hA: begin
            if (nEN80) begin // Idle
                // NOP CKD
                CKE <= 1'b0;
                nRAS <= 1'b1;
                nCAS <= 1'b1;
                nRWE <= 1'b1;
                RA[10] <= 1'b0;
            end else if (nWE) begin // Read
                // PC all CKD
                CKE <= 1'b0;
                nRAS <= 1'b0;
                nCAS <= 1'b1;
                nRWE <= 1'b0;
                RA[10] <= 1'b1; // "all"
            end else begin // Write
                // WR CKE
                CKE <= 1'b1;
                nRAS <= 1'b1;
                nCAS <= 1'b0;
                nRWE <= 1'b0;
                RA[10] <= 1'b0; // no auto-precharge
            end
            // Hold BA
            // Hold RA[11,9:8]
            RA[7:0] <= Ain[7:0];
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
