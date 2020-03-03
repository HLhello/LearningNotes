`timescale 1ns/1ns
`define clk_period 20

module tb_uart_dpram();

reg clk;
reg rst;
reg key_in;
reg [7:0]tx_data_tb;
reg send_en;
wire rs232_rx;
wire rs232_tx;
wire tx_done_tb;


uart_dpram uart_dpram(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.rs232_rx(rs232_rx),
	.rs232_tx(rs232_tx)
);

uart_tx_I uart_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(3'd0),
	.data_byte(tx_data_tb),
	.send_en(send_en),
	.rs232_Tx(rs232_rx),
	.tx_done(tx_done_tb),
	.uart_state(),
	.bps_clk()
);

initial clk = 1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	send_en = 1'd0;
	key_in = 1'd1;
	tx_data_tb = 8'd0;
	#(`clk_period*20);
	rst = 1'd1;
	#(`clk_period*20+1);

	tx_data_tb = 8'haa;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'd0;	
	@(posedge tx_done_tb);
	#(`clk_period*1000);
	press_key;
	
	#(`clk_period*5000);
	tx_data_tb = 8'hf0;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'd0;	
	@(posedge tx_done_tb);
	#(`clk_period*1000);
	press_key;
	
	#(`clk_period*5000);
	tx_data_tb = 8'h55;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'd0;	
	@(posedge tx_done_tb);
	#(`clk_period*1000);
	press_key;
	
	#200000;
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
