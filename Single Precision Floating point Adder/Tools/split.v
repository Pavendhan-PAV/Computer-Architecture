module Split(input [31:0]Exp, output sign, output [7:0]exp, output [22:0]man);
    assign sign = Exp[31];
    assign exp = Exp [30:23];
    assign man = Exp[22:0];
endmodule