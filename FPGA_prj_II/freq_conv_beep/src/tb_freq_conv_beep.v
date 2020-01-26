`timescale 1ns/1ns
`define clk_period 20  //时钟频率50MHz

module tb_freq_conv_beep();

reg clk;
reg rst;
reg [31:0]cnt_acc;
reg mode;//计数模式，0单次计数，1循环计数
reg cnt_going;//高点平计数，低电平停止计数
wire [31:0]cnt_now;//当前计数值
wire  full_flag;

initial clk = 1;
always#(`clk_period/2) clk = ~clk;

initial 
	begin 
		rst = 0;
		cnt_acc = 0;
		mode = 0;
		cnt_going = 0;
		#(`clk_period*20)
		rst = 1;
		#(`clk_period*20);
		
		cnt_acc = 1000;//预设计数最大值是1000
		mode = 1;// 计数模式
		#(`clk_period*20);
		cnt_going = 1;//计数使能
		#(`clk_period*12000);
		cnt_going = 0;
		#(`clk_period*20);
		
		cnt_acc = 1000;//预设计数最大值是1000
		mode = 1;// 计数模式为循环模式
		#(`clk_period*20);
		cnt_going = 1;//计数使能
		#(`clk_period*12000);
		cnt_going = 0;
		#(`clk_period*20);
		
		cnt_acc = 600;//预设计数最大值是1000
		mode = 1;// 计数模式为循环模式
		#(`clk_period*20);
		cnt_going = 1;//计数使能
		#(`clk_period*8000);
		cnt_going = 0;
		#(`clk_period*20);
		
		cnt_acc = 1000;//预设计数最大值是1000
		mode = 0;// 计数模式为单次模式
		#(`clk_period*20);
		cnt_going = 1;//计数使能
		#(`clk_period*1200);
		cnt_going = 0;
		#(`clk_period*20);
		
		cnt_acc = 600;//预设计数最大值是1000
		mode = 0;// 计数模式为单次模式
		#(`clk_period*20);
		cnt_going = 1;//计数使能
		#(`clk_period*1200);
		cnt_going = 0;
		#(`clk_period*20);
		
		$stop;
		
	end

freq_conv_beep freq_conv_beep(
	.clk(clk),
	.rst(rst),
	.cnt_acc(cnt_acc),
	.mode(mode),
	.cnt_going(cnt_going),
	.cnt_now(cnt_now),
	.full_flag(full_flag)
);


endmodule
