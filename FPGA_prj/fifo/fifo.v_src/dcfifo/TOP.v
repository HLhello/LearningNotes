// **************************************************************
// ------------------------------------------------------------------------------------------------------
module TOP (
		input sys_clk0_p ,//200M
		input sys_clk0_n ,

		input sys_clk1_p ,//100M
		input sys_clk1_n ,

		input rst_n,
		
		input wr_en,
		input [7:0] wr_data,
		output  fifo_full_wr,

		input rd_en,
		output  [7:0] rd_data,
		output  fifo_empty_rd
	);

IBUFDS #
   (
    .DIFF_TERM    ("FALSE"),
    .IBUF_LOW_PWR ("FALSE")
    )
   IBUFDS_sys_clk0
     (
      .I  (sys_clk0_p),            //差分时钟的正端输入，需要和顶层模块的端口直接连接
      .IB (sys_clk0_n),            // 差分时钟的负端输入，需要和顶层模块的端口直接连接
      .O  (sys_clk0)                //时钟缓冲输出
      );

BUFG BUFG_sys_clk0 (
    .I     (sys_clk0),
    .O     (sys_clk0_o)
);

IBUFDS_GTE2 IBUFDS_GTE2_sys_clk1 (
    .O(sys_clk1), 
    .ODIV2(), 
    .I(sys_clk1_p), 
    .CEB(1'b0), 
    .IB(sys_clk1_n)
);

BUFG BUFG_sys_clk1 (
    .I     (sys_clk1),
    .O     (sys_clk1_o)
);

clk_wiz_0 U_clk_wiz_0
(
.clk_out1(clk_wr),       // output clk_out1 100M
.reset(~rst_n), 		 // input reset
.locked(clk_wr_en),       // output locked
.clk_in1(sys_clk0_o));      // input clk_in1 200M


clk_wiz_1 U_clk_wiz_1
(
.clk_out1(clk_rd),     		// output clk_out1 50M
.reset(~rst_n), 			// input reset
.locked(clk_rd_en),         // output locked
.clk_in1(sys_clk1_o));        // input clk_in1 100M


ASYNC_RST_SYNC U_ASYNC_RST_SYNC_WR(
	.src_rst_n(rst_n),
	.dest_clk (clk_wr),
	.dest_clk_en(clk_wr_en),
	.dest_rst_n(rst_wr_n)
	);
BUFG BUFG_RST_WR (
    .I     (rst_wr_n),
    .O     (rst_wr_n_o)
);

ASYNC_RST_SYNC U_ASYNC_RST_SYNC_RD(
	.src_rst_n(rst_n),
	.dest_clk (clk_rd),
	.dest_clk_en(clk_rd_en),
	.dest_rst_n(rst_rd_n)
	);
BUFG BUFG_RST_RD (
    .I     (rst_rd_n),
    .O     (rst_rd_n_o)
);

ASYNC_FIFO #(.FIFO_WITH(8),
			 .FIFO_DEPTH(8),
			 .SHOW_AHAEAD("OFF"),
			 .MEM_TYPE   ("DISTRIBUTE")
					)
U_ASYNC_FIFO
(
		.clk_wr(clk_wr),
		.rst_wr(~rst_wr_n_o),
		.wr_en(wr_en),
		.wr_data(wr_data),
		.fifo_full_wr(fifo_full_wr),

		.clk_rd(clk_rd),
		.rst_rd(~rst_rd_n_o),
		.rd_en(rd_en),
		.rd_data(rd_data),
		.fifo_empty_rd(fifo_empty_rd)
	);

endmodule

