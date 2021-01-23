module regfile( input[31:0] in,
                input[4:0] o1_addr,
                input[4:0] o2_addr,
                input[4:0] in_addr,
                input read,
                input write,
                output reg[31:0] o1,
                output reg[31:0] o2 );

    reg [31:0] regFile[31:0];
    integer i;

    initial 
    begin
        for(i=0;i<32;i=i+1)
            regFile[i]=32'h0000_0000;  //initially the register file is set to empty and is executed only once
    end

    always@(read or write or in) 
    begin
        if(read==1'b1)
        begin
            o1=regFile[o1_addr]; //read using the output_1 address
            o2=regFile[o2_addr]; //read using the output_2 address
        end
    
        if(write==1'b1)
        begin
           regFile[in_addr]=in; //write given input "in" in "in_addr" address 
        end
    end
endmodule

module top;
    reg [31:0] in;
    reg [4:0]  o1_addr,o2_addr,in_addr;
    reg read,write;
    wire [31:0] w_o1,w_o2;

    regfile m_rf_1(in,o1_addr,o2_addr,in_addr,read,write,w_o1,w_o2);

    initial
    begin
        #0 in=32'd111111; in_addr=5'd30; read=1'b0; 
        o1_addr=5'd30; o2_addr=5'd10; write=1'b0; 
    
        #1 write=1'b1; 
        #2 in_addr=5'd10; in=32'd9999999;
        #3 read=1'b1;
    end

    initial
    begin
        $monitor("\nREAD---\nRead: %b\nOutput_Addr1: %0d\tOutput_Addr2: %0d\nOutput1: %0d\t\tOutput2: %0d\n\nWRITE---\nWrite: %0d\nInput_addr: %0d\t\tInput: %0d\n\n-------------------------------",read,o1_addr,o2_addr,w_o1,w_o2,write,in_addr,in);
    end
endmodule