`timescale 1ns/1ns
`define clk_period 20
module tb_key_4x4();


reg clk;
reg rst;
wire [3:0]key_row_i;
wire [3:0]key_col_o;
wire key_flag;
wire [3:0]key_value;



key_4x4 key_4x4(
	.clk(clk),
	.rst(rst),
	.key_row_i(key_row_i),
	.key_col_o(key_col_o),
	.key_flag(key_flag),
	.key_value(key_value)
);

key_4x4_model key_4x4_model(key_col_o,key_row_i);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 0;
	#200;
	rst = 1;
end

endmodule 
