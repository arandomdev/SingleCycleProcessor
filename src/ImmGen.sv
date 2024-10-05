/*
 * Module `ImmGen`
 *
 * Combinatorial block to decode the imm from different instruction types
 */

`timescale 1ns / 1ns

module ImmGen (
    input wire [31:0] instr,
    output logic signed [31:0] out
);
  wire [6:0] opcode = instr[6:0];

  always_comb begin
    case (opcode)
      7'b0010011, 7'b0000011: out = 32'(signed'(instr[31:20]));  // I
      7'b0100011: out = 32'(signed'({instr[31:25], instr[11:7]}));  // S
      7'b1100011: out = 32'(signed'({instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}));  // B
      7'b0110111: out = 32'({instr[31:12], 12'b0});  // U
      7'b1101111:
      out = 32'(signed'({instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}));  // J
      default: begin
        if (opcode != 'x) $error("ImmGen: Unknown instruction opcode. %b", opcode);
        out = 0;
      end
    endcase
  end
endmodule
