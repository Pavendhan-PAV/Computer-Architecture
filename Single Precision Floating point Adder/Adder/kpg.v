module kpg(out,ai,bi);

input ai,bi;
output reg[7:0] out;

always @(ai or bi)

if(ai==bi)

begin
	if(ai==0)
	out="k";

	else
	out="g";
end

else
	out="p";

endmodule
