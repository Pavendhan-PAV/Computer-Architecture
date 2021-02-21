`include "Cla/Levels.v"
`include "Cla/Dff.v"

module ppc(y,x,rst,clk,a,b,c,d);

input [63:0][7:0]x;
input [63:0] a,b;
input rst,clk;

wire [63:0][7:0]reg1,reg2,reg3,reg4,reg5,reg6;
wire [63:0] w_6,w_7,w_8,w_9,w_10,w_11,w_12,w_13,w_14,w_15,w_16,w_17; // WIRES FOR INPUTS A,B TO DFF
wire [63:0][7:0] w_1,w_2,w_3,w_4,w_5,w_18; //WIRES FOR K P G 

output [63:0][7:0] y;
output [63:0] c,d;


dff_lvl m_c1(x,rst,clk,reg1,w_6,w_7,a,b); //pipeline-11
lvl m_m1(w_1,reg1,3'd0);

dff_lvl m_c2(w_1,rst,clk,reg2,w_8,w_9,w_6,w_7); //pipeline-12
lvl m_m2(w_2,reg2,3'd1);

dff_lvl m_c3(w_2,rst,clk,reg3,w_10,w_11,w_8,w_9); //pipeline-13
lvl m_m3(w_3,reg3,3'd2);

dff_lvl m_c4(w_3,rst,clk,reg4,w_12,w_13,w_10,w_11); //pipeline-14
lvl m_m4(w_4,reg4,3'd3);

dff_lvl m_c5(w_4,rst,clk,reg5,w_14,w_15,w_12,w_13); //pipeline-15
lvl m_m5(w_5,reg5,3'd4);

dff_lvl m_c6(w_5,rst,clk,reg6,w_16,w_17,w_14,w_15); //pipeline-16
lvl m_m6(w_18,reg6,3'd5);

dff_lvl m_c7(w_18,rst,clk,y,c,d,w_16,w_17); //pipeline-17

endmodule