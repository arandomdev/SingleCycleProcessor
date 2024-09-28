`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_ALU
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_alu();

	wire 	[31:0] 	Y;                      
	wire 			zero;
	
	reg 	[31:0] 	A;
	reg 	[31:0] 	B;
	reg 	[4:0] 	opcode;
  
	ALU dut (
			.Y					(Y),                      
			.zero				(zero),
			.A					(A),
			.B					(B),
			.opcode				(opcode)
	);
  
	initial begin
		$monitor("%t op=%b A=%d B=%d Y=%d zero=%b", $time, opcode, A, B, Y, zero);

		#0;
		opcode = 5'b00111; 	// AND
		A = 32'h0005;
		B = 32'h0004;		
		#1;
		opcode = 5'b00110;	// OR
		A = 32'h0007;
		B = 32'h0008;		
	 	#1;
		opcode = 5'b00000;	// ADD
		A = 32'h0005;
		B = 32'h0004;		
		#1;
		opcode = 5'b10000;	// SUB
		A = 32'h0009;
		B = 32'h0004;		
		#1;
		opcode = 5'b01000;	// Mult 
		A = 32'h0007;
		B = 32'h0007;		
		#1;
		opcode = 5'b00001;	// Bit Shift
		A = 32'h0003;
		B = 32'h0004;	
		#1;
		$stop;

	end
endmodule
