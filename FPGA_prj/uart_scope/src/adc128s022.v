module adc128s022(
	clk,
	rst,
	channel,
	data,
	en_conv,
	conv_done,
	adc_state,
	div_parm,
	sclk,
	dout,
	din,
	cs_n
);

input clk;
input rst;

input [2:0]channel;
output reg [11:0]data;

input en_conv;
output reg conv_done;
output adc_state;
input [7:0]div_parm;

output reg sclk;
output reg cs_n;
input dout;
output reg din;




endmodule 
