`timescale 1ns/1ns
`define clk_period 20

module tb_tlv_5618();

reg clk;
reg rst;
reg start;
reg [15:0]dac_data;
wire set_done;
wire cs_n;
wire din;
wire sclk;
wire dac_state;

tlv_5618 tlv_5618(
	.clk(clk),
	.rst(rst),
	.start(start),
	.dac_data(dac_data),
	.set_done(set_done),
	.cs_n(cs_n),
	.din(din),
	.sclk(sclk),
	.dac_state(dac_state)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0; 
	start = 1'd0;
	dac_data = 16'd0;
	#(`clk_period*10)
	rst = 1'd1;
	#(`clk_period*10)
	dac_data = 16'hCAAA;
	start = 1'd1;
	#(`clk_period)
	start = 1'd0;
	#(`clk_period*10)
	wait(set_done);
	
	#20000
	dac_data = 16'h4555;
	start = 1'd1;
	#(`clk_period)
	start = 1'd0;
	#(`clk_period*10)
	wait(set_done);
	$stop;
	

end


endmodule 
