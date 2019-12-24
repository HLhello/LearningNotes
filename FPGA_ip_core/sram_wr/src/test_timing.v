module test_timing(
	clk,
	rst,
	led,
	sram_wreq,
	sram_waddr,
	sram_wdata,
	sram_rreq,
	sram_raddr,
	sram_rdata
);

parameter per_sec = 26'd19_999;//49999999

input clk;
input rst;

output reg led;

output sram_wreq;
output reg [14:0]sram_waddr;
output reg [7:0]sram_wdata;

output sram_rreq;
output reg [14:0]sram_raddr;
input [7:0]sram_rdata;

reg [25:0] delay;

always@(posedge clk or negedge rst)
	if(!rst)
		delay <= 26'd0;
	else if(delay == per_sec)
		delay <= 26'd0;
	else 
		delay <= delay +1'b1;
		
assign sram_wreq = (delay == 26'd1000);
assign sram_rreq = (delay == 26'd1100);

always@(posedge clk or negedge rst)
	if(!rst)
		sram_wdata <= 8'd0;
	else if(delay == 26'd4000)
		sram_wdata <= sram_wdata +1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		sram_waddr <= 15'd0;
	else if(delay == 26'd4000)
		sram_waddr <= sram_waddr + 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		sram_raddr <= 15'd0;
	else if(delay == 26'd4000)
		sram_raddr <= sram_raddr + 1'b1;
		
always@(posedge clk or negedge rst)
	if(!rst)
		led <= 1'b0;
	else if(delay == 26'd3000) 
	begin
		if(sram_wdata == sram_rdata)
			led <= 1'b0;
		else 
			led <= 1'b1;
	end

	
endmodule 