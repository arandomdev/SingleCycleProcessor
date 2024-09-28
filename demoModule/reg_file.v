`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: 
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

module reg_file(clk, wren, wd, rr1, rr2, wr, rd1, rd2);
  input clk, wren; //clock and write enable ports
  input [4:0] rr1, rr2, wr; //5 bit register address inputs
  input [31:0] wd; //data to write
  output [31:0] rd1, rd2; //read data outputs

  reg [31:0] file [31:0]; //32 registers 32bits wide
  integer i;
   initial begin
	  file[0] = 32'h0;
    // init rest of your file



   end

  //should be combinational
  assign rd1 =  // finish your desigh 
  assign rd2 =  // finish your desigh 

  //write data Logic when the wren triggered
  always @(posedge clk) begin
    // finish your design


  end


endmodule
