module I2C(
	clk,
	rst,
	
	rdata_num,
	wdata_num,
	waddr_num,
	
	device_addr,
	word_addr,
	
	wr,
	wr_data,
	wr_data_valid,
	
	rd,
	rd_data,
	rd_data_valid,
	
	scl,
	sda,
	done
);

parameter sys_clock = 50_000_000;
parameter scl_clock = 400_000;
localparam scl_cnt_m = sys_clock/scl_clock;

input clk;
input rst;
	
input [5:0]rdata_num;
input [5:0]wdata_num;
input [1:0]waddr_num;
	
input [15:0]device_addr;
input [1:0]word_addr;
	
input wr;
input [7:0]wr_data;
output wr_data_valid;
	
input rd;
output reg [7:0]rd_data;
output reg rd_data_valid;
	
output reg scl;
inout sda;
output reg done;

localparam	IDLE     = 9'b0_0000_0001,
				WR_START = 9'b0_0000_0010,
				WR_CTRL  = 9'b0_0000_0100,
				WR_WADDR = 9'b0_0000_1000,
				WR_DATA  = 9'b0_0001_0000,
				RD_START = 9'b0_0010_0000,
				RD_CTRL  = 9'b0_0100_0000,
				RD_DATA  = 9'b0_1000_0000,
				STOP     = 9'b1_0000_0000;


reg [15:0]scl_cnt;
reg scl_valid;
reg scl_high;
reg scl_low;

always@(posedge clk or negedge rst)
	if(!rst)
		scl_valid <= 1'd0;
	else if(wr | rd)
		scl_valid <= 1'd1;
	else if(done)
		scl_valid <= 1'd0;
	else 
		scl_valid <= scl_valid;
