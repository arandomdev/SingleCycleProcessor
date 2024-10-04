`timescale 1ns / 1ns

module tb_ALU
  import Shared::ALUOpcode;
();
  logic signed [31:0] a;
  logic signed [31:0] b;
  ALUOpcode::t_e opcode;
  wire signed [31:0] y;
  wire zero;

  ALU dut (.*);

  initial begin
    #1;
    opcode = ALUOpcode::ADD;
    a = 124;
    b = 17845;
    #1
    assert (y == (a + b))
    else $display("ADD operation incorrect");
    assert (zero == 0)
    else $display("ADD operation zero incorrect");

    opcode = ALUOpcode::SLL;
    a = 4188;
    b = 3;
    #1
    assert (y == (a << b))
    else $display("SLL operation incorrect");
    assert (zero == 0)
    else $display("SLL operation zero incorrect");

    opcode = ALUOpcode::OR;
    a = 1468;
    b = 2861;
    #1
    assert (y == (a | b))
    else $display("OR operation incorrect");
    assert (zero == 0)
    else $display("OR operation zero incorrect");

    opcode = ALUOpcode::AND;
    a = 15678;
    b = 1678;
    #1
    assert (y == (a & b))
    else $display("AND operation incorrect");
    assert (zero == 0)
    else $display("AND operation zero incorrect");

    opcode = ALUOpcode::MUL;
    a = 31;
    b = 6;
    #1
    assert (y == (a * b))
    else $display("MUL operation incorrect");
    assert (zero == 0)
    else $display("MUL operation zero incorrect");

    opcode = ALUOpcode::SUB;
    a = 15;
    b = 7;
    #1
    assert (y == (a - b))
    else $display("SUB operation incorrect");
    assert (zero == 0)
    else $display("SUB operation zero incorrect");

    opcode = ALUOpcode::SUB;
    a = 156;
    b = 156;
    #1
    assert (y == (a - b))
    else $display("SUB operation incorrect");
    assert (zero == 1)
    else $display("SUB operation zero incorrect");

    #2;
    $display("Testing Complete");
    $finish();
  end
endmodule
