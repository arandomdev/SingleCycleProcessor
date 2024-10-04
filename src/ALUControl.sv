/*
 * Module `ALUControl`
 *
 * Decodes the alu operation, funct7, and funct3 into the specific ALU opcodes.
 */


`timescale 1ns / 1ns

module ALUControl
  import Shared::ALUOpcode;
(
    input  wire  [1:0] funct7Parts,  // {funct7[6], funct7[0]}
    input  wire  [2:0] funct3,
    input  wire  [1:0] aluOp,
    output logic [4:0] aluOpcode
);
  always_comb begin
    unique case (aluOp)
      2'b00: aluOpcode = ALUOpcode::ADD;
      2'b01: aluOpcode = ALUOpcode::SUB;
      2'b10: begin
        // R-type, directly translate
        aluOpcode = ALUOpcode::t_e'({funct7Parts, funct3});
      end
      2'b11: begin
        // I-type, directly translate
        aluOpcode = ALUOpcode::t_e'({2'b0, funct3});
      end
    endcase
  end
endmodule
