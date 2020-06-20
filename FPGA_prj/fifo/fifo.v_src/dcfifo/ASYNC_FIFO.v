module ASYNC_FIFO #( parameter FIFO_WITH  = 8 ,
					 parameter FIFO_DEPTH = 8 ,
					 parameter SHOW_AHAEAD = "OFF",
					 parameter MEM_TYPE    = "BLOCK"
					)
(
		input clk_wr,
		input rst_wr,
		input wr_en,
		input [FIFO_WITH-1:0] wr_data,
		output  fifo_full_wr,

		input clk_rd,
		input rst_rd,
		input rd_en,
		output  [FIFO_WITH-1:0] rd_data,
		output  fifo_empty_rd
);
function integer clog2;
	input [31:0] v;
	reg [31:0] value;
	begin
		value = v;
		if (value == 1) begin
			clog2 = 0;
		end
		else begin
			value = value-1;
			for (clog2=0; value>0; clog2=clog2+1)
				value = value>>1;
		end
	end
endfunction

// Local parameters
localparam POW2_DEPTH  = 2**clog2(FIFO_DEPTH);
localparam DEPTH_WIDTH = clog2(POW2_DEPTH);


wire wr_full ;
wire [DEPTH_WIDTH-1:0] wr_addr; 
wire [DEPTH_WIDTH-1:0] rd_addr; 
wire rd_empty ;
wire [DEPTH_WIDTH:0]  wr_gray ;
wire [DEPTH_WIDTH:0]  rd_gray_sync_wr ;
wire [DEPTH_WIDTH:0]  rd_gray ;
wire [DEPTH_WIDTH:0]  wr_gray_sync_rd ;
assign  fifo_full_wr  = wr_full;
assign  fifo_empty_rd = rd_empty ;


mem #( 
		.DATA_SIZE (FIFO_WITH),
		.ADDR_SIZE (DEPTH_WIDTH),
		.SHOW_AHAEAD(SHOW_AHAEAD),
		.MEM_TYPE   (MEM_TYPE)
	)
U_mem(
		.clk_wr (clk_wr),
		.wr_en  (wr_en & ~wr_full),
		.wr_addr(wr_addr),
		.wr_data(wr_data),

		.clk_rd (clk_rd),
		.rd_en  (rd_en & ~rd_empty),
		.rd_addr(rd_addr),
		.rd_data(rd_data)
	);



wptr_full #(
			.PTR_WITH(DEPTH_WIDTH)
			)
U_wptr_full(
		.clk_wr (clk_wr),
		.rst_wr (rst_wr),
		.wr_en  (wr_en),

		.wr_addr(wr_addr),
		.wr_gray(wr_gray),
		.rd_gray_sync_wr(rd_gray_sync_wr),
		.wr_full(wr_full)
	);

rptr_empty #(
			.PTR_WITH(DEPTH_WIDTH)
			)
U_rptr_empty(
		.clk_rd (clk_rd),
		.rst_rd (rst_rd),
		.rd_en  (rd_en),

		.rd_addr(rd_addr),
		.rd_gray(rd_gray),
		.wr_gray_sync_rd(wr_gray_sync_rd),
		.rd_empty(rd_empty)
	);

sync_ptr #(
			.PTR_WITH(DEPTH_WIDTH)
			)
 U_sync_ptr_wr(
		//.clk_in(clk_wr),
		//.rst_in(rst_wr),
		.ptr_in(wr_gray),

		.clk_out(clk_rd),
		.rst_out(rst_rd),
		.ptr_out(wr_gray_sync_rd)
	);


sync_ptr #(
			.PTR_WITH(DEPTH_WIDTH)
			)
U_sync_ptr_rd(
		//.clk_in(clk_rd),
		//.rst_in(rst_rd),
		.ptr_in(rd_gray),

		.clk_out(clk_wr),
		.rst_out(rst_wr),
		.ptr_out(rd_gray_sync_wr)
	);
endmodule 