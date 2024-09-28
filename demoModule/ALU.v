`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: 
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

module ALU
(
  output wire signed [31:0] Y,    // output of A B compute result
  output zero,                    // flag indicate the output is zero

  input signed [31:0] A,          // Data A
  input signed [31:0] B,          // Data B
  input [4:0] opcode              // Operation Code
  );

  assign zero = 
  // ... zero generate logic

  assign Y = (opcode == 5'b00111) ? A & B: 
  // ... design the rest ALU function 


    
endmodule
