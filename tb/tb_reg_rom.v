`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_reg_rom
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

module rb_reg_rom;
reg [4:0] addr; //5 bit register address input
wire [31:0] q; //read data outputs
integer i;

  reg_rom TEST(addr, q);

  initial begin
  $display("t=%d, addr=%d, instr=%h", $time, addr, q);
  end

  initial begin
    for (i = 0; i < 32; i = i + 1)begin
      addr = i;
      #1;
    end
    $stop;
  end
endmodule
