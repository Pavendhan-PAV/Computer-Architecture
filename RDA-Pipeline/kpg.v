module kpg(x,ai,bi);

input ai,bi; 
output reg[7:0] x;

always @(ai or bi)
	if(ai==bi)
	begin
		if(ai==0)
			x="k";
		else
			x="g";
	end
	else
		x="p";

endmodule

module kpg_gen(x,ai,bi);

input [7:0] ai,bi; 
output [7:0][7:0]x;

kpg m_kpg_0(x[0],ai[0],bi[0]);
kpg m_kpg_1(x[1],ai[1],bi[1]);
kpg m_kpg_2(x[2],ai[2],bi[2]);
kpg m_kpg_3(x[3],ai[3],bi[3]);
kpg m_kpg_4(x[4],ai[4],bi[4]);
kpg m_kpg_5(x[5],ai[5],bi[5]);
kpg m_kpg_6(x[6],ai[6],bi[6]);
kpg m_kpg_7(x[7],ai[7],bi[7]);

endmodule
