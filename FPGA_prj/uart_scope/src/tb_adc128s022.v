`timescale 1ns/1ns
`define clk_period 20
`define sin_data_file "./sin_12bit.txt"

module tb_adc128s022;

reg clk;
reg rst;
reg channel;
wire [11:0]data;

reg en_conv;
wire conv_done;
wire adc_state;
wire [7:0]div_parm;

wire sclk;
reg dout;
wire din;
wire cs_n;

assign div_parm = 8'd13;

adc128s022 adc128s022(
	.clk(clk),
	.rst(rst),
	.channel(channel),
	.data(data),
	.en_conv(en_conv),
	.conv_done(conv_done),
	.adc_state(adc_state),
	.div_parm(div_parm),
	//四线spi接口
	.sclk(sclk),
	.dout(dout),
	.din(din),
	.cs_n(cs_n)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

reg [11:0]memory[4095:0];
initial $readmemh(`sin_data_file, memory);

integer i;
integer address;

initial begin 
	rst = 1'd0;
	channel <= 3'd0;
	en_conv = 1'd0;
	dout = 12'd0;
	#(`clk_period*20)
	rst = 1'd1;
	#(`clk_period*2000)
	channel = 3'd5;
	for(i=0; i<3; i=i+1)	begin
		for(address=0; address<4095; address=address+1) begin
			en_conv = 1'd1;
			#(`clk_period);
			en_conv = 1'd0;
			gen_dout(memory[address]);
			@(posedge conv_done);
			#200;
		end
	end
	#2000;
	$stop;
end

task gen_dout;
	input [15:0]vdata;
	reg[4:0]cnt;
	begin
		cnt = 0;
		wait(!adc_state);
		while(cnt<16)
			begin
				@(negedge sclk)
				dout = vdata[15-cnt];
				cnt = cnt + 1'd1;
			end
	end
endtask


endmodule
