module uart_rx_top(
	clk,
	rst,
	rs232_rx
);

input clk;
input rst;
input rs232_rx;

reg [7:0]data_rx_r;
wire data_byte;
wire rx_done;

xm_uart_rx xm_uart_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(3'd0),
	.rs232_rx(rs232_rx),
	.data_byte(data_byte),
	.rx_done(rx_done)
);

always@(posedge clk or negedge rst)
	if(!rst)
		data_rx_r <= 8'd0;
	else if(rx_done)
		data_rx_r <= data_byte;
	else 
		data_rx_r <= data_rx_r;