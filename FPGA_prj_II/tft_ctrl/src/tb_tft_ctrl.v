`timescale 1ns/1ns
`define clk_period 120

module tb_tft_ctrl();

reg clk;
reg rst;
reg [15:0]data_in;
wire [9:0]vcount;
wire [9:0]hcount;
wire [15:0]tft_rgb;
wire tft_vs;
wire tft_hs;
wire tft_clk;
wire tft_pwm;
wire tft_de;

tft_ctrl tft_ctrl(
	.clk(clk),
	.rst(rst),
	.data_in(data_in),
	.vcount(vcount),
	.hcount(hcount),
	.tft_rgb(tft_rgb),
	.tft_vs(tft_vs),
	.tft_hs(tft_hs),
	.tft_clk(tft_clk),
	.tft_pwm(tft_pwm),
	.tft_de(tft_de)
);

initial clk = 1'd1;
always#(`clk_period/2)clk = ~clk;

initial begin 
	rst = 0;
	data_in = 0;
	#(`clk_period*20)
	rst = 1;
	#(`clk_period*20)
	data_in = 16'hffff;
end

reg [11:0]v_cnt = 0;
always@(posedge tft_vs)
	v_cnt <= v_cnt + 1'd1;
	
initial begin
	wait(v_cnt==3);
	$stop;
end

endmodule
