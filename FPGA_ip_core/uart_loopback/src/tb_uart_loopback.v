`timescale 1ns/1ps
`define clk_period 20

module tb_uart_loopback();

reg clk;
reg rst;

wire uart_rx;
wire uart_tx;

initial clk = 0;
always #(`clk_period) clk = ~clk;

initial begin 
	rst = 1'b0;
	#(`clk_period*10)
	rst = 1'b1;
	
end


uart_loopback uart_loopback(
	.clk(clk),
	.rst(rst),
	.uart_rx(uart_rx),
	.uart_tx(uart_tx)
);


endmodule
