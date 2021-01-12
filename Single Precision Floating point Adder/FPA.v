`include "Tools/check.v"
`include "Tools/shift.v"
`include "Adder/32bit_RDA.v"
`include "Tools/split.v"

//LINK FOR CONVERSION -- https://www.h-schmidt.net/FloatConverter/IEEE754.html

module top;

    reg [31:0] Exp1,Exp2;
    wire [31:0]Big,Small;

    //----------------------------------------------------------------------------------SWAP
    Check c(Exp1,Exp2,Big,Small); //SORT BIGGER AND SMALLER EXPRESSIONS

    wire S1,S2;         //SIGNS
    wire [7:0] E1,E2;   //EXPONENTS
    wire [22:0] M1,M2;  //MANTISSA

    //----------------------------------------------------------------------------------SPLIT
    Split SP1(Big,S1,E1,M1);
    Split SP2(Small,S2,E2,M2);

    //----------------------------------------------------------------------------------DIFFERENCE
    wire  [7:0]Ediff;
    reg [7:0]Final_Ediff; //EXP_DIFFERENCE
    assign Ediff = E1 - E2;

    
    always@(*)
    begin
        if(Ediff>32'd24)
        begin
		    Final_Ediff=32'd24;
        end
        else
        begin
            Final_Ediff=Ediff;
        end
    end

    //----------------------------------------------------------------------------------DENORMALISE
    wire [31:0] N1,N2,N3;   //TEMPORARY VAR
    assign N1 = {|E1,M1};   //Reduction for handle zeroes
    assign N2 = {|E2,M2};   //and denormal numbers
    assign N3[31:24] = {8'b0};
    
    //Shift S(N2,Ediff,N3);                                         //NORMAL RIGHT LOGICAL SHIFT    
    barrel_logicalRight Br(N2[23:0],Final_Ediff[4:0],N3[23:0]);     //BARREL RIGHT LOGICAL SHIFT

    wire [31:0] N4; 
    reg [31:0]N5; //FINAL SMALLER number

    assign N4 = {32{S1^S2}}^N3; //1s COMPLEMENT if signs are different
    
    //----------------------------------------------------------------------------------SUM/SUBTRACTION
    wire [31:0]Sum;
	always@(*)
	begin
		if(S1^S2 == 0)	
			N5=N4;
        else
            N5= N4+ 1;
	end
    adder a1(Sum,N1,N5);

    //-----------------------------------------------------------------------------------NORMALISE
	reg [22:0] M3,Temp_Mantissa;
    wire [22:0] Temp_M3;
    reg [7:0] E3;

    integer i =0;
    barrel_logicalLeft Bl(Temp_Mantissa,i[4:0],Temp_M3);
   
    /*
    always@(*)
    begin
            $display("M3: \n%b  %d\n",Temp_M3,i);
    end
    */

    always @(Sum or Temp_M3)
    begin
        if(Sum[24]==1)      //OVERFLOW
        begin
            M3[22:0] = Sum[23:1];
            E3 = E1 + 1'b1;
        end

        else if(Sum[23]==0) //UNDERFLOW
        begin
            i = 1;
            while(Sum[23-i] == 1'b0)
            begin
                i = i+1;
            end 
            E3 = E1 - i;
            Temp_Mantissa = Sum[22:0];
            //M3 = Temp_Mantissa<<i;    //DIRECT LEFT LOGICAL SHIFT
            M3=Temp_M3;                 //BARREL LEFT LOGICAL SHIFT
        end

        else    //NORMAL CASE
        begin   
            M3 = Sum[22:0];
            E3 = E1;
        end
    end

    reg [31:0]Final_exp;
    always @ (E3 or M3)
    begin
        if(&E1 == 1'b1 && |M1 == 1'b0)  //INFINITY case
            Final_exp = {S1,{8{1'b1}},23'b0};
   
        else //NORMAL & NAN cases
            Final_exp = {S1,{8{|Sum}} & E3,M3};
    end

	//---------------------------------------------------------------------------------------------TESTBENCH
    initial
    begin
        #0	Exp1={1'b0,{8{1'b1}},23'b0}; Exp2={1'b0,{7{1'b1}},24'b111011};
        #10 Exp1={9'b010000000,{23{1'b0}}}; Exp2={9'b010000001,{23{1'b0}}};
        #20 Exp1=32'b00111111110011001100110011001101; Exp2=32'b10111111100110011001100110011010;
        
    end
    initial
    begin
        $monitor($time, " Big: %b   Small: %b   SUM: %b\n",Big,Small,Final_exp);
    end

endmodule