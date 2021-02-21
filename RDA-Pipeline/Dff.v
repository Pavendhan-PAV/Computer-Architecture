module dff (input [31:0]a,
            input [31:0]b,
            input rst,
            input clk,
            output reg [31:0] c,
            output reg [31:0] d);  
  
always @ (posedge clk )  
begin
   if (!rst)  
   begin
      c = 0; 
      d = 0; 
   end
   else  
   begin
      c = a;
      d = b;  
   end
end

endmodule  