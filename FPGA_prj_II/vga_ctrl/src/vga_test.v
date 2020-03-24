module vga_test(
	clk,
	rst,
	vga_rgb,
	vga_hs,
	vga_vs,
	vga_blk,
	vga_clk
);
input clk;
input rst;
output [23:0]vga_rgb;
output vga_hs;
output vga_vs;
output vga_blk;
output vga_clk;

wire clk_25m;
wire rst_n;
pll	pll (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_25m ),
	.locked ( rst_n )
	);

reg [23:0]disp_data;
wire [9:0]hcount;
wire [9:0]vcount;

vga_ctrl vga_ctrl(
	.clk(clk_25m),
	.rst(rst_n),
	.data_in(disp_data),
	.hcount(hcount),
	.vcount(vcount),
	.vga_rgb(vga_rgb),
	.vga_hs(vga_hs),
	.vga_vs(vga_vs),
	.vga_blk(vga_blk),
	.vga_clk(vga_clk)
);

localparam	BLACK   = 24'h000000,
				BLUE    = 24'h00000f,
				RED     = 24'hff0000,
				PURPPLE = 24'hff00ff,
				GREEN   = 24'h00ff00,
				CYAN    = 24'h00ffff,
				YELLOW  = 24'hffff00,
				WHITE   = 24'hffffff;
				
localparam	r0_c0 = BLACK   ,
				r0_c1 = BLUE    ,
				r1_c0 = RED     ,
				r1_c1 = PURPPLE ,
				r2_c0 = GREEN   ,
				r2_c1 = CYAN    ,
				r3_c0 = YELLOW  ,
				r3_c1 = WHITE   ;
				
wire c0_act,c1_act;
wire r0_act,r1_act,r2_act,r3_act;

assign c0_act = (hcount>=10'd0) && (hcount<320);
assign c1_act = (hcount>=10'd320) && (hcount<640);
assign r0_act = ((vcount>=10'd0) && (vcount<10'd120));
assign r1_act = ((vcount>=10'd120) && (vcount<10'd240));
assign r2_act = ((vcount>=10'd240) && (vcount<10'd360));
assign r3_act = ((vcount>=10'd360) && (vcount<10'd480));

wire r0_c0_act = r0_act & c0_act;
wire r0_c1_act = r0_act & c1_act;
wire r1_c0_act = r1_act & c0_act;
wire r1_c1_act = r1_act & c1_act;
wire r2_c0_act = r2_act & c0_act;
wire r2_c1_act = r2_act & c1_act;
wire r3_c0_act = r3_act & c0_act;
wire r3_c1_act = r3_act & c1_act;

always@(*)
	case({r0_c0_act, r0_c1_act, r1_c0_act, r1_c1_act, r2_c0_act, r2_c1_act, r3_c0_act, r3_c1_act})
		8'b1000_0000: disp_data = r0_c0;
		8'b0100_0000: disp_data = r0_c1;
		8'b0010_0000: disp_data = r1_c0;
		8'b0001_0000: disp_data = r1_c1;
		8'b0000_1000: disp_data = r2_c0;
		8'b0000_0100: disp_data = r2_c1;
		8'b0000_0010: disp_data = r3_c0;
		8'b0000_0001: disp_data = r3_c1;
		default: disp_data = r0_c0;
	endcase

endmodule 
