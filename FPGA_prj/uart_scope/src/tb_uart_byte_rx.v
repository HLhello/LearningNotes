`timescale 1ns/1ns
`define clk_period 20

module tb_uart_byte_rx;

reg clk;
reg rst;
reg baud_set;
reg  [7:0]data_tx;
reg byte_en;

wire tx_done;
wire rs232_tx;
wire [7:0]data_rx;
wire rx_done;

uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.byte_en(byte_en),
	.data_byte(data_tx),
	.tx_done(tx_done),
	.rs232_tx(rs232_tx)
);

uart_byte_rx uart_byte_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rs232_rx(rs232_tx),
	.rx_byte(data_rx),
	.rx_done(rx_done)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	baud_set = 2'd1;
	data_tx = 8'd0;
	byte_en = 1'd0;
	#(`clk_period*20);
	rst = 1'd1;
	#(`clk_period*2000);
	
	data_tx = 8'haa;
	byte_en = 1'd1;
	#(`clk_period);
	byte_en = 1'd0;
	@(posedge tx_done);
	#(`clk_period*5000);
	
	data_tx = 8'h55;
	byte_en = 1'd1;
	#(`clk_period);
	byte_en = 1'd0;
	@(posedge tx_done);
	#(`clk_period*5000);

	$stop;
end


endmodule 