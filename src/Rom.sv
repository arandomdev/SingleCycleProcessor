/*
 * Module `Rom`
 *
 * Single port, single clock access, rom with configurable width and depth.
 */

`timescale 1ns / 1ns

module Rom #(
    parameter int Width = 32,
    parameter int Depth = 32,

    localparam int AddrWidth = $clog2(Depth)
) (
    input wire clk,
    input wire reset,
    input wire [AddrWidth-1:0] addr,
    output logic [Width-1:0] data
);
  logic [Width-1:0] rom[Depth];
  always_ff @(posedge clk) begin
    if (reset) begin
      data <= 0;
    end else if (addr < Depth) begin
      data <= rom[addr];
    end else begin
      data <= 0;
    end
  end
endmodule