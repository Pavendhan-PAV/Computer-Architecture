`include "Cla/kpg.v"
`include "Cla/PPC.v"

module adder(r_sum,xout,a,b,xin,clk,rst);

input [63:0] a,b; //INPUTS
input [7:0] xin;  //X0 - FIRST XIN FOR PPC (k)
input clk,rst;
input [63:0] c,d,e,f;

integer i=0;

output [64:0][7:0]x;  //K P G GENERATED FROM THE INPUTS - x1 from ai & bi
output [7:0]xout;     //FINALL
output [63:0][7:0] y; //K P G GENERATED FROM THE INPUTS - x1 from ai & bi
output reg[63:0] r_sum;

dff m1(a,b,rst,clk,c,d);  //pipeline-10

kpg_gen m_kpg_0(x[8:1],c[7:0],d[7:0]);
kpg_gen m_kpg_1(x[16:9],c[15:8],d[15:8]);
kpg_gen m_kpg_2(x[24:17],c[23:16],d[23:16]);
kpg_gen m_kpg_3(x[32:25],c[31:24],d[31:24]);

kpg_gen m_kpg_4(x[40:33],c[39:32],d[39:32]);
kpg_gen m_kpg_5(x[48:41],c[47:40],d[47:40]);
kpg_gen m_kpg_6(x[56:49],c[55:48],d[55:48]);
kpg_gen m_kpg_7(x[64:57],c[63:56],d[63:56]);

assign x[0]=xin;

ppc ppc_0(y[63:0],x[63:0],rst,clk,c,d,e,f);

always@(posedge clk)
begin
  for(i=0;i<64;i=i+1)
  begin
    if(y[i]=="k")
      r_sum[i]=(e[i]^f[i])^0;
    else
      r_sum[i]=(e[i]^f[i])^1;
  end
end

endmodule
