`timescale 1ns/1ns

module lab505(CLOCK_20);
   input CLOCK_20;
   // You need to set it as follow when implementation your design
   // your PC may need
   (* DONT_TOUCH = "TRUE" *)reg  [10:0] 		   PC;        // PC current
   (* DONT_TOUCH = "TRUE" *)wire [10:0]			PC_next;   // PC next to be latched
	(* DONT_TOUCH = "TRUE" *)wire [10:0]			PC_plus;   // PC + 4
   (* DONT_TOUCH = "TRUE" *)wire [10:0]			PC_offset; // PC offset for branching
	(* DONT_TOUCH = "TRUE" *)wire 					to_branch; // branch condition

   (* DONT_TOUCH = "TRUE" *)wire run;
   
   (* DONT_TOUCH = "TRUE" *)wire [31:0] 		A;         // ALU input A
   (* DONT_TOUCH = "TRUE" *)wire [31:0] 		B;         // ALU input B
   (* DONT_TOUCH = "TRUE" *)wire signed [31:0]	Y;			// From a1 of ALU.v
   (* DONT_TOUCH = "TRUE" *)wire [1:0]		aluop;			// From ctrl of control_unit.v
   (* DONT_TOUCH = "TRUE" *)wire [4:0]		aluopcode;		// From aluctrl of alu_control.v
   (* DONT_TOUCH = "TRUE" *)wire			zero;			// From a1 of ALU.v

   // finish rest of your wire

   // your PC intiial is better to be -4 to make sure the first clock will trigger your first instruction
   initial 
    PC = -4;

	parameter HALT = 7'b1111111;

// design run signal which indicate run and halt
   assign run =


    
    // =============== PC =======================
	always @(posedge outclk_0) begin
	  if (run) begin
         // update your PC
	  end
	end

   // finish your PC design
      assign PC_plus = 
      assign PC_offset = 
      assign PC_next = 
      assign to_branch =



   // ================ ALU =================
   // prepare for A and B
   assign A =
   assign B =   // 1 = immediate, 0 = rd2
   
   ALU a1 (/*AUTOINST*/
	   // Outputs
	   .Y				(Y[31:0]),
	   .zero			(zero),
	   // Inputs
	   .A				(A[31:0]),
	   .B				(B[31:0]),
	   .opcode			(aluopcode[4:0]));	 // Templated
   
	


    
    // ================ controller =================



   // =================== ALU controller ============       

			    
   // ================ register file =================
   // prepare your wd data here
   // .....
   // ....
   assign wd = 

   // instanitate your register file


	   
   

    // ================= immediate generator =======


    // =================== RAM ==========================

    
    // ================== Register ROM =============================


    // ================== MMCM =============================
    // remeber to use your locked signal





endmodule
