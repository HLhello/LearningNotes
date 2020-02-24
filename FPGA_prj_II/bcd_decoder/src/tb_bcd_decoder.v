`timescale 1ns/1ps

module tb_bcd_decoder();

reg a;
reg b;
reg c;

wire [7:0] out;

initial begin
	a = 0; b = 0; c = 0;
	#100;
	a = 0; b = 0; c = 1;
	#100;
	a = 0; b = 1; c = 0;
	#100;
	a = 0; b = 1; c = 1;
	#100;
	a = 1; b = 0; c = 0;
	#100;
	a = 1; b = 0; c = 1;
	#100;
	a = 1; b = 1; c = 0;
	#100;
	a = 1; b = 1; c = 1;
	#200;
	$stop;
end


bcd_decoder bcd_decoder(
	.a(a),
	.b(b),
	.c(c),
	.out(out)
);

endmodule
