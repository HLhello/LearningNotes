module key_board(
	clk,
	rst,
	key_row_i,
	key_col_o,
	key_flag,
	key_value
);

input clk;
input rst
input [3:0]key_row_i;
output [3:0]key_col_o;
output key_flag;
output [3:0]key_value;

localparam	IDLE       = 11'b0000_0000_001,
				p_filter   = 11'b0000_0000_010,
				read_row_p = 11'b0000_0000_100,
				scan_c0    = 11'b0000_0001_000,
				scan_c1    = 11'b0000_0010_000,
				scan_c2    = 11'b0000_0100_000,
				scan_c3    = 11'b0000_1000_000,
				result_p   = 11'b0001_0000_000,
				wait_r     = 11'b0010_0000_000,
				r_filter   = 11'b0100_0000_000,
				read_row_r = 11'b1000_0000_000;
				
reg [25:0]cnt1;
reg [25:0]cnt2;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt1 <= 26'd0;
	else if(en_cnt1)
		if(cnt1 == 26'd999_999)

endmodule

