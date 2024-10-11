`timescale 1ns / 1ns

module tb_ALUControl
  import Shared::ALUOpcode;
();
  logic [1:0] funct7Parts;
  logic [2:0] funct3;
  logic [1:0] aluOp;
  ALUOpcode::t_e aluOpcode;

  ALUControl dut (.*);

  // Testing Procedure
  initial begin
    funct7Parts = 0;
    funct3 = 0;
    aluOp = 2'b00;
    #1;
    assert (aluOpcode == ALUOpcode::ADD)
    else $display("ALU Op ADD Incorrect");

    funct3 = 1;
    aluOp  = 2'b01;
    #1;
    assert (aluOpcode == ALUOpcode::EQ)
    else $display("ALU Op B-type Incorrect");

    funct7Parts = 2;
    funct3 = 0;
    aluOp = 2'b10;
    #1;
    assert (aluOpcode == ALUOpcode::SUB)
    else $display("ALU Op R-type SUB Incorrect");

    funct7Parts = 0;
    funct3 = 6;
    aluOp = 2'b11;
    #1;
    assert (aluOpcode == ALUOpcode::OR)
    else $display("ALU Op I-type OR Incorrect");

    #2;
    $display("Testing Complete");
    $finish();
  end
endmodule
