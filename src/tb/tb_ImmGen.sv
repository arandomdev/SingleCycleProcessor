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

module tb_ImmGen;
  reg [31:0] instr;  //32 bit instruction
  wire signed [31:0] out;

  ImmGen TEST (.*);

  initial begin
    instr = 32'b00000000011100000000000000010011;  //I-type. d7
    #1;
    assert (out == 7)
    else $display("I-type incorrect, expected 7 not %d", out);

    instr = 32'b11100000011100000000000000010011;  //I-type. -505
    #1;
    assert (out == -505)
    else $display("I-type incorrect, expected -505 not %d", out);

    instr = 32'b11100000011100000000000000100011;  //S-type. -512
    #1;
    assert (out == -512)
    else $display("S-type incorrect, expected -512 not %d", out);

    instr = 32'b00000000011100000000000110100011;  //S-type. d3
    #1;
    assert (out == 3)
    else $display("S-type incorrect, expected 3 not %d", out);

    instr = 32'b00000000000000000000000101100011;  //SB-type. 2
    #1;
    assert (out == 2)
    else $display("SB-type incorrect, expected 2 not %d", out);

    instr = 32'b00000010000000000000000001100011;  //SB-type. 32
    #1;
    assert (out == 32)
    else $display("SB-type incorrect, expected 32 not %d", out);

    instr = 32'b00000000000000000000000011100011;  //SB-type. 2048
    #1;
    assert (out == 2048)
    else $display("SB-type incorrect, expected 2048 not %d", out);

    instr = 32'b10000000000000000000000001100011;  //SB-type. -4096
    #1;
    assert (out == -4096)
    else $display("SB-type incorrect, expected -4096 not %d", out);

    instr = 32'b00000010000000000000000000110011;  //R-type. d0
    #1;
    assert (out == 0)
    else $display("R-type incorrect, expected 0 not %d", out);

    #2;
    $display("Testing Complete");
    $finish;
  end
endmodule
