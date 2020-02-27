`timescale  1ns/1ns
`define clk_period 20

module tb_key_led_top();

reg clk;
reg rst;
reg key_in0;
reg key_in1;

wire [3:0]led;

key_led_top key_led_top(
	.clk(clk),
	.rst(rst),
	.key_in0(key_in0),
	.key_in1(key_in1),
	.led(led)
);

initial clk = 1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'b0;
	key_in0 = 1'b1;
	key_in1 = 1'b1;
	#(`clk_period*20);
	rst = 1'b1;
	#(`clk_period*2000);
	press_key0;
	#(`clk_period*2000);
	press_key0;
	#(`clk_period*2000);
	press_key0;
	#(`clk_period*2000);
	press_key1;
	#(`clk_period*2000);
	press_key1;
end

reg [15:0]shake_time0;
reg [15:0]shake_time1;
task press_key0;
	begin
		repeat(50)begin
			shake_time0 = {$random}%65536;
			#shake_time0;
			key_in0 = ~key_in0;
		end
		key_in0 = 1'd0;
		#50_000_000;
		repeat(50)begin
			shake_time0 = {$random}%65536;
			#shake_time0;
			key_in0 = ~key_in0;
		end
		key_in0 = 1'd1;
		#50_000_000;
	end
endtask

task press_key1;
	begin
		repeat(50)begin
			shake_time1 = {$random}%65536;
			#shake_time1;
			key_in1 = ~key_in1;
		end
		key_in1 = 1'd0;
		#50_000_000;
		repeat(50)begin
			shake_time1 = {$random}%65536;
			#shake_time1;
			key_in1 = ~key_in1;
		end
		key_in1 = 1'd1;
		#50_000_000;
		
	end
endtask

endmodule 

