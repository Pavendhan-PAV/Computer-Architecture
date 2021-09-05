`include "getval.v"
`include "bs.v"
`include "WALLACE/32wallace.v"
`include "Levels.v"

module fpm(
    input [32:1] a,
    input [32:1] b,
    input clk,
    input rst,
    output  [32:1] c
    );

output wire [33:1] w_MAN_a,w_MAN_a2;        //to store mantissa value of a
output wire [33:1] w_MAN_b,w_MAN_b2;        //to store mantissa value of b
 
wire [8:1] exp_a,exp_b,exp_a2,exp_b2;       //to store exp value of a,b and to store difference of exp of a exp of b
wire [32:1] a1,b1,a2,b2,a3,b3;      

wire sign_a,sign_b,sign_a2,sign_b2;         //to store sign value of a and b
reg sign_c;
wire sign_c3;                               //to store sign value of c

reg [9:1] r_EXP_c;
wire [9:1] w_EXP_c3;                        //to store product of a mantissa of a and b
wire [9:1] w_EXP_cs;
wire [9:1] w_EXP_cs2;

wire [65:1] w_MAN_c;                        //to store mantissa value of c
wire [65:1] w_MAN_cs;

assign w_MAN_a[33]=1'b0;
assign w_MAN_b[33]=1'b0;

integer i;

//1 - module gets two numbers as input and stores the mantissa, exp and sign of resp nos
dff_lvl_p1 p1(a,b,rst,clk,a1,b1);
getval m0(a1,b1,w_MAN_a[32:1],w_MAN_b[32:1],exp_a,exp_b,sign_a,sign_b);           

//2
dff_lvl_p2 p2(a1,b1,w_MAN_a,w_MAN_b,exp_a,exp_b,sign_a,sign_b,rst,clk,a2,b2,w_MAN_a2,w_MAN_b2,exp_a2,exp_b2,sign_a2,sign_b2);

always@(posedge clk)
begin
    sign_c=sign_a2^sign_b2;
    r_EXP_c=exp_a2+exp_b2-127;
end

//module multiplies mantissa of a and b
wallace m1(w_MAN_c,w_MAN_a2,w_MAN_b2,a2,b2,r_EXP_c,sign_c,clk,rst ,a3,b3,w_EXP_c3,sign_c3 );                                              

    mux22 m2(w_MAN_c[48],w_EXP_c3,w_EXP_cs);            //increment exp if 48th bit is set to 1
    mux21 m3(w_EXP_cs,a3,b3,w_EXP_cs2);                 //if exponent is greater than 255 or 255 ,exp will be set to 255
    mux23 m4(w_MAN_c,a3,b3,w_MAN_cs);                   //to handle special cases like nan or infinity (mantissa)
    mux24 m5(w_MAN_c[48],w_MAN_cs,w_EXP_cs2,a3,b3,c);   //to handle a special case where either of the input is zero


assign c[32]=sign_c3;

endmodule


module top;

reg [32:1] Exp1,Exp2;
reg clk,rst;

wire [32:1] c;
integer i;

fpm f1(Exp1,Exp2,clk,rst,c);


initial
begin

    #0 Exp1={9'b010000000,{23{1'b0}}}; Exp2={9'b010000001,{23{1'b0}}};                          //2*4 @36
    #10 Exp1=32'b01000010111110100100000000000000; Exp2=32'b01000001010000010000000000000000;   //125.125*12.0625  @46
    #10 Exp1=32'b01000000110010000000000000000000; Exp2=32'b01000000101111100110011001100110;   // 6.25*5.95  @56 
    
    //Special cases
    
    //adding two inf
    //#10 Exp1=32'b01111111000000000000000000000000;   Exp2=32'b01111111000000000000000000000000;    //inf *inf
    
    //adding nan
    //#10 Exp1=32'b01111111111111111111111111111111;  Exp2=32'b01111111111111111110001111111111;  //naN *nan
    
    //adding zero
    //#15 Exp1=32'b00000000000000000000000000000000;  Exp2=32'b10000000000000000000000000000000;  //zero - zero

end

initial
begin
    clk=1;
    rst=0;
    rst=1;
    for (i=0;i<150;i++)
        #1 clk=~clk;
end

initial
    $monitor($time,"    Input:\t\tA: %b\tB: %b\n\t\t\tOutput:\t\tC: %b\n",Exp1,Exp2,c);

endmodule