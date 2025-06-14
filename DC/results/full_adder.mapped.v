/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Mon Jun  9 00:21:03 2025
/////////////////////////////////////////////////////////////


module full_adder ( A, B, C_in, C_out, Clock, SUM );
  input [3:0] A;
  input [3:0] B;
  output [3:0] SUM;
  input C_in, Clock;
  output C_out;
  wire   c_in, c_out, n12, n13, n14;
  wire   [3:0] reg1;
  wire   [3:0] reg2;
  wire   [3:0] sum_i;

  DFFX1_RVT \reg1_reg[3]  ( .D(A[3]), .CLK(Clock), .Q(reg1[3]) );
  DFFX1_RVT \reg1_reg[2]  ( .D(A[2]), .CLK(Clock), .Q(reg1[2]) );
  DFFX1_RVT \reg1_reg[1]  ( .D(A[1]), .CLK(Clock), .Q(reg1[1]) );
  DFFX1_RVT \reg1_reg[0]  ( .D(A[0]), .CLK(Clock), .Q(reg1[0]) );
  DFFX1_RVT \reg2_reg[3]  ( .D(B[3]), .CLK(Clock), .Q(reg2[3]) );
  DFFX1_RVT \reg2_reg[2]  ( .D(B[2]), .CLK(Clock), .Q(reg2[2]) );
  DFFX1_RVT \reg2_reg[1]  ( .D(B[1]), .CLK(Clock), .Q(reg2[1]) );
  DFFX1_RVT \reg2_reg[0]  ( .D(B[0]), .CLK(Clock), .Q(reg2[0]) );
  DFFX1_RVT c_in_reg ( .D(C_in), .CLK(Clock), .Q(c_in) );
  DFFX1_RVT \SUM_reg[3]  ( .D(sum_i[3]), .CLK(Clock), .Q(SUM[3]) );
  DFFX1_RVT \SUM_reg[2]  ( .D(sum_i[2]), .CLK(Clock), .Q(SUM[2]) );
  DFFX1_RVT \SUM_reg[1]  ( .D(sum_i[1]), .CLK(Clock), .Q(SUM[1]) );
  DFFX1_RVT \SUM_reg[0]  ( .D(sum_i[0]), .CLK(Clock), .Q(SUM[0]) );
  DFFX1_RVT C_out_reg ( .D(c_out), .CLK(Clock), .Q(C_out) );
  XOR3X1_RVT U12 ( .A1(reg1[0]), .A2(reg2[0]), .A3(c_in), .Y(sum_i[0]) );
  XOR3X1_RVT U13 ( .A1(reg2[1]), .A2(reg1[1]), .A3(n12), .Y(sum_i[1]) );
  XOR3X1_RVT U14 ( .A1(reg2[2]), .A2(reg1[2]), .A3(n13), .Y(sum_i[2]) );
  XOR3X1_RVT U15 ( .A1(reg2[3]), .A2(reg1[3]), .A3(n14), .Y(sum_i[3]) );
  AO222X1_RVT U16 ( .A1(reg1[0]), .A2(reg2[0]), .A3(reg1[0]), .A4(c_in), .A5(
        reg2[0]), .A6(c_in), .Y(n12) );
  AO222X1_RVT U17 ( .A1(reg2[1]), .A2(reg1[1]), .A3(reg2[1]), .A4(n12), .A5(
        reg1[1]), .A6(n12), .Y(n13) );
  AO222X1_RVT U18 ( .A1(reg2[2]), .A2(reg1[2]), .A3(reg2[2]), .A4(n13), .A5(
        reg1[2]), .A6(n13), .Y(n14) );
  AO222X1_RVT U19 ( .A1(reg2[3]), .A2(reg1[3]), .A3(reg2[3]), .A4(n14), .A5(
        reg1[3]), .A6(n14), .Y(c_out) );
endmodule

