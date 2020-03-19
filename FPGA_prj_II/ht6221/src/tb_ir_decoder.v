`timescale 1ns/1ns
`define clk_period 20

module tb_ir_decoder();

reg clk;
reg rst;
reg iir;
wire [15:0]irdata;
wire [15:0]iraddr;
wire get_flag;

ir_decoder ir_decoder(
	.Clk(clk),
	.Rst_n(rst),
	.iIR(iir),
	.irData(irdata),
	.irAddr(iraddr),
	.Get_Flag(get_flag)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	iir = 1'd1;
	#(`clk_period*10)
	rst = 1'd1;
	#(`clk_period*10)
	iir = 1'd1;
	send_data(1,8'h12);
	#60000000;
	
	iir = 1'd1;
	send_data(2,8'heb);
	#60000000;
	
	$stop;
end

task bit_send;
	input one_bit;
	begin
		iir = 1'd0;#560000;
		iir = 1'd1;
		if(one_bit)
			#1690000;
		else
			#560000;
	end
endtask
integer i;
task send_data;
	input [15:0]addr;
	input [7:0]data;
	begin
		iir = 1'd0;#9000000;
		iir = 1'd1;#4500000;
		for(i=0;i<16;i=i+1)begin
			bit_send(addr[i]);
		end
		for(i=0;i<8;i=i+1)begin
			bit_send(data[i]);
		end
		for(i=0;i<8;i=i+1)begin
			bit_send(~data[i]);
		end
		
	end
endtask

endmodule
