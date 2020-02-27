`timescale 1ns/1ns
`define clk_period 20

module tb_uart_tx();

reg clk;
reg rst;
reg [2:0]baud_set;
reg [7:0]data_byte;
reg send_en;
wire rs232_Tx;
wire tx_done;
wire uart_state;
wire bps_clk;

uart_test_x uart_test_x(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.data_byte(data_byte),
	.send_en(send_en),
	.rs232_Tx(rs232_Tx),
	.tx_done(tx_done),
	.uart_state(uart_state),
	.bps_clk(bps_clk)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	send_en = 1'd0;
	baud_set = 3'd0;
	data_byte = 8'd0;
	#(`clk_period*20)
	rst = 1'd1;
	#(`clk_period*20+1);
	data_byte = 8'haa;
	send_en = 1'd1;
	#(`clk_period);
	send_en = 1'd0;
	
	@(posedge tx_done)
	
	#(`clk_period*5000)
	data_byte = 8'he0;
	send_en = 1'd1;
	#(`clk_period);
	send_en = 1'd0;
	
	@(posedge tx_done)
	
	#(`clk_period*5000);
	data_byte = 8'h55;
	send_en = 1'd1;
	#(`clk_period);
	send_en = 1'd0;
	
	@(posedge tx_done)	
	
	#(`clk_period*5000);
	$stop;


end

endmodule 
