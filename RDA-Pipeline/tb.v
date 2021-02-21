`include "RDA_32bit.v"

module top;

reg signed [31:0]r_ai,r_bi;
reg [7:0] r_xin;
reg clk,rst;

wire signed [31:0]si;
wire[7:0]xout;

adder ad_0(si,xout,r_ai,r_bi,r_xin,clk,rst);

integer i;

initial
begin
	#0 r_xin="k"; r_ai=-10; r_bi=10;
	#7 r_xin="k"; r_ai=352; r_bi=18;
	#7 r_xin="k"; r_ai=4; r_bi=10;
end

initial
begin
	clk=1;
	rst=0;
	rst=1;
	
	for (i=0;i<30;i++)
		#1 clk=~clk;
end

initial begin
 	$monitor($time,"\tNumber1: %0d\tNumber2: %0d; \tSum: %0d",r_ai,r_bi,si);
end
endmodule