module FullAdder(A,B,Cin, Sum);
	input A,B, Cin;
	output Sum;
	assign Sum= A^B^Cin;
	
endmodule
