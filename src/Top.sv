`timescale 1ns / 1ns

module Top
  import Shared::*;
(
    input  wire rawClk,
    input  wire extReset,
    output wire halt
);
  wire clk;
  wire locked;
  wire reset;

  // PC signals
  logic signed [31:0] nextPC;
  logic signed [31:0] currentPC;
  wire isBranch;
  wire isJal;
  wire isJalr;

  // Instruction signals
  wire [31:0] instruction;
  wire signed [31:0] imm;

  // Register file signals
  wire signed [31:0] regData1;
  wire signed [31:0] regData2;
  logic signed [31:0] regWriteData;
  wire regWrite;

  // ALU signals
  wire [1:0] aluOp;  // ALU operation from control unit
  ALUOpcode::t_e aluOpcode;  // Specific alu operation from ALUControl
  wire aluUseImm;
  wire signed [31:0] aluBValue;
  wire signed [31:0] aluResult;
  wire aluZero;

  // Memory signals
  wire memRead;
  wire memWrite;
  wire signed [31:0] memReadData;
  wire memToReg;


  // Instantiate modules
  ClockGenerator clockGen (
      .sysClk(clk),
      .reset (extReset),  // always run
      .locked(locked),    // keep in reset until clock stabilizes
      .rawClk(rawClk)
  );

  ALU alu (
      .a(regData1),
      .b(aluBValue),
      .opcode(aluOpcode),
      .y(aluResult),
      .zero(aluZero)
  );

  ALUControl aluControl (
      .funct7Parts({instruction[30], instruction[25]}),
      .funct3(instruction[14:12]),
      .aluOp(aluOp),
      .aluOpcode(aluOpcode)
  );

  ControlUnit controlUnit (
      .instrOpcode(instruction[6:0]),
      .aluOp(aluOp),
      .isBranch(isBranch),
      .memRead(memRead),
      .memToReg(memToReg),
      .memWrite(memWrite),
      .aluUseImm(aluUseImm),
      .regWrite(regWrite),
      .isJal(isJal),
      .isJalr(isJalr),
      .halt(halt)
  );

  ImmGen immGen (
      .instr(instruction),
      .out  (imm)
  );

  RegisterFile #(
      .RegisterWidth(32),
      .NRegisters(32)
  ) regFile (
      .clk(clk),
      .reset(reset),
      .r1Addr(instruction[19:15]),
      .r2Addr(instruction[24:20]),
      .r1Data(regData1),
      .r2Data(regData2),
      .wEn(regWrite),
      .wAddr(instruction[11:7]),
      .wData(regWriteData)
  );

  Rom #(
      .Width(32),
      .Depth(32),
      .AddrWidth(30)
  ) rom (
      .clk  (clk),
      .reset(reset),
      .addr (30'(nextPC >> 2)),
      .data (instruction)
  );

  Ram #(
      .Width(32),
      .Depth(256),
      .AddrWidth(30)
  ) ram (
      .clk(clk),
      .reset(reset),
      .read(memRead),
      .write(memWrite),
      .addr(30'(aluResult >> 2)),
      .writeData(regData2),
      .readData(memReadData)
  );

  assign reset = !locked || extReset;
  assign aluBValue = aluUseImm ? imm : regData2;

  always_comb begin : RegWriteDataCompute
    if (isJal || isJalr) begin
      regWriteData = currentPC + 4;
    end else if (memToReg) begin
      regWriteData = memReadData;
    end else begin
      regWriteData = aluResult;
    end
  end

  always_comb begin : NextPCCompute
    if (reset) begin
      nextPC = 0;
    end else if (halt) begin
      nextPC = currentPC;  // Stop
    end else if (isBranch && aluZero) begin
      nextPC = currentPC + imm;
    end else if (isJal) begin
      nextPC = currentPC + imm;
    end else if (isJalr) begin
      nextPC = aluResult;
    end else begin
      nextPC = currentPC + 4;
    end
  end

  always_ff @(posedge clk) begin : PCTransition
    currentPC <= nextPC;
  end

endmodule
