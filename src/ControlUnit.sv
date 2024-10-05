/*
 * Module `ControlUnit`
 *
 * Computes the control signals
 */

`timescale 1ns / 1ns

module ControlUnit (
    input wire [6:0] instrOpcode,
    output wire [1:0] aluOp,
    output wire isBranch,
    output wire memRead,
    output wire memToReg,
    output wire memWrite,
    output wire aluUseImm,
    output wire regWrite,
    output wire isJal,
    output wire isJalr,
    output wire halt
);
  logic [10:0] sig;
  assign {aluOp, isBranch, memRead, memToReg, memWrite, aluUseImm, regWrite, isJal, isJalr, halt}
    = sig;

  always_comb begin
    case (instrOpcode)
      7'b0110011: sig = {11'b10000001000};  // R
      7'b0010011: sig = {11'b11000011000};  // I
      7'b0000011: sig = {11'b00011011000};  // I, Load
      7'b0100011: sig = {11'b00000110000};  // S
      7'b1100011: sig = {11'b01100000000};  // B
      7'b1101111: sig = {11'b00000011100};  // J
      7'b1100111: sig = {11'b11000011010};  // I, jalr
      7'b0110111: sig = {11'b00000011000};  // U
      default: begin
        if (instrOpcode != 'x) $error("ControlUnit: Unknown instruction opcode, %b", instrOpcode);
        sig = {11'b00000000001};  // Halt
      end
    endcase
  end
endmodule
