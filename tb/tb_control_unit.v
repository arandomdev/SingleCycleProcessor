`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_control_unit();
    reg 	[6:0] instr;
	wire    [1:0] aluop;
	wire	Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;

    control_unit dut(
	.instr 	(instr),
    .aluop  (aluop),
    .Branch (Branch), 
    .MemRead (MemRead), 
    .MemtoReg (MemtoReg), 
    .MemWrite (MemWrite), 
    .ALUSrc (ALUSrc),
    .Jump (Jump), 
    .RegWrite (RegWrite));


    initial begin
        $monitor("%t instr=%b aluop=%b Branch=%b MemRead=%b MemtoReg=%b MemWrite=%b ALUSrc=%b RegWrite=%b Jump=%b", 
                 $time, instr,aluop,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump);

        #0;
        instr = 7'b0110011; // R-type
        #1;
        instr = 7'b0010011; // I-type
        #1;
        instr = 7'b0100011; // S-type
        #1;
        instr = 7'b0000011; // L-type
        #1;
        instr = 7'b1100011; // B-type
        #1;
        instr = 7'b0000000; // default
        #1;
        instr = 7'b1101111; // JAL
        # 1
        $stop;
        
    end


endmodule