`timescale 1ns/1ns
`define clk_period 20
`define sin_data_file "./sin_12bit.txt"

module tb_adc128s();

reg clk;
reg rst;
reg [2:0]channel;
reg conv_en;
reg dout;
wire din;
wire cs_n;
wire conv_done;
wire sclk;
wire [11:0]data;
wire adc_state;


integer i;
integer address;

adc128s adc128s(
	.clk(clk),
	.rst(rst),
	.channel(channel),
	.conv_en(conv_en),
	.dout(dout),
	.din(din),
	.cs_n(cs_n),
	.conv_done(conv_done),
	.sclk(sclk),
	.data(data),
	.adc_state(adc_state)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

reg [11:0]memory[4095:0];
initial $readmemh(`sin_data_file,memory);

initial begin
	rst = 1'd0;
	channel = 3'd0;
	conv_en = 1'd0;
	dout = 0;
	#(`clk_period*10)
	rst = 1'd1;
	#(`clk_period*10)
	channel = 3'd5;
	for(i=0;i<3;i=i+1)begin
		for(address=0;address<4096;address=address+1)begin
			conv_en = 1'd1;
			#(`clk_period)
			conv_en = 1'd0;
			gen_dout(memory[address]);
			@(posedge conv_done);
			#(`clk_period*10);
		end
	end
	#2000;
	$stop;
end

task gen_dout;
	input [15:0]vdata;
	reg [4:0]cnt;
	begin
		cnt = 5'd0;
		wait(!cs_n);
		while(cnt<16)begin
			@(posedge sclk) dout = vdata[15-cnt];
			cnt = cnt + 1'd1;
		end
	end
endtask


endmodule 
