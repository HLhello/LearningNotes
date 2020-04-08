module tlv5618(
	clk,
	rst,
	dac_data,
	start,
	set_done,
	div_parm,
	cs_n,
	din,
	sclk,
	dac_state
);

input clk;
input rst;
input [15:0]dac_data;
input start;
output set_done;
input [7:0]div_parm;

output reg cs_n;
output reg din;
output reg sclk;
output dac_state;
	
endmodule 
