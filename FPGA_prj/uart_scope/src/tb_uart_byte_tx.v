`timescale 1ns/1ns
`define clk_period 20

module tb_uart_byte_tx;

reg clk;
reg rst;
reg [2:0]baud_set;
reg [7:0]data_byte;
reg byte_en;

wire tx_done;
wire rs232_tx;

uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.byte_en(byte_en),
	.data_byte(data_byte),
	.tx_done(tx_done),
	.rs232_tx(rs232_tx)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	baud_set = 3'd0;
	data_byte = 8'd0;
	byte_en = 1'd0;
	#(`clk_period*20);
	rst = 1'd1;
	#(`clk_period*2000);
	
	data_byte = 8'haa;
	byte_en = 1'd1;
	#(`clk_period);
	byte_en = 1'd0;
	@(posedge tx_done);
	#(`clk_period*5000);
	
	data_byte = 8'h55;
	byte_en = 1'd1;
	#(`clk_period);
	byte_en = 1'd0;
	@(posedge tx_done);
	#(`clk_period*5000);
	
	
	$stop;
end


endmodule 

