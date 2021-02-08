/*
		**DIRECT MAPPED CACHE WITH WRITE BACK**

				BLOCKS	WORDS	WORD SIZE	INDEX
MAIN MEMORY 	8192	16		32			13 (Block index (BI))
CACHE MEMORY	1024	16		32			10 (Cache index (CI))

TAG = Block index - Cache index = 3 bits
BLOCK OFFSET (BO) = bits for no. of blocks (16) = 4 bits
VALID (V): 1 bit
DIRTY (D): 1 bit

PHYSICAL ADDRESS: { BI(13) BO(4) } = 17 bits
LOGICAL ADDRESS : { V(1) D(1) TAG(3) CI(10) BO(4) } = 19 bits

*/

module cache (
	output reg [31:0] read_data,
	input [16:0] read_addr,
	input [16:0] write_addr,
	input [31:0] write_data,
	input read_enable,
	input write_enable,
	input clk
);
	//DECLARATIONS
	reg [31:0] r_main_memory [8191:0][15:0];
	reg [31:0] r_cache [1023:0][15:0];
	reg [2:0] r_cache_tags [1023:0];
	reg r_valid [1023:0];	// 0 => invalid, 1 => valid 
	reg r_dirty [1023:0];	// 0 => not dirty, 1 => dirty

	//READING DETAILS
	wire [2:0] w_tag_r;
	wire [9:0] w_line_r; //cache index
	wire [3:0] w_block_offset_r;

	//WRITING DETAILS
	wire [2:0] w_tag_w;
	wire [9:0] w_line_w; //cache index
	wire [3:0] w_block_offset_w;

	integer i, j;

	assign w_tag_r = read_addr[16:14];
	assign w_line_r = read_addr[13:4];
	assign w_block_offset_r = read_addr[3:0];

	assign w_tag_w = write_addr[16:14];
	assign w_line_w = write_addr[13:4];
	assign w_block_offset_w = write_addr[3:0];

	//	INTIALISATION OF VALUES IN MAIN MEMORY
	initial 
	begin
		for (i = 0; i < 8192; i = i + 1) 
		begin
			for (j = 0; j < 16; j = j + 1) 
			begin
				r_main_memory[i][j] = j;
			end
		end
		
		// Initially all tags are invalid
		for (i = 0; i < 1024; i = i + 1) 
		begin
			r_valid[i] = 0;
			r_dirty[i] = 0;
		end
	end
	
		
	always @(posedge clk) 
	begin
		if (read_enable) 
		begin

			if (r_cache_tags[w_line_r] == w_tag_r && r_valid[w_line_r] == 1'b1) 
			begin
				$monitor("%d # Hit: Reading", $time);
				read_data = r_cache[w_line_r][w_block_offset_r];
			end 
			
			// READ MISS - Replace with correct data
			else 
			begin
				$display("%d # Read Miss", $time);
				// check if line is DIRTY
				if (r_dirty[w_line_w] == 1'b1) 
				begin
					// write cache line to memory block (cache line is modified)
					$display("%d # Dirty line", $time);
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][0] = r_cache[w_line_r][0];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][1] = r_cache[w_line_r][1];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][2] = r_cache[w_line_r][2];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][3] = r_cache[w_line_r][3];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][4] = r_cache[w_line_r][4];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][5] = r_cache[w_line_r][5];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][6] = r_cache[w_line_r][6];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][7] = r_cache[w_line_r][7];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][8] = r_cache[w_line_r][8];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][9] = r_cache[w_line_r][9];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][10] = r_cache[w_line_r][10];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][11] = r_cache[w_line_r][11];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][12] = r_cache[w_line_r][12];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][13] = r_cache[w_line_r][13];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][14] = r_cache[w_line_r][14];
					r_main_memory[{r_cache_tags[w_line_r], w_line_r}][15] = r_cache[w_line_r][15];
					r_dirty[w_line_r] = 1'b0;
				end

				else 
				begin
					// bring correct block to cache
					$display("%d # Bringing Main Memory Block to cache", $time);
					r_cache[w_line_r][0] = r_main_memory[{w_tag_r, w_line_r}][0];
					r_cache[w_line_r][1] = r_main_memory[{w_tag_r, w_line_r}][1];
					r_cache[w_line_r][2] = r_main_memory[{w_tag_r, w_line_r}][2];
					r_cache[w_line_r][3] = r_main_memory[{w_tag_r, w_line_r}][3];
					r_cache[w_line_r][4] = r_main_memory[{w_tag_r, w_line_r}][4];
					r_cache[w_line_r][5] = r_main_memory[{w_tag_r, w_line_r}][5];
					r_cache[w_line_r][6] = r_main_memory[{w_tag_r, w_line_r}][6];
					r_cache[w_line_r][7] = r_main_memory[{w_tag_r, w_line_r}][7];
					r_cache[w_line_r][8] = r_main_memory[{w_tag_r, w_line_r}][8];
					r_cache[w_line_r][9] = r_main_memory[{w_tag_r, w_line_r}][9];
					r_cache[w_line_r][10] = r_main_memory[{w_tag_r, w_line_r}][10];
					r_cache[w_line_r][11] = r_main_memory[{w_tag_r, w_line_r}][11];
					r_cache[w_line_r][12] = r_main_memory[{w_tag_r, w_line_r}][12];
					r_cache[w_line_r][13] = r_main_memory[{w_tag_r, w_line_r}][13];
					r_cache[w_line_r][14] = r_main_memory[{w_tag_r, w_line_r}][14];
					r_cache[w_line_r][15] = r_main_memory[{w_tag_r, w_line_r}][15];				
					r_valid[w_line_r] = 1'b1;
					r_cache_tags[w_line_r] = w_tag_r;
				end
			end
		end

		if (write_enable) 
		begin
			// check if block is in cache and is valid
			if (r_cache_tags[w_line_w] == w_tag_w && r_valid[w_line_w] == 1'b1) 
			begin
				$display("%d # Hit: Writing", $time);
				r_cache[w_line_w][w_block_offset_w] = write_data;
				r_dirty[w_line_w] = 1'b1;
			end

			// replace with correct line 
			else 
			begin
				$display("%d # Write Miss", $time);
				// check if line is dirty
				if (r_dirty[w_line_w] == 1'b1) 
				begin
					// write cache line to memory block
					$display("%d # Dirty line", $time);
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][0] = r_cache[w_line_w][0];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][1] = r_cache[w_line_w][1];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][2] = r_cache[w_line_w][2];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][3] = r_cache[w_line_w][3];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][4] = r_cache[w_line_w][4];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][5] = r_cache[w_line_w][5];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][6] = r_cache[w_line_w][6];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][7] = r_cache[w_line_w][7];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][8] = r_cache[w_line_w][8];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][9] = r_cache[w_line_w][9];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][10] = r_cache[w_line_w][10];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][11] = r_cache[w_line_w][11];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][12] = r_cache[w_line_w][12];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][13] = r_cache[w_line_w][13];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][14] = r_cache[w_line_w][14];
					r_main_memory[{r_cache_tags[w_line_w], w_line_w}][15] = r_cache[w_line_w][15];
					r_dirty[w_line_w] = 1'b0;
				end
				
				else 
				begin
					// bring correct block to cache
					$display("%d # Bringing Main Memory Block to cache", $time);
					r_cache[w_line_w][0] = r_main_memory[{w_tag_w, w_line_w}][0];
					r_cache[w_line_w][1] = r_main_memory[{w_tag_w, w_line_w}][1];
					r_cache[w_line_w][2] = r_main_memory[{w_tag_w, w_line_w}][2];
					r_cache[w_line_w][3] = r_main_memory[{w_tag_w, w_line_w}][3];
					r_cache[w_line_w][4] = r_main_memory[{w_tag_w, w_line_w}][4];
					r_cache[w_line_w][5] = r_main_memory[{w_tag_w, w_line_w}][5];
					r_cache[w_line_w][6] = r_main_memory[{w_tag_w, w_line_w}][6];
					r_cache[w_line_w][7] = r_main_memory[{w_tag_w, w_line_w}][7];
					r_cache[w_line_w][8] = r_main_memory[{w_tag_w, w_line_w}][8];
					r_cache[w_line_w][9] = r_main_memory[{w_tag_w, w_line_w}][9];
					r_cache[w_line_w][10] = r_main_memory[{w_tag_w, w_line_w}][10];
					r_cache[w_line_w][11] = r_main_memory[{w_tag_w, w_line_w}][11];
					r_cache[w_line_w][12] = r_main_memory[{w_tag_w, w_line_w}][12];
					r_cache[w_line_w][13] = r_main_memory[{w_tag_w, w_line_w}][13];
					r_cache[w_line_w][14] = r_main_memory[{w_tag_w, w_line_w}][14];
					r_cache[w_line_w][15] = r_main_memory[{w_tag_w, w_line_w}][15];				
					r_valid[w_line_w] = 1'b1;
					r_cache_tags[w_line_w] = w_tag_w;
				end
			end
		end
	end

endmodule