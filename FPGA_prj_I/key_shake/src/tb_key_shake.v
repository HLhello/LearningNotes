`timescale 1ns/1ps

`define clk_period 20

module tb_key_shake();

reg clk;
reg rst;
reg key_in;

reg [15:0]shaking;

wire key_flag;
wire key_state;

key_shake i0(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);

initial clk = 1;
always #(`clk_period/2) clk = ~clk;

initial
	begin
		rst = 1'b0;
		key_in = 1'b1;
		#(`clk_period*10) rst = 1'b1;
		#(`clk_period*10);
		press_key;
		#100000;
		press_key;
		#100000;
		press_key;
		#100000;
		press_key;
		$stop;
	end

task press_key;
	begin
		repeat(50)
			begin
				shaking = {$random}%65536;
				#shaking key_in = ~key_in;
			end
		key_in = 0;
		#50000000;
		
		repeat(50)
			begin
				shaking = {$random}%65536;
				#shaking key_in = ~key_in;
			end
		key_in = 1;
		#50000000;
	end
endtask
	

endmodule
