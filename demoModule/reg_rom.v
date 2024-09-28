`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: register ROM
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

module reg_rom(addr, q);
  input [4:0] addr; //5 bit register address input
  output [31:0] q;  //read data outputs

  reg [31:0] file [31:0]; //32 registers 32bits wide

  initial begin
  // Inti the instruction codes

  //factorial 6




  //prog2



  // prog1
  file[0]  = 32'h00000093;
  // ... fill the file[1] to file[31]
  // ... tip: fill the rest of file with zero


  end

  // output the Instruction code
  assign q = ;

endmodule
