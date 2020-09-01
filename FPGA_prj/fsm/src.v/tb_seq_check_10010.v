`timescale 1ns/1ns
`define clk_period 20

module tb_seq_check_10010();

reg clk;
reg rst;
wire din;
wire dout;

seq_check_10010 seq_check(
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

reg [23:0]data;
always@(posedge clk)
	data = {data[22:0],data[23]};

assign din = data[23];

initial begin
	rst = 1'b0;
	data = 24'd0;
	#(`clk_period*5);
	rst = 1'b1;
	data = 24'b1100_1001_0000_1001_0100_0000;
	#(`clk_period*5 + 1);
	
	#(`clk_period*100);
	$stop;
end




endmodule 