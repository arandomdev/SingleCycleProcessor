`timescale 1ns / 1ns

module tb_Rom ();
  parameter int ClockHalfPeriod = 5;
  parameter int Depth = 32;
  parameter int Width = 32;
  parameter int AddrWidth = 30;

  logic clk;
  logic reset;
  logic [AddrWidth-1:0] addr;
  wire [Width-1:0] data;

  // DUT Instantiation
  Rom #(
      .Width(Width),
      .Depth(Depth),
      .AddrWidth(AddrWidth)
  ) rom (
      .*
  );

  // Set rom data
  initial begin
    // Set rom data
    for (int i = 0; i < Depth; i++) begin
      rom.rom[i] = i + 1;
    end
  end

  // Generate clock
  initial begin
    clk = 0;
    forever begin
      #ClockHalfPeriod clk = ~clk;
    end
  end

  // Test procedure
  initial begin
    reset = 0;
    @(posedge clk);

    addr <= 0;
    @(posedge clk);
    for (int i = 1; i < Depth; i++) begin
      addr <= i;
      @(posedge clk);
      assert (data == i)  // previous data now available
      else $display("Rom data incorrect at %h, with %h, should be %h", i - 1, data, i);
    end

    // Check last element
    @(posedge clk);
    assert (data == Depth)  // previous data now available
    else $display("Rom data incorrect at %h, with %h, should be %h", Depth - 1, data, Depth);

    @(posedge clk);
    @(posedge clk);
    $display("Testing Complete");
    $finish();
  end

endmodule
