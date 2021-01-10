module ppc(y,x);

input [31:0][7:0]x;

output reg [31:0][7:0] y ;

integer j=0;
integer i,n=32;




always@(*)

begin//always begin
	
	for(i=0;i<n;i++)
	begin
	y[i]=x[i];
	end//for1 loop end

	for(j=0;j<5;j+=1)
	begin
		for(i=31;(i-2**j)>=0;i=i-1)
		begin//for2 begin
			if(y[i]=="k")//case 1
			begin
			y[i]="k";
			end
		
			else if(y[i]=="p") //case 2
			begin
				if(y[i-2**j]=="k")
				y[i]="k";
			
				else if(y[i-2**j]=="p")
				y[i]="p";
		
				else
				y[i]="g";
			end

			else //case 3
			begin
				y[i]="g";
			end
		end//for2 end
	end
	
end//always end

endmodule
