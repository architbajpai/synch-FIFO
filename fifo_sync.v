//	Synchronous Fifo
module fifo_sync
(input clk,rst,push,pop,	//	write-en read_en
output full,empty,
input [15:0] data_in,
output reg [15:0] data_out);

//	Memory
reg [15:0] mem[15:0];
reg flag;
//	Pointers
reg [15:0] rd_ptr,wr_ptr;

//	Combo for full and empty
assign full = (wr_ptr==rd_ptr)?(flag?1'b1:1'b0):1'b0;
assign empty = (wr_ptr==rd_ptr)?(flag?1'b0:1'b1):1'b0;

always @ (posedge clk) begin
	if(!rst) begin
		flag<=0;
		rd_ptr<=0;
		wr_ptr<=0;
	end
	else begin
		if(push) begin
			if(!full) begin
	 			mem[wr_ptr] <= data_in;
				flag <= 1'b1;
				wr_ptr <= wr_ptr + 1'b1;
			end
		end
		if(pop) begin
			if(!empty) begin
				data_out <= mem[rd_ptr];
				flag <= 1'b0;
				rd_ptr <= rd_ptr + 1'b1;
			end
		end
	end
end

endmodule
