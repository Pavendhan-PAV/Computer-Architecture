`include "DMC.v"

module top ();

	reg [16:0] read_addr, write_addr;
	reg [31:0] write_data;
	reg clk;
	reg read_enable, write_enable;
	wire [31:0] read_data;
	
	cache C1 (read_data, read_addr, write_addr, write_data, read_enable, write_enable, clk);

	initial begin
		
		//READ MISSS (INVALID)
		#5 read_enable = 1'b1;
		read_addr = 17'b100_1110000000_1011;
		#5 read_enable = 1'b0;
		#5$display("%d # %b: %h", $time, read_addr, read_data);

		//WRITE HIT
		#5 write_enable = 1'b1;
		write_addr = 17'b100_1110000000_1011;
		write_data = 32'h0c0c0c0c;
		#5 write_enable = 1'b0;

		//READ HIT
		#5 read_enable = 1'b1;
		read_addr = 17'b100_1110000000_1011;
		#5 read_enable = 1'b0;
		#5 $display("%d # %b: %h", $time, read_addr, read_data);

		//READ MISS  (DIRTY) - (SAME LINE DIFFERENT TAG)
		#5 read_enable = 1'b1;
		read_addr = 17'b111_1110000000_1011;
		#5 read_enable = 1'b0;
		#5 $display("%d # %b: %h", $time, read_addr, read_data);

		//READ MISS
		#5 read_enable = 1'b1;
		read_addr = 17'b100_1110000000_1011;
		#5 read_enable = 1'b0;
		#5 $display("%d # %b: %h", $time, read_addr, read_data);
		
		// WRITE MISS (DIRTY)
		#5 write_enable = 1'b1;
		write_addr = 17'b101_1110000000_1011;
		write_data = 32'h0a0a0a0a;
		#5 write_enable = 1'b0;

		//READ HIT AFTER WRITE BACK
		#5 read_enable = 1'b1;
		read_addr = 17'b101_1110000000_1011;
		#5 read_enable = 1'b0;
		#5 $display("%d # %b: %h", $time, read_addr, read_data);
		
	

		#10 $finish;
	end

	initial begin
		clk = 0;
		forever begin
			#1 clk = ~clk;
		end
	end
	// initial begin
	// 	$monitor("%d # %b: %d", $time, read_addr, read_data);
	// end

endmodule
