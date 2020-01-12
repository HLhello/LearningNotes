module sram_ctrl(
	clk,
	rst,
	sram_wreq,
	sram_waddr,
	sram_wdata,
	sram_rreq,
	sram_raddr,
	sram_rdata,
	sram_cs_n,
	sram_we_n,
	sram_oe_n,
	sram_addr,
	sram_data
);

`define DELAY_00NS (cnt == 3'd0)
`define DELAY_20NS (cnt == 3'd1)
`define DELAY_40NS (cnt == 3'd2)
`define DELAY_60NS (cnt == 3'd3)

parameter	IDLE = 4'd0,
				WRT0 = 4'd1,
				WRT1 = 4'd2,
				REA0 = 4'd3,
				REA1 = 4'd4;

input clk;
input rst;

input sram_wreq;
input [14:0]sram_waddr;
input [7:0]sram_wdata;

input sram_rreq;
input [14:0]sram_raddr;
output reg [7:0]sram_rdata;

output reg sram_cs_n;
output reg sram_we_n;
output reg sram_oe_n;

output reg [14:0]sram_addr;
inout [7:0]sram_data;

reg sdlink;
reg [3:0]cstate;
reg [3:0]nstate;
reg [2:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 3'd0;
	else if(cstate == IDLE)
		cnt <= 3'd0;
	else 
		cnt <= cnt + 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		cstate <= IDLE;
	else
		cstate <= nstate;
		
always@(cstate or sram_wreq or sram_rreq or cnt)
	begin
		case(cstate)
			IDLE:
				if(sram_wreq)
					nstate <= WRT0;
				else if(sram_rreq)
					nstate <= REA0;
				else 
					nstate <= IDLE;
			WRT0:
				if(`DELAY_60NS)
					nstate <= WRT1;
				else 
					nstate <= WRT0;
			WRT1:
				nstate <= IDLE;
			REA0:
				if(`DELAY_60NS)
					nstate <= REA1;
				else 
					nstate <= REA0;
			REA1:
				nstate <= IDLE;
			default: 
				nstate <= IDLE;
		endcase
	end

	
always@(posedge clk or negedge rst)
	if(!rst)
		sram_addr <= 15'd0;
	else if(cstate == WRT0)
		sram_addr <= sram_waddr;
	else if(cstate == WRT1)
		sram_addr <= 15'd0;
	else if(cstate == REA0)
		sram_addr <= sram_raddr;
	else if(cstate == REA1)
		sram_addr <= 15'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		sdlink <= 1'b0;
	else if(cstate == WRT0)
		sdlink <= 1'b1;
	else if(cstate == WRT1)
		sdlink <= 1'b0;

always@(posedge clk or negedge rst)
	if(!rst)
		sram_rdata <= 8'd0;
	else if((cstate <= REA0) && `DELAY_60NS)
		sram_rdata <= sram_data;

assign sram_data = sdlink? sram_wdata : 8'hzz;

	
always@(posedge clk or negedge rst)
	if(!rst)
		sram_cs_n <= 1'b1;
	else if(cstate ==WRT0)
		begin 
			if(`DELAY_00NS)
				sram_cs_n <= 1'b1;
			else 
				sram_cs_n <= 1'b0;
		end
	else if(cstate ==REA0)
		sram_cs_n <=1'b0;
	else 
		sram_cs_n <= 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		sram_we_n <= 1'b1;
	else if(cstate <= WRT0)
		begin
			if(`DELAY_20NS)
				sram_we_n <= 1'b0;
			else if(`DELAY_60NS)
				sram_we_n <= 1'b1;
		end
	
always@(posedge clk or negedge rst)
	if(!rst)
		sram_oe_n <= 1'b1;
	else if(cstate == REA0)
		sram_oe_n <= 1'b0;
	else
		sram_oe_n <= 1'b1;

endmodule
