/*
 * Module `ALUControl`
 *
 * Decodes the alu operation, funct7, and funct3 into the specific ALU opcodes.
 */


`timescale 1ns / 1ns

module ALUControl
  import Shared::ALUOpcode;
(
    input wire [1:0] funct7Parts,  // {funct7[6], funct7[0]}
    input wire [2:0] funct3,
    input wire [1:0] aluOp,
    output ALUOpcode::t_e aluOpcode
);
  always_comb begin
    case (aluOp)
      2'b00: aluOpcode = ALUOpcode::ADD;
      2'b01: begin
        // B-type
        case (funct3)
          3'b000: aluOpcode = ALUOpcode::XOR;
          3'b001: aluOpcode = ALUOpcode::EQ;
          default: begin
            if (funct3 != 'x) $error("ALUControl: Unknown B-Type funct3, %b", funct3);
            aluOpcode = ALUOpcode::ADD;
          end
        endcase
      end
      2'b10: begin
        // R-type
        case ({
          funct7Parts, funct3
        })
          5'b00000: aluOpcode = ALUOpcode::ADD;
          5'b10000: aluOpcode = ALUOpcode::SUB;
          5'b00100: aluOpcode = ALUOpcode::XOR;
          5'b00110: aluOpcode = ALUOpcode::OR;
          5'b00111: aluOpcode = ALUOpcode::AND;
          5'b00001: aluOpcode = ALUOpcode::SLL;
          5'b01000: aluOpcode = ALUOpcode::MUL;
          default: begin
            if ({funct7Parts, funct3} != 'x)
              $error("ALUControl: Unknown R-Type funct, %b", {funct7Parts, funct3});
            aluOpcode = ALUOpcode::ADD;
          end
        endcase
      end
      2'b11: begin
        // I-type
        case (funct3)
          3'b000: aluOpcode = ALUOpcode::ADD;
          3'b100: aluOpcode = ALUOpcode::XOR;
          3'b110: aluOpcode = ALUOpcode::OR;
          3'b111: aluOpcode = ALUOpcode::AND;
          3'b001: aluOpcode = ALUOpcode::SLL;
          default: begin
            if (funct3 != 'x) $error("ALUControl: Unknown I-Type funct3, %b", funct3);
            aluOpcode = ALUOpcode::ADD;
          end
        endcase
      end
      default: begin
        if (aluOp != 'x) $error("ALUControl: Unknown aluOp, %b", aluOp);
        aluOpcode = ALUOpcode::ADD;
      end
    endcase
  end
endmodule
