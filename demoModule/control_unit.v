`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: 
// Project Name: 
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

module control_unit(
	input 	[6:0] instr,
	output [1:0] aluop,
	output	Branch,
	output  MemRead,
	output  MemtoReg,
	output  MemWrite,
	output  ALUSrc,
	output  RegWrite,
	output  Jump
	//output reg  halt
);
assign Branch = (instr == 7'b0110011) ? 1'b0: //R-type
							  	(instr == 7'b0010011) ? 1'b0: // I-type
									 // S-type
									 // L-type
									 // B-type
									 // JAL
									 // JALR
									 1'b0; //default

// Finish the rest of your design						

endmodule
