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
    parameter int AddrWidth = 30
) (
    input wire clk,
    input wire reset,
    input wire read,
    input wire write,
    input wire [AddrWidth-1:0] addr,
    input wire signed [Width-1:0] writeData,
    output logic signed [Width-1:0] readData
);
  logic signed [Width-1:0] ram[Depth];

  always_ff @(negedge clk) begin
    if (reset) begin
      readData <= 0;
    end else if (addr >= Depth) begin
      if (read || write) $error("Ram: Address out of range, %h", addr);
      readData <= 0;
    end else if (read) begin
      readData <= ram[addr];
    end else if (write) begin
      ram[addr] <= writeData;
    end
  end
endmodule
