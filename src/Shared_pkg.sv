/*
 * Package `Shared`
 *
 * Shared enums and constants.
 */

`timescale 1ns / 1ns

package Shared;
  virtual class ALUOpcode;
    typedef enum logic [2:0] {
      ADD,
      SUB,
      XOR,
      OR,
      AND,
      SLL,
      MUL,
      EQ
    } t_e;
  endclass
endpackage
