// IC Compiler II Version W-2024.09 Verilog Writer
// Generated on 5/29/2025 at 11:57:19
// Library Name: fulladder_orient1
// Block Name: fulladder_orient1
// User Label: 
// Write Command: write_verilog ./results/full_adder.routed.v
module full_adder ( A , B , C_in , C_out , Clock , SUM ) ;
input  [3:0] A ;
input  [3:0] B ;
input  C_in ;
output C_out ;
input  Clock ;
output [3:0] SUM ;

wire [3:0] reg1 ;
wire [3:0] reg2 ;
wire [3:0] sum_i ;

DFFX1_RVT \reg1_reg[3] ( .D ( A[3] ) , .CLK ( Clock ) , .Q ( reg1[3] ) ) ;
DFFX1_RVT \reg1_reg[2] ( .D ( A[2] ) , .CLK ( Clock ) , .Q ( reg1[2] ) , 
    .QN ( n69 ) ) ;
DFFX1_RVT \reg1_reg[1] ( .D ( A[1] ) , .CLK ( Clock ) , .QN ( n66 ) ) ;
DFFX1_RVT \reg1_reg[0] ( .D ( A[0] ) , .CLK ( Clock ) , .Q ( reg1[0] ) , 
    .QN ( n65 ) ) ;
DFFX1_RVT \reg2_reg[3] ( .D ( B[3] ) , .CLK ( Clock ) , .Q ( reg2[3] ) ) ;
DFFX1_RVT \reg2_reg[2] ( .D ( B[2] ) , .CLK ( Clock ) , .Q ( reg2[2] ) , 
    .QN ( n70 ) ) ;
DFFX1_RVT \reg2_reg[0] ( .D ( B[0] ) , .CLK ( Clock ) , .Q ( reg2[0] ) , 
    .QN ( n68 ) ) ;
DFFX1_RVT c_in_reg ( .D ( C_in ) , .CLK ( Clock ) , .Q ( c_in ) , 
    .QN ( n71 ) ) ;
DFFX1_RVT \SUM_reg[2] ( .D ( sum_i[2] ) , .CLK ( Clock ) , .Q ( SUM[2] ) ) ;
DFFX1_RVT \SUM_reg[3] ( .D ( sum_i[3] ) , .CLK ( Clock ) , .Q ( SUM[3] ) ) ;
DFFX1_RVT C_out_reg ( .D ( c_out ) , .CLK ( Clock ) , .Q ( C_out ) ) ;
DFFX1_RVT \SUM_reg[0] ( .D ( \add_1_root_add_25_2/n40 ) , .CLK ( Clock ) , 
    .QN ( SUM[0] ) ) ;
DFFX1_RVT \SUM_reg[1] ( .D ( \add_1_root_add_25_2/n28 ) , .CLK ( Clock ) , 
    .QN ( SUM[1] ) ) ;
