## uart_byte_tx

```verilog
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
output reg rs232_tx;

wire bps_clk;
reg [7:0]data;
reg [3:0]bps_cnt;
tx_bps_gen tx_bps_gen(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.tx_done(tx_done),
	.byte_en(byte_en),
	.bps_clk(bps_clk)
);

//数据寄存，以免数据丢失
always@(posedge clk or negedge rst)
	if(!rst)
		data <= 8'd0;
	else if(bps_clk && bps_cnt == 4'd1)
		data <= data_byte;
	else 
		data <= data;
//计数波特率时钟
always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 4'd0;
	else if(bps_cnt == 4'd11)
		bps_cnt <= 4'd0;
	else if(bps_clk)
		bps_cnt <= bps_cnt + 1'd1;
	else 
		bps_cnt <= bps_cnt;
//发送数据序列机
always@(posedge clk or negedge rst)
	if(!rst)
		rs232_tx <= 1'd1;
	else
		begin
			case(bps_cnt)
				4'd1 : rs232_tx <= 1'd0;
				4'd2 : rs232_tx <= data[0];
				4'd3 : rs232_tx <= data[1];
				4'd4 : rs232_tx <= data[2];
				4'd5 : rs232_tx <= data[3];
				4'd6 : rs232_tx <= data[4];
				4'd7 : rs232_tx <= data[5];
				4'd8 : rs232_tx <= data[6];
				4'd9 : rs232_tx <= data[7];
				4'd10: rs232_tx <= 1'd1;
				default rs232_tx <= 1'd1;
			endcase 
		end
	
//产生控制信号
always@(posedge clk or negedge rst)
	if(!rst)
		tx_done <= 1'd0;
	else if(bps_cnt == 4'd11)
		tx_done <= 1'd1;
	else 
		tx_done <= 1'd0;
		
endmodule 

```

## uart_byte_rx

```verilog
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

reg [6:0]bps_cnt;
reg [1:0]data_tmp[7:0];
reg [1:0]start_bit;
reg [1:0]stop_bit;
wire byte_en;
wire bps_clk; 		

//过滤毛刺
reg rs232_rx0, rs232_rx1, rs232_rx2, rs232_rx3;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			rs232_rx0 <= 1'd0;
			rs232_rx1 <= 1'd0;
			rs232_rx2 <= 1'd0;
			rs232_rx3 <= 1'd0;
		end
	else 
		begin
			rs232_rx0 <= rs232_rx;
			rs232_rx1 <= rs232_rx0;
			rs232_rx2 <= rs232_rx1;
			rs232_rx3 <= rs232_rx2;
		end
// 检测下降沿
wire neg_rs232 = rs232_rx3 & rs232_rx2 & !rs232_rx1 & !rs232_rx0;

//采样数据

always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 7'd0;
	else if(bps_clk)
		begin
			if(bps_cnt == 7'd89)
				bps_cnt <= 7'd0;
			else 
				bps_cnt <= bps_cnt + 1'd1;
		end
	else 
		bps_cnt <= bps_cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			start_bit <= 2'd0;
			data_tmp[0] <= 2'd0;
			data_tmp[1] <= 2'd0;
			data_tmp[2] <= 2'd0;
			data_tmp[3] <= 2'd0;
			data_tmp[4] <= 2'd0;
			data_tmp[5] <= 2'd0;
			data_tmp[6] <= 2'd0;
			data_tmp[7] <= 2'd0;
			stop_bit <= 2'd0;
		end
	else if(bps_clk)
		begin
			case(bps_cnt)
				7'd0:begin
						start_bit <= 2'd0;
						data_tmp[0] <= 2'd0;
						data_tmp[1] <= 2'd0;
						data_tmp[2] <= 2'd0;
						data_tmp[3] <= 2'd0;
						data_tmp[4] <= 2'd0;
						data_tmp[5] <= 2'd0;
						data_tmp[6] <= 2'd0;
						data_tmp[7] <= 2'd0;
						stop_bit <= 2'd0;
					end
				7'd3 , 7'd4 , 7'd5 :start_bit <= start_bit + rs232_rx;
				7'd12, 7'd13, 7'd14:data_tmp[0] <= data_tmp[0] + rs232_rx;
				7'd21, 7'd22, 7'd23:data_tmp[1] <= data_tmp[1] + rs232_rx;
				7'd30, 7'd31, 7'd32:data_tmp[2] <= data_tmp[2] + rs232_rx;
				7'd39, 7'd40, 7'd41:data_tmp[3] <= data_tmp[3] + rs232_rx;
				7'd48, 7'd49, 7'd50:data_tmp[4] <= data_tmp[4] + rs232_rx;
				7'd57, 7'd58, 7'd59:data_tmp[5] <= data_tmp[5] + rs232_rx;
				7'd66, 7'd67, 7'd68:data_tmp[6] <= data_tmp[6] + rs232_rx;
				7'd75, 7'd76, 7'd77:data_tmp[7] <= data_tmp[7] + rs232_rx;
				7'd84, 7'd85, 7'd86:stop_bit <= stop_bit + rs232_rx;
				default:;
			endcase		
		end
//采样完成，产生输出信号
always@(posedge clk or negedge rst)
	if(!rst)
		rx_byte <= 8'd0;
	else if(bps_clk && bps_cnt == 7'd89)
		rx_byte <= {data_tmp[7][1],data_tmp[6][1],data_tmp[5][1],data_tmp[4][1],
						data_tmp[3][1],data_tmp[2][1],data_tmp[1][1],data_tmp[0][1]};
	else
		rx_byte <= rx_byte;
		
//产生采样时钟
rx_bps_gen rx_bps_gen(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rx_done(rx_done),
	.byte_en(byte_en),
	.bps_clk(bps_clk)
);

assign byte_en = neg_rs232;
always@(posedge clk or negedge rst)
	if(!rst)
		rx_done <= 1'd0;
	else if(bps_clk && bps_cnt == 7'd89)
		rx_done <= 1'd1;
	else 
		rx_done <= 1'd0;
		
endmodule

```