always@(posedge clk or negedge rst)
	if(!rst)
		scl_cnt <= 16'd0;
	else if(scl_valid && (scl_cnt == scl_cnt_m-1'd1))
		scl_cnt <= 16'd0;
	else if(scl_valid)
		scl_cnt <= scl_cnt + 1'd1;
	else 
		scl_cnt <= 16'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		scl<= 1'b1;
	else if(scl_cnt == scl_cnt_m>>1)
		scl <= 1'd0;
	else if(scl_cnt == 16'd0)
		scl <= 1'd1;
	else 
		scl <= scl;
always@(posedge clk or negedge rst)
	if(!rst)
		scl_high <= 1'd0;
	else if(scl_cnt == scl_cnt_m>>2)
		scl_high <= 1'd1;
	else
		scl_high <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		scl_low <= 1'd0;
	else if(scl_cnt == (scl_cnt_m>>2 + scl_cnt_m>>1))
		scl_low <= 1'd1;
	else
		scl_low <= 1'd0;

reg [8:0]main_state;
reg [7:0]halfbit_cnt;
wire state_cnting;
assign state_cnting =  ((main_state == WR_CTRL) || 
								(main_state == WR_WADDR)|| 
								(main_state == WR_DATA) || 
								(main_state == RD_CTRL) || 
								(main_state == RD_DATA));
always@(posedge clk or negedge rst)
	if(!rst)
		halfbit_cnt <= 8'd0;
	else if(state_cnting && (scl_low | scl_high))
		begin
			if(halfbit_cnt == 8'd17)
				halfbit_cnt <= 8'd0;
			else 
				halfbit_cnt <= halfbit_cnt + 1'd1;
		end
	else if(state_cnting)
		halfbit_cnt <= halfbit_cnt;
	else 
		halfbit_cnt <= 8'd0;
		
reg ack;
always@(posedge clk or negedge rst)
	if(!rst)
		ack <= 1'd0;
	else if(halfbit_cnt==8'd16 && scl_high && sda==1'd0)
		ack <= 1'd1;
	else if(halfbit_cnt==8'd17 && scl_low)
		ack <= 1'd0;
	else 
		ack <= ack;
reg FF;
reg sda_reg;
reg [7:0]sda_data_out;
reg [7:0]sda_data_in;
task send_8bit_data;
	if(scl_high && (halfbit_cnt==8'd16))
		FF <= 1'd1;
	else if(halfbit_cnt<8'd17)
		begin
			sda_reg <= sda_data_out[7];
			if(scl_low)
				sda_data_out <= {sda_data_out[6:0],1'b0};
			else 
				sda_data_out <= sda_data_out;
		end
	else ;
endtask

task receive_8bit_data;
	if(scl_low && (halfbit_cnt==8'd15))
		FF <= 1'd1;
	else if(halfbit_cnt < 8'd15)
		begin
			if(scl_high)
				sda_data_in <= {sda_data_in[6:0],sda};
			else 
				sda_data_in <= sda_data_in;
		end
	else ;
endtask


reg [1:0]waddr_cnt;
reg [5:0]wdata_cnt;
reg [5:0]rdata_cnt;
reg w_flag;
reg r_flag;
always@(posedge clk or negedge rst)
	begin
		if(!rst)
			main_state <= IDLE;
		else begin
			case(main_state)
				IDLE     :begin
					if(wr | rd)
						main_state <= WR_START;
					else 
						main_state <= IDLE;
				end
				WR_START :begin
					if(scl_low)
						main_state <= WR_CTRL;
					else 
						main_state <= WR_START;
				end
				WR_CTRL  :begin
					if(FF==1'd1 && ack==1'd1 && scl_low)
						main_state <= WR_WADDR;
					else if(FF==1'd1 && ack==1'd1)
						main_state <= WR_CTRL;
					else if(FF == 1'd1)
						main_state <= IDLE;
				end
				WR_WADDR :begin
					if(FF==1'd1 && ack==1'd1 && waddr_cnt==waddr_num && w_flag && scl_low)
						main_state <= WR_DATA;
					else if(FF==1'd1 && ack==1'd1 && waddr_cnt==waddr_num && r_flag && scl_low)
						main_state <= RD_START;
					else if(FF==1'd1 && ack==1'd1)
						main_state <= WR_WADDR;
					else if(FF==1'd1 && ack==1'd0)
						main_state  <= IDLE;
				end
				WR_DATA  :begin
					if(FF==1'd1 && ack==1'd1 && wdata_cnt==wdata_num && scl_low)
						main_state <= STOP;
					else if(FF==1'd1 && ack==1'd1)
						main_state <= WR_DATA;
					else if(FF==1'd1 && ack==1'd0)
						main_state <= IDLE;
				end
				RD_START :begin
					if(scl_low)
						main_state <= RD_CTRL;
					else 
						main_state <= RD_START;
				end
				RD_CTRL  :begin
					if(FF==1'd1 && ack==1'd1 && scl_low)
						main_state <= RD_DATA;
					else if(FF==1'd1 && ack==1'd1)
						main_state <= RD_CTRL;
					else if(FF==1'd1)
						main_state <= IDLE;
				end
				RD_DATA  :begin
					if(FF==1'd1 && rdata_cnt==rdata_num && scl_low)
						main_state <= STOP;
					else if(FF==1'd1)
						main_state <= RD_DATA;
				end
				STOP     :begin
					if(scl_high)
						main_state <= IDLE;
					else 
						main_state <= STOP;
				end
				default:main_state <= IDLE;
			endcase
		end
	end

reg sda_en;
assign sda = sda_en? sda_reg : 1'dz;
always@(*)
	begin
		case(main_state)
			IDLE:
				sda_en = 1'b0;
			WR_START,RD_START,STOP:
				sda_en = 1'b1;
			WR_CTRL,WR_WADDR,WR_DATA,RD_CTRL:
				if(halfbit_cnt<16)
					sda_en = 1'b1;
				else 
					sda_en = 1'b0;
			RD_DATA:
				if(halfbit_cnt<16)
					sda_en = 1'b0;
				else 
					sda_en = 1'b1;				
			default:
				sda_en = 1'b0;
		endcase	
	end
assign wr_data_valid = ((main_state == WR_WADDR) &&
								(waddr_cnt == waddr_num) &&
								(w_flag && scl_low) &&
								(ack == 1'd1)) ||
								((main_state == WR_DATA) &&
								(ack == 1'd1) &&
								(scl_low) &&
								(wdata_cnt != wdata_num));
wire rdata_valid_r ;
assign rdata_valid_r = ((main_state == RD_DATA) && (halfbit_cnt == 8'd15) &&scl_low);

always@(posedge clk or negedge rst)
	if(!rst)
		rd_data_valid <= 1'd0;
	else if(rdata_valid_r)
		rd_data_valid <= 1'd1;
	else 
		rd_data_valid <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		rd_data <= 8'd0;
	else if(rdata_valid_r)
		rd_data <= sda_data_in;
	else 
		rd_data <= rd_data;

endmodule 
