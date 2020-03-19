module ir_decoder_TEST(
	clk,
	rst,
	iir,
	irdata,
	iraddr,
	get_flag
);

input clk;
input rst;
input iir;
output [15:0]irdata;
output [15:0]iraddr;
output get_flag;

localparam	IDLE = 4'b0001,
				HEAD_t9_0 = 4'b0010,
				HEAD_t4_5 = 4'b0100,
				DATA_get = 4'b1000;

reg [18:0]cnt;
reg cnt_en;
reg t9_0ms_OK;
reg t4_5ms_OK;
reg t0_56ms_OK;
reg t1_69ms_OK;
reg timeout;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 19'd0;
	else if(cnt_en)
		cnt <= cnt + 1'd1;
	else 
		cnt <= 19'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t9_0ms_OK <= 1'd0;
	else if(cnt>19'd325000 && cnt<19'd495000)
		t9_0ms_OK <= 1'd1;
	else 
		t9_0ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t4_5ms_OK <= 1'd0;
	else if(cnt>19'd152500 && cnt<19'd277500)
		t4_5ms_OK <= 1'd1;
	else 
		t4_5ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t0_56ms_OK <= 1'd0;
	else if(cnt>19'd20000 && cnt<19'd35000)
		t0_56ms_OK <= 1'd1;
	else 
		t0_56ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t1_69ms_OK <= 1'd0;
	else if(cnt>19'd75000 && cnt<19'd90000)
		t1_69ms_OK <= 1'd1;
	else 
		t1_69ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		timeout <= 1'd0;
	else if(cnt>19'd500000)
		timeout <= 1'd1;
	else 
		timeout <= 1'd0;
		
reg iir_r1,iir_r2;
always@(posedge clk)
	iir_r1 <= iir;
always@(posedge clk)
	iir_r2 <= iir_r1;
	
wire iir_pedge,iir_nedge;
assign iir_pedge = iir_r1 && !iir_r2;
assign iir_nedge = iir_r2 && !iir_r1;

reg [3:0]state;
wire firstcode_err;
wire datashape_err;
assign firstcode_err = (state==DATA_get && iir_pedge && !t0_56ms_OK);
assign datashape_err = (state==DATA_get && iir_nedge && !t0_56ms_OK && !t1_69ms_OK);

reg [4:0]cnt_nedge;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt_nedge <= 5'd0;
	else if(state== DATA_get && iir_nedge)
		begin
			if(cnt_nedge==5'd31)
				cnt_nedge <= 5'd0;
			else
				cnt_nedge <= cnt_nedge + 1'd1;
		end
	else 
		cnt_nedge <= 5'd0;
assign get_flag = (cnt_nedge== 5'd31);		

wire rst_cnt;
wire cnt_low_full;
wire cnt_high_full;
assign cnt_low_full = (state==DATA_get && iir_pedge && t0_56ms_OK);
assign cnt_high_full = (state==DATA_get && iir_nedge && (t0_56ms_OK || t1_69ms_OK));
assign rst_cnt = cnt_low_full || cnt_high_full;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= IDLE;
			cnt_en <= 1'd0;
		end
	else if(!timeout)
		begin
			case(state)
				IDLE:
					if(iir_nedge)
						begin
							state <= HEAD_t9_0;
							cnt_en <= 1'd1;
						end
					else
						begin
							state <= IDLE;
							cnt_en <= 1'd0;
						end	
				HEAD_t9_0:
					if(iir_pedge)
						begin	
							if(t9_0ms_OK)
								begin
									state <= HEAD_t4_5;
									cnt_en <= 1'd0;
								end
							else 
								begin
									state <= IDLE;
									cnt_en <= 1'd0;
								end
						end
					else 
						begin
							state <= HEAD_t9_0;
							cnt_en <= 1'd1;
						end
				HEAD_t4_5:
					if(iir_nedge)
						begin	
							if(t4_5ms_OK)
								begin
									state <= DATA_get;
									cnt_en <= 1'd0;
								end
							else 
								begin
									state <= IDLE;
									cnt_en <= 1'd0;
								end
						end
					else 
						begin
							state <= HEAD_t4_5;
							cnt_en <= 1'd1;
						end
				DATA_get:
					if(firstcode_err || datashape_err || get_flag)
						begin
							state <= IDLE;
							cnt_en <= 1'd0;
						end
					else if(rst_cnt)
						begin
							state <= DATA_get;
							cnt_en <= 1'd0;
						end
					else 
						begin
							state <= DATA_get;
							cnt_en <= 1'd1;
						end
				default:
					begin
						state <= state;
						cnt_en <= cnt_en;
					end
			endcase
		end
	else 
		begin
			state <= IDLE;
			cnt_en <= 1'd0;
		end


reg [31:0]data_tmp;
always@(posedge clk or negedge rst)
	if(!rst)
		data_tmp <= 32'd0;
	else if(state== DATA_get && iir_nedge)
		begin
			if(t0_56ms_OK)
				data_tmp[cnt_nedge] <= 1'b0;
			else if(t1_69ms_OK)
				data_tmp[cnt_nedge] <= 1'b1;
		end
		
assign irdata = data_tmp[31:16];
assign iraddr = data_tmp[15:0];

endmodule
/*
always@(posedge clk or negedge rst)
	if(!rst)
		state <= IDLE;
	else if(!timeout)
		begin
			case(state)
				IDLE:
					if(iir_nedge)
						state <= HEAD_t9_0;
					else
						state <= IDLE;
				HEAD_t9_0:
					if(iir_pedge && t9_0ms_OK)
						state <= HEAD_t4_5;
					else if(iir_pedge && !t9_0ms_OK)
						state <= IDLE;
					else 
						state <= HEAD_t9_0;
				HEAD_t4_5:
					if(iir_nedge && t4_5ms_OK)
						state <= DATA_get;
					else if(iir_nedge && !t4_5ms_OK)
						state <= IDLE;
					else 
						state <= HEAD_t4_5;
				DATA_get:
					if(firstcode_err || datashape_err || get_flag)
						state <= IDLE;
					else 
						state <= DATA_get;
				default:;
			endcase
		end
always@(*)
	case(state)
		IDLE:
			if(iir_nedge)
				cnt_en <= 1'd1;
			else
				cnt_en <= 1'd0;
		HEAD_t9_0:
			if(iir_pedge && t9_0ms_OK)
				cnt_en <= 1'd0;
			else 
				cnt_en <= 1'd1;
		HEAD_t4_5:
			if(iir_nedge && t4_5ms_OK)
				cnt_en <= 1'd0;
			else 
				cnt_en <= 1'd1;
		DATA_get:
			if(rst_cnt)
				cnt_en <= 1'd0;
			else 
				cnt_en <= 1'd1;
		default:;
	endcase
*/

/*
reg [4:0]cnt_nedge;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt_nedge <= 5'd0;
	else if(state== DATA_get && iir_nedge)
		begin
			if(cnt_nedge==5'd31)
				cnt_nedge <= 5'd0;
			else
				cnt_nedge <= cnt_nedge + 1'd1;
		end
	else 
		cnt_nedge <= 5'd0;
assign get_flag = (cnt_nedge== 5'd31);		
		
reg [31:0]data_tmp;
always@(posedge clk or negedge rst)
	if(!rst)
		data_tmp <= 32'd0;
	else if(state== DATA_get && iir_nedge)
		begin
			if(t0_56ms_OK)
				data_tmp[cnt_nedge] <= 1'b0;
			else if(t1_69ms_OK)
				data_tmp[cnt_nedge] <= 1'b1;
		end
		

*/

/*
module ir_decoder(
	clk,
	rst,
	iir,
	irdata,
	iraddr,
	get_flag
);

input clk;
input rst;
input iir;
output [15:0]irdata;
output [15:0]iraddr;
output get_flag;

localparam	IDLE = 4'b0001,
				HEAD_t9_0 = 4'b0010,
				HEAD_t4_5 = 4'b0100,
				DATA_get = 4'b1000;

reg [18:0]cnt;
reg cnt_en;
reg t9_0ms_OK;
reg t4_5ms_OK;
reg t0_56ms_OK;
reg t1_69ms_OK;
reg timeout;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 19'd0;
	else if(cnt_en)
		cnt <= cnt + 1'd1;
	else 
		cnt <= 19'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t9_0ms_OK <= 1'd0;
	else if(cnt>19'd325000 && cnt<19'd495000)
		t9_0ms_OK <= 1'd1;
	else 
		t9_0ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t4_5ms_OK <= 1'd0;
	else if(cnt>19'd152500 && cnt<19'd277500)
		t4_5ms_OK <= 1'd1;
	else 
		t4_5ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t0_56ms_OK <= 1'd0;
	else if(cnt>19'd20000 && cnt<19'd35000)
		t0_56ms_OK <= 1'd1;
	else 
		t0_56ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t1_69ms_OK <= 1'd0;
	else if(cnt>19'd75000 && cnt<19'd90000)
		t1_69ms_OK <= 1'd1;
	else 
		t1_69ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		timeout <= 1'd0;
	else if(cnt>19'd500000)
		timeout <= 1'd1;
	else 
		timeout <= 1'd0;
		
reg iir_r1,iir_r2;
always@(posedge clk)
	iir_r1 <= iir;
always@(posedge clk)
	iir_r2 <= iir_r1;
	
wire iir_pedge,iir_nedge;
assign iir_pedge = iir_r1 && !iir_r2;
assign iir_nedge = iir_r2 && !iir_r1;

reg [3:0]state;
wire firstcode_err;
wire datashape_err;
assign firstcode_err = (state==DATA_get && iir_pedge && !t0_56ms_OK);
assign datashape_err = (state==DATA_get && iir_nedge && !t0_56ms_OK && !t1_69ms_OK);


wire rst_cnt;
wire cnt_low_full;
wire cnt_high_full;
assign cnt_low_full = (state==DATA_get && iir_pedge && t0_56ms_OK);
assign cnt_high_full = (state==DATA_get && iir_nedge && (t0_56ms_OK || t1_69ms_OK));
assign rst_cnt = cnt_low_full || cnt_high_full;

reg get_data_done;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= IDLE;
			cnt_en <= 1'd0;
		end
	else if(!timeout)
		begin
			case(state)
				IDLE:
					if(iir_nedge)
						begin
							state <= HEAD_t9_0;
							cnt_en <= 1'd1;
						end
					else
						begin
							state <= IDLE;
							cnt_en <= 1'd0;
						end	
				HEAD_t9_0:
					if(iir_pedge)
						begin	
							if(t9_0ms_OK)
								begin
									state <= HEAD_t4_5;
									cnt_en <= 1'd0;
								end
							else 
								state <= IDLE;
						end
					else 
						begin
							state <= HEAD_t9_0;
							cnt_en <= 1'd1;
						end
				HEAD_t4_5:
					if(iir_nedge)
						begin	
							if(t4_5ms_OK)
								begin
									state <= DATA_get;
									cnt_en <= 1'd0;
								end
							else 
								state <= IDLE;
						end
					else 
						begin
							state <= HEAD_t4_5;
							cnt_en <= 1'd1;
						end
				DATA_get:
					if(firstcode_err || datashape_err || get_data_done)
						state <= IDLE;
					else if(rst_cnt)
						cnt_en <= 1'd0;
					else
						cnt_en <= 1'd1;
				default:;
			endcase
		end
	else 
		begin
			state <= IDLE;
			cnt_en <= 1'd0;
		end

reg [5:0]data_cnt;
reg [31:0]data_tmp;
assign irdata = data_tmp[31:16];
assign iraddr = data_tmp[15:0];

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			get_data_done <= 1'd0;
			data_cnt <= 6'd0;
			data_tmp <= 32'd0;
		end
	else if(state == DATA_get)
		begin
			if(iir_pedge && (data_cnt==6'd32))
				begin
					data_cnt <= 6'd0;
					get_data_done <= 1'd1;
				end
			else 
				begin
					if(iir_nedge)
						data_cnt <= data_cnt + 1'd1;
					
					if(iir_nedge && t0_56ms_OK)
						data_tmp[data_cnt] <= 1'b0;
					else if(iir_nedge && t1_69ms_OK)
						data_tmp[data_cnt] <= 1'b1;
					
					get_data_done <= 1'd0;
				end
		end
assign get_flag = get_data_done;		

endmodule

*/