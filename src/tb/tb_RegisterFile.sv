`timescale 1ns / 1ns

module tb_RegisterFile ();
  parameter int ClockHalfPeriod = 5;
  parameter int RegisterWidth = 32;
  parameter int NRegisters = 32;

  localparam int AddrWidth = $clog2(NRegisters);

  logic clk;
  logic reset;
  logic [AddrWidth-1:0] r1Addr;
  logic [AddrWidth-1:0] r2Addr;
  wire [RegisterWidth-1:0] r1Data;
  wire [RegisterWidth-1:0] r2Data;

  logic wEn;
  logic [AddrWidth-1:0] wAddr;
  logic [RegisterWidth-1:0] wData;

  RegisterFile #(
      .RegisterWidth(RegisterWidth),
      .NRegisters(NRegisters)
  ) regFile (
      .*
  );

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
    @(posedge clk);

    r1Addr = 0;
    r2Addr = 0;
    wEn = 0;
    wAddr = 0;
    wData = 0;

    // Write to register
    @(posedge clk);
    wEn = 1;
    wAddr = 1;
    wData = 32'hDEADBEEF;

    // Read from register
    r1Addr = 1;
    r2Addr = 1;
    @(posedge clk);

    assert (r1Data == 32'hDEADBEEF)
    else $display("Reg1 read failed, expected %h, got %h", 32'hDEADBEEF, r1Data);
    assert (r2Data == 32'hDEADBEEF)
    else $display("Reg2 read failed, expected %h, got %h", 32'hDEADBEEF, r2Data);

    // Verify write to register zero does nothing
    wEn = 1;
    wAddr = 0;
    wData = 1;
    r1Addr = 0;
    r2Addr = 0;
    @(posedge clk);
    assert (r1Data == 0)
    else $display("Reg1 read zero failed, got %h", r1Data);
    assert (r2Data == 0)
    else $display("Reg2 read zero failed, got %h", r2Data);


    @(posedge clk);
    @(posedge clk);
    $display("Testing Complete");
    $finish();
  end
endmodule
