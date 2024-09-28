`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_imm_gen
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

module tb_imm_gen;
  reg [31:0] instr; //32 bit instruction
  wire [11:0] out;

  imm_gen TEST(instr, out);

  initial begin
  $display("instr, out");
  end

  initial begin
  $monitor("%d, %d", instr, out);
    #0 instr = 32'b00000000011100000000000000010011; //I-type. d7
    #1 instr = 32'b11100000011100000000000000010011; //I-type. d3591
    #1 instr = 32'b11100000011100000000000000100011; //S-type. d3584
    #1 instr = 32'b00000000011100000000000110100011; //S-type. d3
    #1 instr = 32'b00000000000000000000000101100011; //SB-type. d1
    #1 instr = 32'b00000010000000000000000001100011; //SB-type. d16
    #1 instr = 32'b00000000000000000000000011100011; //SB-type. d1024
    #1 instr = 32'b10000000000000000000000001100011; //SB-type. d2048
    #1 instr = 32'b00000010000000000000000000110011; //R-type. d0
    #1;
    $stop;
  end
endmodule