## rx_bps_gen

```verilog
module rx_bps_gen(
	clk,
	rst,
	baud_set,
	rx_done,
	byte_en,
	bps_clk
);

parameter sys_clk = 50_000_000;

input clk;
input rst;
input [2:0]baud_set;
input rx_done;
input byte_en;
output reg bps_clk;

localparam	bps9600   = sys_clk/9600/9-1;
localparam	bps19200  = sys_clk/19200/9-1;
localparam	bps38400  = sys_clk/38400/9-1;
localparam	bps57600  = sys_clk/57600/9-1;
localparam	bps115200 = sys_clk/115200/9-1;
localparam	bps230400 = sys_clk/230400/9-1;
localparam	bps460800 = sys_clk/460800/9-1;
localparam	bps921600 = sys_clk/921600/9-1;

reg [31:0]bps_para;

always@(posedge clk or negedge rst)
	if(!rst)
		bps_para <= 32'd0;
	else begin
		case(baud_set)
			3'd0: bps_para <= bps9600  ;
			3'd1: bps_para <= bps19200 ;
			3'd2: bps_para <= bps38400 ;
			3'd3: bps_para <= bps57600 ;
			3'd4: bps_para <= bps115200;
			3'd5: bps_para <= bps230400;
			3'd6: bps_para <= bps460800;
			3'd7: bps_para <= bps921600;
			default:bps_para <= bps9600;
		endcase
	end
localparam	IDEL = 1'd0,
				RECE = 1'd1;
	
reg [9:0]cnt;
reg state;
reg bps_en;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= IDEL;
			bps_en <= 1'd0;
		end
	else begin
		case(state)
			IDEL: 
				if(byte_en)
					begin
						state <= RECE;
						bps_en <= 1'd1;
					end
				else
					begin
						state <= IDEL;
						bps_en <= 1'd0;
					end
			RECE:
				if(rx_done)
					begin
						state <= IDEL;
						bps_en <= 1'd0;
					end
				else 
					begin
						state <= RECE;
						bps_en <= 1'd1;
					end
		endcase
	end

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 10'd0;
	else if(bps_en)
		begin
			if(cnt == bps_para)
				cnt <= 10'd0;
			else 
				cnt <= cnt + 1'd1;
		end
	else 
		cnt <= 10'd0;
	
always@(posedge clk or negedge rst)
	if(!rst)
		bps_clk <= 1'd0;
	else if(cnt == 10 'd1)
		bps_clk <= 1'd1;
	else 
		bps_clk <= 1'd0;
		
		
endmodule 

```

## tb_uart_byte_rx

```verilog
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
```



## tb_uart_byte_tx

```verilog
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


```

## uart_top

```verilog
module uart_top(
	clk,
	rst,
	key_in,
	rs232_tx,
	rs232_rx
);
input clk;
input rst;
input key_in;
output rs232_tx;
input rs232_rx;

wire key_flag;
wire key_state;
key_filter key_filter(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);

wire [2:0]baud_set;
assign baud_set = 3'd0;

wire byte_en;
assign byte_en = key_flag && !key_state;

wire [7:0]data_tx;
uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.byte_en(byte_en),
	.data_byte(data_tx),
	.tx_done(),
	.rs232_tx(rs232_tx)
);

wire [7:0]data_rx;
uart_byte_rx uart_byte_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rs232_rx(rs232_rx),
	.rx_byte(data_rx),
	.rx_done()
);

issp	issp (
	.probe ( data_rx ),
	.source ( data_tx )
	);

endmodule 

```

