
module Check(input [31:0]Exp1, input [31:0]Exp2, output reg [31:0]Big, output reg [31:0]Small);

    always @(Exp1 or Exp2)
    begin
        if(Exp2[30:0]>Exp1[30:0])
        begin
            Small = Exp1;
            Big = Exp2;
        end
        else
        begin
            Big = Exp1;
            Small = Exp2;
        end
    end

endmodule