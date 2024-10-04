/*
 * Module `Ram`
 *
 * Single port rw ram, single clock access, ram with configurable width and depth.
 * Data clocked on the negative edge.
 */

`timescale 1ns / 1ns

module Ram #(
    parameter int Width = 32,
    parameter int Depth = 32,

    localparam int AddrWidth = $clog2(Depth)
) (
    input wire clk,
    input wire reset,
    input wire read,
    input wire write,
    input wire [AddrWidth-1:0] addr,
    input wire [Width-1:0] writeData,
    output wire logic [Width-1:0] readData
);
  logic [Width-1:0] ram[Depth];

  always_ff @(negedge clk) begin
    if (reset) begin
      data <= 0;
    end else if (addr >= Depth) begin
      data <= 0;  // Address out of range
    end else if (read) begin
      readData <= ram[addr];
    end else if (write) begin
      ram[addr] <= writeData;
    end
  end
endmodule
