`timescale 1ns/1ps	
`define clk_period 20

module tb_xm_uart_tx();

reg clk;
reg rst;
reg [2:0]baud_set;
reg [7:0]data_byte;
reg send_en;
wire rs232_tx;
wire tx_done;
wire uart_state;

xm_uart_tx xm_uart_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.data_byte(data_byte),
	.send_en(send_en),
	.rs232_tx(rs232_tx),
	.tx_done(tx_done),
	.uart_state(uart_state)
);

initial clk = 0;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'b0;
	data_byte = 8'b0;
	send_en = 1'b0;
	baud_set = 3'd4;
	#(`clk_period*20+1)
	rst = 1'b1;
	#(`clk_period*50)
	
	data_byte = 8'haa;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'b0  ;
	
	@(posedge tx_done)
	#(`clk_period*5000)
	
	data_byte = 8'h55;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'b0;
	
	@(posedge tx_done)
	#(`clk_period*5000);
	$stop;
	
end



endmodule
