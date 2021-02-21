/*
									******************************************NOTE******************************************

1)The test bench Clock-Input will change its value every 1 second => 1clock cycle is 2 seconds
2)Wallace has 9 stages and the last stage is cla which has 6 stage in parallel prefix circuit and one stage for input into cla and one stage for output 
	=> Total 17 stages 
3)The first input in test bench is given at 0sec and the output is visible at 34 and for every input change after 5 seconds 
	the correct output will be 6 seconds after the previous correct output  
	
									****************************************************************************************
*/

`include "Wallace_32bit.v"

module top;
reg  signed [32:0]a,b;
integer i;
wire signed [64:0] c;
reg clk,rst;

wallace w_0(c,a,b,clk,rst);

initial
begin

#0  a=19; b=15;
#5  a=200; b=400;
//#10  a=32'hffff_ff3a; b=32'hff3a_ffff;
//#5  a=25983; b=641987;
//#10  a=32'habcd_ef3a; b=32'habca_ffff;
end

initial
begin
	clk=1;
	rst=0;
	rst=1;

	for (i=0;i<60;i++)
		#1 clk=~clk;
end

initial
 	$monitor("\n",$time," 	Multiplier: %0d		Multiplicand: %0d;\n\t\t\tOUTPUT----\n\t\t\tExponential form(e): %e\n\t\t\tDecimal form(D)    : %0d\n",a,b,c,c);
endmodule
