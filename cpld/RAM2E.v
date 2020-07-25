module RAM2E(C14M, C14M_2, C7M, Q3, PHI0, PHI1,
			 nPRAS, nPCAS, nWE, nWE80, nEN80,
			 nRAS, nCAS, nRWE,
			 VD, MD, RD, nC07X, MA, RA,
			 Q3_2, C3M58, AN3, nCASEN, C073SEL,
			 DelayIn, DelayOut);

	// Control inputs
	input C14M, PHI1, C7M;
	input nWE, nWE80, nEN80, nC07X;

	// Unused inputs
	input C14M_2, Q3_2, C3M58, Q3, PHI0;
	input nPRAS, nPCAS, nCASEN, AN3;

	// Delay
	input [3:0] DelayIn;
	output [3:0] DelayOut;
	assign DelayOut[0] = 0; // RC delay unused
	assign DelayOut[1] = ~nEN80;
	assign DelayOut[2] = DelayIn[1];
	assign DelayOut[3] = 0; // 3rd delay unused
	wire EN80 = DelayIn[2]; // 2 * 15 ns delay max
	reg MDBEN = 0;

	// DRAM control
	output reg nRAS = 1;
	output reg nCAS = 1;
	output nRWE = nWE80;

	// Address bus and bank address registers
	input [7:0] MA; // Low-order multiplexed DRAM address (input, output by Apple II)
	output reg [11:8] RA = 4'h0;
	reg [5:0] BA = 0; // Bank address
	wire [4:0] BAS = {BA[4], BA[4] ? BA[5] : BA[3], BA[2:0]};
	output reg C073SEL = 0; // Bank register select

	// Video data bus
	inout [7:0] VD = VDOE ? VDR[7:0] : 8'bZ;
	reg [7:0] VDR; // Registered video data
	wire VDOE = ~PHI1;
	
	// 6502 data bus
	inout [7:0] MD = MDOE ? MDR[7:0] : 8'bZ;
	reg [7:0] MDR; // Registered DRAM read data
	wire MDOE = EN80 & nWE & MDBEN;
	
	// DRAM data bus
	inout [7:0] RD = RDOE ? MD[7:0] : 8'bZ;
	wire RDOE = EN80 & ~nWE;

	/* State Counters */
	reg PHI1reg = 0; // Saved PHI1 at last rising clock edge
	reg PHI0seen = 0; // Have we seen PHI0 since reset?
	reg [3:0] S = 0; // State counter
	reg [3:0] Ref = 0; // Refresh skip counter

	always @(posedge C14M) begin
		// Refresh counter allows DRAM refresh once every 13 cycles
		if (S==4'h1) Ref <= (Ref[3:2]==2'b11) ? 4'h0 : Ref+1;
	
		// Synchronize state counter to S1 when just entering PHI1
		PHI1reg <= PHI1; // Save old PHI1
		if (~PHI1) PHI0seen <= 1; // PHI0seen set in PHI0
		S <= (PHI1 & ~PHI1reg & PHI0seen) ? 4'h1 : 
			S==4'h0 ? 4'h0 :
			S==4'hF ? 4'hF : S+1;

		// DRAM RAS
		nRAS <= ~((PHI1 & ~PHI1reg & PHI0seen) | S==4'h1 | S==4'h2 |
			(S==4'h4 & Ref==0) |
			 S==4'h7 | S==4'h8 | S==4'h9 | S==4'hA);

		// DRAM address multiplexing
		RA[11:8] <=
			(S==4'h6 | S==4'h7) ? {1'b0, BAS[4], BAS[3], BAS[2]} :
			(S==4'h8 | S==4'h9 | S==4'hA | S==4'hB) ? {1'b0, 1'b0, BAS[1], BAS[0]} : 4'b0;
			
		// DRAM CAS
		nCAS <= ~(S==4'h2 | S==4'h3 | (S==4'h4 & Ref==0) |
			S==4'hA | S==4'hB);
			
		// Memory data bus gating (only active from S11-S15)
		MDBEN <= S==4'hB | S==4'hC | S==4'hD | S==4'hE | S==4'hF;
		
		// Latch 80-column video data at end of S3
		if (S==4'h3) VDR[7:0] <= RD[7:0];

		// Latch bank select at end of S7 and S8
		if (S==4'h0 | S==4'h1) C073SEL <= 0;
		if (S==4'h7) C073SEL <= (MA[3:0]==4'h1 | MA[3:0]==4'h3 | MA[3:0]==4'h5 | MA[3:0]==4'h7);
		if (S==4'h8) C073SEL <= C073SEL & ~nC07X & ~nWE;
		
		// Set bank register at end of S11
		if (S==4'hB & C073SEL) BA[5:0] <= MD[5:0];
		
		// Latch DRAM read data at end of S11
		if (S==4'hB) MDR[7:0] <= RD[7:0];
	end
endmodule
