`timescale 1ns / 1ns

module Rom #(
    parameter integer Width = 32,
    parameter integer Depth = 32,

    localparam integer AddrWidth = $clog2(DEPTH)
) (
    input wire clk,
    input wire [AddrWidth-1:0] addr,
    output logic [Width-1:0] data
);

  reg [Width-1:0] rom[Depth];
  always @(posedge clk) begin
    if (addr >= Depth) begin
      data <= 0;
    end else begin
      data <= rom[addr];
    end
  end
endmodule
