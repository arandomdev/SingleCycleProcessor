`timescale 1ns / 1ns

module TestTop (
    input wire rawClk
);
  (* DONT_TOUCH = "TRUE" *) wire clk;
  (* DONT_TOUCH = "TRUE" *) logic [4:0] addr;
  (* DONT_TOUCH = "TRUE" *) logic [31:0] data;

  ClockGenerator instance_name (
      .sysClk(clk),  // output sysClk
      .reset(0),  // input reset
      .locked(),  // output locked
      .rawClk(rawClk)  // input rawClk
  );

  Rom #(
      .Width(32),
      .Depth(32)
  ) rom (
      .*
  );
endmodule
