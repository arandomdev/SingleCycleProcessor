/*
 * Package `Shared`
 *
 * Shared enums and constants.
 */

package Shared;
  virtual class ALUOpcode;
    typedef enum logic [4:0] {
      // Based on the function codes in the instructions
      // {funct7[6], funct7[0], funct3}
      ADD = 5'b00000,
      SUB = 5'b10000,
      OR  = 5'b00110,
      AND = 5'b00111,
      SLL = 5'b00001,
      MUL = 5'b01000
    } t_e;
  endclass
endpackage
