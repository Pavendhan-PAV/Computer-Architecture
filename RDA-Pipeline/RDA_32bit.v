`include "kpg.v"
`include "Dff.v"
`include "PPC.v"

module adder(r_sum,xout,a,b,xin,clk,rst);

input clk,rst;
input [31:0] a,b; //INPUTS
input[7:0] xin;   //X0 - FIRST XIN FOR PPC (k)

output [32:0][7:0]x; //K P G GENERATED FROM THE INPUTS - x1 from ai & bi
output [7:0]xout;    //FINALL
output [31:0][7:0] y; c
output reg[31:0] r_sum;

input [31:0] c,d,e,f;

dff m1(a,b,rst,clk,c,d); 

kpg_gen m_kpg_0(x[8:1],c[7:0],d[7:0]);
kpg_gen m_kpg_1(x[16:9],c[15:8],d[15:8]);
kpg_gen m_kpg_2(x[24:17],c[23:16],d[23:16]);
kpg_gen m_kpg_3(x[32:25],c[31:24],d[31:24]);

assign x[0]=xin;

ppc m_ppc_0(y[31:0],x[31:0],rst,clk,c,d,e,f);

integer i=0;

always@(posedge clk)
begin
	for(i=0;i<32;i=i+1)
	begin
	if(y[i]=="k")
		r_sum[i]=(e[i]^f[i])^0;
	else
		r_sum[i]=(e[i]^f[i])^1;
	end
end

endmodule



