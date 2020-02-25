`timescale 1ns/1ps
`define clk_period 20

module tb_key_filter();

reg clk;
reg rst;
reg key_in;
wire key_flag;
wire key_state;

key_filter key_filter(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);

initial clk = 1;
always #(`clk_period/2) clk = ~clk;

initial begin
	rst = 0;
	key_in = 1'b1;
	#(`clk_period*20);
	rst = 1;
	#(`clk_period*2000)
	press_key;
	#10000;
	press_key;
	#10000;
	press_key;
	#10000;
	$stop;
end


reg [15:0]shake_time;
task press_key;
	begin
		repeat(50)begin
			shake_time = {$random}%65536;
			#shake_time;
			key_in = ~key_in;
		end
		key_in = 0;
		#50_000_000;

		repeat(50)begin
			shake_time = {$random}%65536;
			#shake_time;
			key_in = ~key_in;
		end
		key_in = 1;
		#50_000_000;
	
	end
endtask
endmodule 
