module uart_rom(
	clk,
	rst,
	q
);

input clk;
input rst;

output [7:0]q;

reg [7:0]addr;
always@(posedge clk or negedge rst)
	if(!rst)
		addr <= 8'd0;
	else
		addr <= addr + 1'd1;
		
roms	roms_inst (
	.address ( addr ),
	.clock ( clk ),
	.q ( q )
	);

endmodule
