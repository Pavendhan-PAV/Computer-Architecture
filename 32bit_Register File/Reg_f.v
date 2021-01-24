module regfile( input[31:0] in,
                input[4:0] o1_addr,
                input[4:0] o2_addr,
                input[4:0] in_addr,
                input read,
                input write,
                output reg[31:0] o1,
                output reg[31:0] o2,
                input clk,
                input reset,
                input enable );

    reg [31:0] regFile[31:0];
    integer i;

    //always@(read or write or in) 
    always@(posedge clk)
    begin
        if(reset==1'b0)
        begin
            for(i=0;i<32;i=i+1)
                regFile[i]=32'h0000_0000;  
        end
        if(enable==1'b1)
        begin
            if(reset==1'b1)
            begin
                if(read==1'b1)
                begin
                    o1=regFile[o1_addr]; //read using the output_1 address
                    o2=regFile[o2_addr]; //read using the output_2 address
                end //read
            end //reset
            
            if(write==1'b1)
            begin
                regFile[in_addr]=in; //write given input "in" in "in_addr" address 
            end
        end //enable
    end //always
endmodule

module top;
    reg [31:0] in;
    reg [4:0]  o1_addr,o2_addr,in_addr;
    reg read,write,reset,enable;
    wire [31:0] w_o1,w_o2;
    reg clk;

    regfile m_rf_1(in,o1_addr,o2_addr,in_addr,read,write,w_o1,w_o2,clk,reset,enable);

    always #1 clk = !clk;

    initial
    begin
        clk =0; reset=1'b0; enable=1'b0;
        #1  reset=1'b1; enable=1'b1;    in=32'd111111; in_addr=5'd30; read=1'b0; o1_addr=5'd30; o2_addr=5'd10; write=1'b0; 

        #2 write=1'b1; 
        #2 in_addr=5'd10; in=32'd9999999;
        #2 read=1'b1;

        #15 $finish;
    end

    initial
    begin
        $monitor("\nENABLE: %b\tRESET: %b\nREAD: %b\nOutput_Addr1: %0d\tOutput_Addr2: %0d\nOutput1: %0d\t\tOutput2: %0d\n\nWRITE: %0d\nInput_addr: %0d\t\tInput: %0d\n\n-------------------------------",enable,reset,read,o1_addr,o2_addr,w_o1,w_o2,write,in_addr,in);
    end
endmodule