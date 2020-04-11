`timescale 1ns/1ns
`define clk_period 20

module tb_tlv5618;

reg clk;
reg rst;
reg [7:0]div_parm;
reg [15:0]dac_data;

reg en_conv;
wire conv_done;
wire dac_state;

wire cs_n;
wire sclk;
wire din;

tlv5618 tlv5618(
	.clk(clk),
	.rst(rst),
	.div_parm(div_parm),
	.dac_data(dac_data),
	.en_conv(en_conv),
	.conv_done(conv_done),
	.dac_state(dac_state),
	.cs_n(cs_n),
	.sclk(sclk),
	.din(din)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	div_parm = 8'd0;
	dac_data = 16'd0;
	en_conv = 1'd0;
	#(`clk_period*20);
	rst = 1'd1;
	#(`clk_period*20);
	
	dac_data = 16'hCAAA;
	en_conv = 1'd1;
	#(`clk_period);
	en_conv = 1'd0;
	#(`clk_period*10);
	wait(conv_done);
	#20000;
	
	dac_data = 16'h4555;
	en_conv = 1'd1;
	#(`clk_period);
	en_conv = 1'd0;
	#(`clk_period*10);
	wait(conv_done);
	#20000;
	$stop;
end

endmodule 
