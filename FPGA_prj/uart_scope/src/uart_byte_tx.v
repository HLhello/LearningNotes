module uart_byte_tx(
	clk,
	rst,
	baud_set,
	byte_en,
	data_byte,
	tx_done,
	rs232_tx
);

input clk;
input rst;
input [2:0]baud_set;
input byte_en;
input [7:0]data_byte;

output reg tx_done;
output rs232_tx;

endmodule 
