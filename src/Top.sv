`timescale 1ns / 1ns

module Top (
    input wire rawClk
);
  wire clk;
  wire reset;

  // PC signals
  logic signed [31:0] pc;
  wire isBranch;
  wire isJal;
  wire isJalr;
  wire halt;

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
  wire [4:0] aluOpcode;  // Specific alu operation from ALUControl
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
      .reset(0),  // always run
      .locked(reset),  // keep in reset until clock stabilizes
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
      .Depth(32)
  ) rom (
      .clk  (clk),
      .reset(reset),
      .addr (pc),
      .data (instruction),
  );

  Ram #(
      .Width(32),
      .Depth(32)
  ) ram (
      .clk(clk),
      .reset(reset),
      .read(memRead),
      .write(memWrite),
      .addr(aluResult),
      .writeData(regData2),
      .readData(memReadData)
  );

  // Constant assignments
  assign aluBValue = aluUseImm ? imm : regData2;

  always_comb begin : RegWriteDataCompute
    if (isJal || isJalr) begin
      regWriteData = pc + 4;
    end else if (memToReg) begin
      regWriteData = memReadData;
    end else begin
      regWriteData = aluResult;
    end
  end

  always_ff @(posedge clk) begin : PCCompute
    if (reset) begin
      pc <= -4;
    end else if (halt) begin
      pc <= pc;  // Stop
    end else if (isBranch && aluZero) begin
      pc <= pc + imm;
    end else if (isJal) begin
      pc <= pc + imm;
    end else if (isJalr) begin
      pc <= aluResult;
    end
  end

endmodule