DFFX2_RVT \reg2_reg[1] ( .D ( B[1] ) , .CLK ( Clock ) , .QN ( n67 ) ) ;
INVX1_RVT U5 ( .A ( n34 ) , .Y ( n5 ) ) ;
AND2X1_RVT U6 ( .A1 ( n29 ) , .A2 ( n47 ) , .Y ( n16 ) ) ;
INVX1_RVT U7 ( .A ( n9 ) , .Y ( n17 ) ) ;
OR2X2_RVT U8 ( .A1 ( n65 ) , .A2 ( n45 ) , .Y ( n29 ) ) ;
INVX0_RVT U9 ( .A ( n10 ) , .Y ( n3 ) ) ;
AND2X1_RVT U10 ( .A1 ( n5 ) , .A2 ( n6 ) , .Y ( n19 ) ) ;
INVX0_RVT U11 ( .A ( n27 ) , .Y ( n4 ) ) ;
INVX0_RVT U12 ( .A ( n28 ) , .Y ( n6 ) ) ;
INVX0_RVT U13 ( .A ( n18 ) , .Y ( n54 ) ) ;
OR2X1_RVT U14 ( .A1 ( n17 ) , .A2 ( n53 ) , .Y ( n18 ) ) ;
INVX0_RVT U15 ( .A ( n9 ) , .Y ( n7 ) ) ;
AND3X1_RVT U16 ( .A1 ( n29 ) , .A2 ( n52 ) , .A3 ( n47 ) , .Y ( n33 ) ) ;
INVX0_RVT U17 ( .A ( n16 ) , .Y ( n15 ) ) ;
AND2X1_RVT U18 ( .A1 ( n7 ) , .A2 ( n19 ) , .Y ( n8 ) ) ;
AND2X1_RVT U19 ( .A1 ( n29 ) , .A2 ( n47 ) , .Y ( n9 ) ) ;
OR3X1_RVT U20 ( .A1 ( n3 ) , .A2 ( n24 ) , .A3 ( n8 ) , .Y ( n22 ) ) ;
OR2X1_RVT U21 ( .A1 ( n27 ) , .A2 ( n11 ) , .Y ( n24 ) ) ;
AND2X1_RVT U22 ( .A1 ( n21 ) , .A2 ( n40 ) , .Y ( n10 ) ) ;
AND2X1_RVT U23 ( .A1 ( n20 ) , .A2 ( n6 ) , .Y ( n11 ) ) ;
INVX2_RVT U24 ( .A ( n44 ) , .Y ( n47 ) ) ;
INVX0_RVT U25 ( .A ( n52 ) , .Y ( n20 ) ) ;
INVX0_RVT U26 ( .A ( n43 ) , .Y ( n21 ) ) ;
INVX0_RVT U27 ( .A ( n22 ) , .Y ( n26 ) ) ;
AND2X1_RVT U28 ( .A1 ( n14 ) , .A2 ( n17 ) , .Y ( n12 ) ) ;
OR2X1_RVT U29 ( .A1 ( n12 ) , .A2 ( n13 ) , .Y ( n42 ) ) ;
AND2X1_RVT U30 ( .A1 ( n40 ) , .A2 ( n24 ) , .Y ( n13 ) ) ;
AND2X1_RVT U31 ( .A1 ( n19 ) , .A2 ( n40 ) , .Y ( n14 ) ) ;
AND2X1_RVT U32 ( .A1 ( n15 ) , .A2 ( n19 ) , .Y ( n23 ) ) ;
AND2X1_RVT U33 ( .A1 ( n53 ) , .A2 ( n17 ) , .Y ( n55 ) ) ;
INVX0_RVT U34 ( .A ( n45 ) , .Y ( n46 ) ) ;
AND2X1_RVT U35 ( .A1 ( n66 ) , .A2 ( n67 ) , .Y ( n34 ) ) ;
AND2X1_RVT U36 ( .A1 ( n69 ) , .A2 ( n70 ) , .Y ( n28 ) ) ;
AND2X1_RVT U37 ( .A1 ( n68 ) , .A2 ( n71 ) , .Y ( n45 ) ) ;
AND2X1_RVT U38 ( .A1 ( c_in ) , .A2 ( reg2[0] ) , .Y ( n44 ) ) ;
AND2X1_RVT U39 ( .A1 ( reg2[2] ) , .A2 ( reg1[2] ) , .Y ( n27 ) ) ;
OR2X1_RVT U40 ( .A1 ( n67 ) , .A2 ( n66 ) , .Y ( n52 ) ) ;
AND2X1_RVT U41 ( .A1 ( reg2[3] ) , .A2 ( reg1[3] ) , .Y ( n43 ) ) ;
OR2X1_RVT U42 ( .A1 ( reg1[3] ) , .A2 ( reg2[3] ) , .Y ( n40 ) ) ;
OR2X1_RVT U43 ( .A1 ( n24 ) , .A2 ( n23 ) , .Y ( n41 ) ) ;
AND2X1_RVT U44 ( .A1 ( n41 ) , .A2 ( n3 ) , .Y ( n25 ) ) ;
OR2X1_RVT U45 ( .A1 ( n26 ) , .A2 ( n25 ) , .Y ( sum_i[3] ) ) ;
AND2X1_RVT U46 ( .A1 ( n4 ) , .A2 ( n6 ) , .Y ( n32 ) ) ;
INVX0_RVT U47 ( .A ( n33 ) , .Y ( n30 ) ) ;
AND3X1_RVT U48 ( .A1 ( n32 ) , .A2 ( n5 ) , .A3 ( n30 ) , .Y ( n31 ) ) ;
INVX0_RVT U49 ( .A ( n31 ) , .Y ( n39 ) ) ;
INVX0_RVT U50 ( .A ( n32 ) , .Y ( n36 ) ) ;
OR2X1_RVT U51 ( .A1 ( n34 ) , .A2 ( n33 ) , .Y ( n35 ) ) ;
AND2X1_RVT U52 ( .A1 ( n36 ) , .A2 ( n35 ) , .Y ( n37 ) ) ;
INVX0_RVT U53 ( .A ( n37 ) , .Y ( n38 ) ) ;
AND2X1_RVT U54 ( .A1 ( n39 ) , .A2 ( n38 ) , .Y ( sum_i[2] ) ) ;
OR2X1_RVT U55 ( .A1 ( n43 ) , .A2 ( n42 ) , .Y ( c_out ) ) ;
AND2X1_RVT U56 ( .A1 ( n46 ) , .A2 ( n47 ) , .Y ( n49 ) ) ;
INVX0_RVT U57 ( .A ( n49 ) , .Y ( n48 ) ) ;
AND2X1_RVT U58 ( .A1 ( n48 ) , .A2 ( n65 ) , .Y ( n51 ) ) ;
AND2X1_RVT U59 ( .A1 ( reg1[0] ) , .A2 ( n49 ) , .Y ( n50 ) ) ;
OR2X1_RVT U60 ( .A1 ( n51 ) , .A2 ( n50 ) , .Y ( \add_1_root_add_25_2/n40 ) ) ;
AND2X1_RVT U61 ( .A1 ( n5 ) , .A2 ( n52 ) , .Y ( n53 ) ) ;
OR2X1_RVT U62 ( .A1 ( n55 ) , .A2 ( n54 ) , .Y ( \add_1_root_add_25_2/n28 ) ) ;
endmodule


