`timescale 1ns/1ps
`define clk_period 20

module tb_uart_loopback();

reg clk;
reg rst;

reg [7:0]tx_data;
reg [7:0]rx_data;

initial clk = 0;
always #(`clk_period) clk = ~clk;

initial begin 
	rst = 1'b0;
	#(`clk_period*10)
	rst = 1'b1;
	#(`clk_period*20+1)
	
	tx_data = 8'haa;
	send_en = 1'd1;
	#(`clk_period)
	send_en = 1'b0  ;
	
	@(posedge tx_done)
	#(`clk_period*5000)
	
	tx_data = 8'h55;
	#(`clk_period)
	
	@(posedge tx_done)
	#(`clk_period*5000);
	$stop;
	
end


uart_loopback uart_loopback(
	.clk(clk),
	.rst(rst),
	.tx_data(tx_data),
	.rx_data(rx_data)
);


endmodule
