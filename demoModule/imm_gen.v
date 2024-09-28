//intermediate generator module
//takes in all 32 bits of instructions
//outputs the 12 bit immediate based on I-type or SB-type or S-type

module imm_gen(instr, out);
   input [31:0] instr; //32 bit instruction
   output [31:0] out; //  output reg [31:0] out;
   wire [6:0] opcode = instr[6:0];

    assign out  = (opcode == 7'b0010011) ? {{20{instr[31]}}, instr[31:20]} : //I-type
	// finish your design here
					  // S-type 
					  // SB type
					  // JAL
					  // JALR
					  // L-type
						; // default 
	

endmodule
