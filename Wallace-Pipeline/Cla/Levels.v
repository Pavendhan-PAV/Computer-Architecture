module lvl(r_y,x,k);

input [63:0][7:0]x;
input [2:0] k;
output reg [63:0][7:0] r_y;
integer i=0,j=0;

always@(*)
begin
	j<=k;
	for(i=0;i<64;i=i+1)
	begin
		r_y[i]=x[i];
	end
	for(i=63;(i-2**j)>=0;i=i-1) //loop will run for 6 levels
	begin
		if(r_y[i]=="k")
		begin
		r_y[i]="k";
		end

		else if(r_y[i]=="p")
		begin
			if(r_y[i-2**j]=="k")
				r_y[i]="k";
			else if(r_y[i-2**j]=="p")
				r_y[i]="p";
			else
				r_y[i]="g";
		end
		
		else 
		begin
			r_y[i]="g";
		end
	end
end

endmodule