module uart_byte_rx(
	clk,
	rst,
	baud_set,
	rs232_rx,
	rx_byte,
	rx_done
);

input clk;
input rst;
input [2:0]baud_set;
input rs232_rx;

output reg [7:0]rx_byte;
output reg rx_done;




endmodule
