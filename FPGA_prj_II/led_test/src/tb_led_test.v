`timescale 1ns/1ps

module tb_led_test();

reg a;
reg b;
reg c;

wire led_out;

initial begin
	a = 1; b = 1; c = 1;
	#100;
	a = 0; b = 1; c = 1;
	#100;
	a = 1; b = 0; c = 1;
	#100;
	a = 0; b = 0; c = 1;
	#100;
	a = 1; b = 1; c = 0;
	#100;
	a = 0; b = 1; c = 0;
	#100;
	a = 1; b = 0; c = 0;
	#100;
	a = 0; b = 0; c = 0;
	#200;
	$stop;
end


led_test led_test(
	.a(a),
	.b(b),
	.key_in(c),
	.led_out(led_out)
);



endmodule


