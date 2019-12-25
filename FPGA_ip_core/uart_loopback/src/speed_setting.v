`define CLK_PERIOD 40
`define BPS_SET 96
`define BPS_PARA (10_000_000/`CLK_PERIOD/`BPS_SET)
`define BPS_PARA_HF (`BPS_PARA/2)
//宏定义好像是编译器计算的，至于计算结果待会仿真的时候设置个参数看一下

module speed_setting(
	clk,
	rst,
	bps_start,
	bps_hf
);

parameter	clk_p = `CLK_PERIOD,
				bps_s = `BPS_SET,
				bps_pxxxx = `BPS_PARA,
				bps_phxxx = `BPS_PARA_HF;


input clk;
input rst;
input bps_start;//接收到数据后，波特率时钟启动信号置位

output reg bps_hf;
reg [12:0]cnt;

//reg clk_bps_r;
//reg [2:0]uart_ctrl;
//assign bps_clk = clk_bps_r;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 13'd0;
	else if((cnt==`BPS_PARA) || (!bps_start))
		cnt <= 13'b0;
	else 
		cnt <= cnt + 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		bps_hf <= 1'b0;
	else if(cnt == `BPS_PARA_HF)
		bps_hf <= 1'b1;
	else 
		bps_hf <= 1'b0;

endmodule 