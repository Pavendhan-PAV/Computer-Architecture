module dff_lvl (input [63:0][7:0]d,
               input rst,input clk,
               output reg [63:0][7:0] r_q,
               output reg[63:0] r_wire1,
               output reg[63:0] r_wire2,
               input [63:0]a,
               input [63:0]b);  
  
always@(posedge clk )  
   if (!rst)  
   begin
      r_q <= 0;
      r_wire1<=0;
      r_wire2<=0;  
   end
   else  
   begin
      r_q <= d;  
      r_wire1<=a;
      r_wire2<=b;
   end

endmodule  

module dff  (input [63:0]a,
            input [63:0]b,
            input rst,
            input clk,
            output reg [63:0] c,
            output reg [63:0] d);  
  
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