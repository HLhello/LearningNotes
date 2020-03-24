module tft_test(
	clk,
	rst,
	tft_rgb,
	tft_vs,
	tft_hs,
	tft_clk,
	tft_pwm,
	tft_de
);


input clk;
input rst;
output [15:0]tft_rgb;
output tft_vs;
output tft_hs;
output tft_clk;
output tft_pwm;
output tft_de;

wire clk_9m;
wire rst_n;

pll	pll (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_9m ),
	.locked ( rst_n )
	);

reg [15:0]disp_data;
wire [9:0]vcount;
wire [9:0]hcount;

tft_ctrl tft_ctrl(
	.clk(clk_9m),
	.rst(rst_n),
	.data_in(disp_data),
	.vcount(vcount),
	.hcount(hcount),
	.tft_rgb(tft_rgb),
	.tft_vs(tft_vs),
	.tft_hs(tft_hs),
	.tft_clk(tft_clk),
	.tft_pwm(tft_pwm),
	.tft_de(tft_de)
);

localparam	BLACK   = 16'h0000,
				BLUE    = 16'h001f,
				RED     = 16'hf800,
				PURPPLE = 16'hf81f,
				GREEN   = 16'h07e0,
				CYAN    = 16'h07ff,
				YELLOW  = 16'hffe0,
				WHITE   = 16'hffff;
				
localparam	r0_c0 = BLACK   ,
				r0_c1 = BLUE    ,
				r1_c0 = RED     ,
				r1_c1 = PURPPLE ,
				r2_c0 = GREEN   ,
				r2_c1 = CYAN    ,
				r3_c0 = YELLOW  ,
				r3_c1 = WHITE   ;
				
wire c0_act = (hcount >= 0 && hcount <240);
wire c1_act = (hcount >=240&& hcount <480);
wire r0_act = (vcount >= 0 && vcount < 68);
wire r1_act = (vcount >=68 && vcount <136);
wire r2_act = (vcount >=136&& vcount <204);
wire r3_act = (vcount >=204&& vcount <272);

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