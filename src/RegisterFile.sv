/*
 * Module `RegisterFile`
 *
 * Register file with 2 async read ports, 1 synchronous write port, and configurable width and depth.
 */

`timescale 1ns / 1ns

module RegisterFile #(
    parameter int RegisterWidth = 32,
    parameter int NRegisters = 32,

    localparam int AddrWidth = $clog2(NRegisters)
) (
    input wire clk,
    input wire reset,
    input wire [AddrWidth-1:0] r1Addr,
    input wire [AddrWidth-1:0] r2Addr,
    output logic [RegisterWidth-1:0] r1Data,
    output logic [RegisterWidth-1:0] r2Data,

    input wire wEn,
    input wire [AddrWidth-1:0] wAddr,
    input wire [RegisterWidth-1:0] wData
);

  logic [RegisterWidth-1:0] registers[NRegisters-1];

  // Register reads are async
  always_comb begin
    if (reset) begin
      r1Data = 0;
    end else if (r1Addr == 0 || r1Addr >= NRegisters) begin
      r1Data = 0;
    end else begin
      r1Data = registers[r1Addr-1];
    end

    if (reset) begin
      r2Data = 0;
    end else if (r2Addr == 0 || r2Addr >= NRegisters) begin
      r2Data = 0;
    end else begin
      r2Data = registers[r2Addr-1];
    end
  end

  always_ff @(posedge clk) begin
    if (!reset && wEn && (wAddr < NRegisters)) begin
      registers[wAddr-1] <= wData;
    end
  end

endmodule
