module dds_module(
	clk,
	rst,
	en,
	fword,
	pword,
	da_clk,
	da_data
);

input clk;
input rst;
input en;
input [31:0]fword;
input [11:0]pword;
output da_clk;
output [9:0]da_data;

reg [31:0]fre_acc;
reg [11:0]rom_addr;

always@(posedge clk or negedge rst)
	if(!rst)
		fre_acc <= 32'd0;
	else if(!en)
		fre_acc <= 32'd0;
	else 
		fre_acc <= fre_acc + fword;
		
always@(posedge clk or negedge rst)
	if(!rst)
		rom_addr <= 12'd0;
	else if(!en)
		rom_addr <= 12'd0;
	else	
		rom_addr <= fre_acc[31:20] + pword;

assign da_clk = (en) ? clk : 1'd1;

dds_rom	dds_rom_inst (
	.address ( rom_addr ),
	.clock ( clk ),
	.q ( da_data )
	);

endmodule

