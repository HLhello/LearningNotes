module led_test(
	a,
	b,
	key_in,
	led_out
);

input a;
input b;
input key_in;

output led_out;

assign led_out= key_in? a:b;


endmodule 

