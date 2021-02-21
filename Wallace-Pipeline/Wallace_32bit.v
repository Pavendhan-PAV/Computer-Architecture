`include "Cla/RDA_64bit.v"
`include "FullAdder/3fam.v"
`include "Partial/PPG.v"
`include "Dff_levels.v"

module wallace(c,a,b,clk,rst);
input [32:0] a,b; 
output[64:0] c;

input [7:0]xin;
input clk,rst;
assign xin="k";
output [7:0]xout;

wire [31:0][64:0] pp;
wire [31:0][64:0] pp_c;

/*VARIABLE_C means the variable passed inside d flip flop*/

ppg m_ppg_0(pp_c,a[31:0],b[31:0]); // GET PARTIAL PRODUCTS

dff_lvl_1 m_m1(pp_c,rst,clk,pp); //pipeline-1


// -------------------------------------LEVEL-1-----------------------------------//

wire  [9:0][64:0] w_sum_c,w_ca_c,w_sum,w_ca;

three_fa m_a0(w_sum_c[2:0],w_ca_c[2:0],pp[8:0]);
three_fa m_a1(w_sum_c[5:3],w_ca_c[5:3],pp[17:9]);
three_fa m_a2(w_sum_c[8:6],w_ca_c[8:6],pp[26:18]);

sixtyBitAdder a3(pp[27],pp[28],pp[29],w_sum_c[9],w_ca_c[9]);

dff_lvl_2 m2(w_sum_c,w_ca_c,rst,clk,w_sum,w_ca); //pipeline-2

// -------------------------------------LEVEL-2-----------------------------------//

wire [6:0][64:0] w_sum2_c,w_ca2_c,w_sum2,w_ca2;



three_fam a4(w_sum2_c[2:0],w_ca2_c[2:0],w_sum[4:0],w_ca[3:0]);
three_fam a5(w_sum2_c[5:3],w_ca2_c[5:3],w_ca[8:4],w_sum[8:5]);

sixtyBitAdder a6(w_sum[9],w_ca[9],pp[30],w_sum2_c[6],w_ca2_c[6]);

dff_lvl_3 m3(w_sum2_c,w_ca2_c,rst,clk,w_sum2,w_ca2); //pipeline-3


// -------------------------------------LEVEL-3-----------------------------------//

wire [4:0][64:0] w_sum3_c,w_ca3_c,w_sum3,w_ca3;

three_fam a7(w_sum3_c[2:0],w_ca3_c[2:0],w_sum2[4:0],w_ca2[3:0]);

sixtyBitAdder a8(w_sum2[5],w_ca2[4],w_ca2[5],w_sum3_c[3],w_ca3_c[3]);
sixtyBitAdder a9(w_sum2[6],w_ca2[6],pp[31],w_sum3_c[4],w_ca3_c[4]);

dff_lvl_4 m4(w_sum3_c,w_ca3_c,rst,clk,w_sum3,w_ca3); //pipeline-4

// -------------------------------------LEVEL-4-----------------------------------//


wire [2:0][64:0] w_sum4_c,w_ca4_c,w_sum4,w_ca4;

three_fam a10(w_sum4_c[2:0],w_ca4_c[2:0],w_sum3[4:0],w_ca3[3:0]);

dff_lvl_5 m5(w_sum4_c,w_ca4_c,rst,clk,w_sum4,w_ca4); //pipeline-5

// -------------------------------------LEVEL-5-----------------------------------//

wire [1:0][64:0] w_sum5_c,w_ca5_c,w_sum5,w_ca5;

sixtyBitAdder a11(w_sum4[0],w_sum4[1],w_ca4[0],w_sum5[0],w_ca5[0]);
sixtyBitAdder a12(w_sum4[2],w_ca4[1],w_ca4[2],w_sum5[1],w_ca5[1]);

dff_lvl_6 m6(w_sum5_c,w_ca5_c,rst,clk,w_sum5,w_ca5); //pipeline-6

// -------------------------------------LEVEL-6-----------------------------------//

wire [64:0] w_sum6_c,w_ca6_c,w_sum6,w_ca6;

sixtyBitAdder a13(w_sum5[0],w_sum5[1],w_ca5[0],w_sum6_c,w_ca6_c);

dff_lvl_7 m7(w_sum6_c,w_ca6_c,rst,clk,w_sum6,w_ca6); //pipeline-7

// -------------------------------------LEVEL-7-----------------------------------//

wire [64:0] w_sum7_c,w_ca7_c,w_sum7,w_ca7;

sixtyBitAdder a14(w_sum6,w_ca5[1],w_ca6,w_sum7_c,w_ca7_c);

dff_lvl_7 m8(w_sum7_c,w_ca7_c,rst,clk,w_sum7,w_ca7); //pipeline-8
// -------------------------------------LEVEL-8-----------------------------------//

wire [64:0] w_sum8_c,w_ca8_c,w_sum8,w_ca8;

sixtyBitAdder a15(w_sum7,w_ca3[4],w_ca7,w_sum8_c,w_ca8_c);
 
dff_lvl_7 m9(w_sum8_c,w_ca8_c,rst,clk,w_sum8,w_ca8);//pipeline-9
// -------------------------------------LEVEL-9-----------------------------------//

adder a16(c[63:0],xout,w_sum8[63:0],w_ca8[63:0],xin,clk,rst);


assign c[64]=0;

endmodule

