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
output getflag;

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
reg iir_r1,iir_r2;
always@(posedge clk)
	iir_r1 <= iir;
always@(posedge clk)
	iir_r2 <= iir_r1;
	
wire iir_pedge,iir_nedge;
assign iir_pedge = iir_r1 && !iir_r2;
assign iir_nedge = iir_r2 && !iir_r1;


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
	else if(cnt>19'325000 && cnt<495000)
		t9_0ms_OK <= 1'd1;
	else 
		t9_0ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t4_5ms_OK <= 1'd0;
	else if(cnt>19'152500 && cnt<277500)
		t4_5ms_OK <= 1'd1;
	else 
		t4_5ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t0_56ms_OK <= 1'd0;
	else if(cnt>19'20000 && cnt<35000)
		t0_56ms_OK <= 1'd1;
	else 
		t0_56ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		t1_69ms_OK <= 1'd0;
	else if(cnt>19'75000 && cnt<90000)
		t1_69ms_OK <= 1'd1;
	else 
		t1_69ms_OK <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		timeout <= 1'd0;
	else if(cnt>19'500000)
		timeout <= 1'd1;
	else 
		timeout <= 1'd0;

reg [3:0]state;
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
								end
						end
					else 
						begin
							state <= HEAD_t4_5;
							cnt_en <= 1'd0;
						end
				DATA_get:
					if(firstcode_err || datashape_err || getdata_done)
						state <= IDLE;
					else if(rst_cnt)
						cnt <= 1'd1;
					else 
						cnt <= 1'd1;
				default:;
			endcase
		end
	else 
		begin
			state <= IDLE;
			cnt_en <= 1'd0;
		end

wire firstcode_err;
assign firstcode_err = (state==DATA_get && iir_pedge && !t0_56ms_OK);
wire datashape_err;
assign datashape_err = (state==DATA_get && iir_nedge && !t0_56ms_OK && !t1_69ms_OK);
wire getdata_done;
assign getdata_done = (cnt_nedge== 5'd31);
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
wire rst_cnt;
assign rst_cnt = (state==DATA_get &&((iir_pedge && t0_56ms_OK)||(iir_nedge && (t0_56ms_OK||t1_69ms_OK)))
always@(state)
	case(state)
		IDLE:
		HEAD_t9_0:
		HEAD_t4_5:
		DATA_get:
		default:
	endcase
endmodule

