`timescale 1ns / 1ns
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

module alu_control (
	input 		[4:0] instr_split,	// {instr[30],instr[25], instr[14:12] (funct3)}
	input 		[1:0] aluop,
	output wire 	[4:0] aluopcode
);

assign aluopcode = (aluop == 2'b00) ? 5'b00000: (aluop == 2'b01) ? 5'b10000:
							// finish the alu decoder design
              // remember the default
	
endmodule
