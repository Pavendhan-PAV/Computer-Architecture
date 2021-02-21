`include "Levels.v"

module dff_lvl (input [31:0][7:0]d,
               input rst,
               input clk,
               output reg [31:0][7:0] r_q,
               output reg[31:0] r_wr1,
               output reg[31:0] r_wr2,
               input [31:0]a,
               input [31:0]b);

always@(posedge clk )  
   if (!rst)  
   begin
      r_q <= 0;
      r_wr1<=0;
      r_wr2<=0;  
   end
   
   else  
   begin
      r_q <= d;  
      r_wr1<=a;
      r_wr2<=b;
   end

endmodule  

module ppc(y,x,rst,clk,a,b,c,d);

input [31:0][7:0]x;
input [31:0] a,b;
input rst,clk;

wire [31:0][7:0]reg1,reg2,reg3,reg4,reg5;
wire[31:0] w_6,w_7,w_8,w_9,w_10,w_11,w_12,w_13,w_14,w_15; // WIRES FOR INPUTS A,B TO DFF
wire [31:0][7:0] w_1,w_2,w_3,w_4,w_5 ; //WIRES FOR K P G 

output  [31:0][7:0] y;
output [31:0] c,d;

dff_lvl m_c1(x,rst,clk,reg1,w_6,w_7,a,b); //pipeline-2
lvl m_m1(w_1,reg1,3'd0);

dff_lvl m_c2(w_1,rst,clk,reg2,w_8,w_9,w_6,w_7); //pipeline-3
lvl m_m2(w_2,reg2,3'd1);

dff_lvl m_c3(w_2,rst,clk,reg3,w_10,w_11,w_8,w_9); //pipeline-4
lvl m_m3(w_3,reg3,3'd2);

dff_lvl m_c4(w_3,rst,clk,reg4,w_12,w_13,w_10,w_11); //pipeline-5
lvl m_m4(w_4,reg4,3'd3);

dff_lvl m_c5(w_4,rst,clk,reg5,w_14,w_15,w_12,w_13); //pipeline-6
lvl m_m5(w_5,reg5,3'd4);

dff_lvl m_c6(w_5,rst,clk,y,c,d,w_14,w_15); //pipeline-7

endmodule
