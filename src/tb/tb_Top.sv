`timescale 1ns / 1ns

module tb_Top
  import TopTestVectors::*;
();
  logic clk;
  logic reset;
  wire halt;
  test_vector_t vector;

  Top top (
      .rawClk(clk),
      .extReset(reset),
      .halt(halt),
      .ramDebugEn(0),
      .ramByteSel(0),
      .ramAddr(0),
      .ramData()
  );

  // Create clock with period of 10ns
  initial begin
    clk = 0;
    forever begin
      #5 clk = ~clk;
    end
  end

  // Testing procedure
  initial begin
    $display("==================================");
    $display("Single Cycle Risc V Processor Test");
    $display("==================================");

    for (int i = 0; i < testVectors.size; i++) begin
      // Reset and load test vector
      reset = 1;
      repeat (3) @(posedge clk);

      vector = testVectors[i];
      $display("Loading program: %s", vector.name);

      top.regFile.registers = vector.initialRegFileState;
      top.ram.ram = vector.initialRamState;
      $readmemh(vector.instructionsFile, top.rom.rom);

      $display("Running...");
      reset = 0;
      @(negedge halt);
      @(posedge halt);
      repeat (3) @(posedge clk);

      $display("Validating results...");
      for (int j = 0; j < 31; j++) begin
        assert (top.regFile.registers[j] == vector.finalRegFileState[j])
        else
          $display(
              "Register file incorrect, at %h, should be %h, not %h.",
              j + 1,
              vector.finalRegFileState[j],
              top.regFile.registers[j]
          );
      end
      for (int j = 0; j < 32; j++) begin
        assert (top.ram.ram[j] == vector.finalRamState[j])
        else
          $display("Ram, at %h, should be %h, not %h", j, vector.finalRamState[j], top.ram.ram[j]);
      end

      $display("Done");
      $display("----------------");
    end

    repeat (3) @(posedge clk);
    $display("Testing Complete");
    $finish();
  end
endmodule
