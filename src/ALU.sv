/*
 * Module `ALU`
 *
 * Combinatorial 32-bit ALU with zero signal.
 */

`timescale 1ns / 1ns

module ALU
  import Shared::ALUOpcode;
(
    input signed [31:0] a,
    input signed [31:0] b,
    input ALUOpcode::t_e opcode,

    output logic signed [31:0] y,
    output wire zero
);
  always_comb begin
    case (opcode)
      ALUOpcode::ADD: begin
        y = a + b;
      end
      ALUOpcode::SLL: begin
        y = a << b;
      end
      ALUOpcode::OR: begin
        y = a | b;
      end
      ALUOpcode::AND: begin
        y = a & b;
      end
      ALUOpcode::MUL: begin
        y = a * b;
      end
      ALUOpcode::SUB: begin
        y = a - b;
      end
      default: begin
        y = 0;
      end
    endcase
  end

  assign zero = y == 0;
endmodule
