module key_4x4(
	clk,
	rst,
	key_row_i,
	key_col_o,
	key_flag,
	key_value
);

input clk;
input rst;
input [3:0]key_row_i;

output reg [3:0]key_col_o;
output reg key_flag;
output reg [3:0]key_value;

localparam	IDLE       = 3'b000,
				p_filter   = 3'b001,
				read_row_p = 3'b010,
				scan       = 3'b011,
				result_p   = 3'b100,
				wait_r     = 3'b101,
				r_filter   = 3'b110,
				read_row_r = 3'b111;
				
wire press_key;
assign press_key = (key_row_i != 4'b1111);
wire release_key;
assign release_key = (key_row_i == 4'b1111);

reg [2:0]state;		
reg [19:0]cnt;
reg cnt_full;
reg err_shake;
reg scan_done;
reg [1:0]scan_cnt;		
reg [3:0]key_row;
reg [3:0]key_col;
reg [3:0]key_col_r;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 20'd0;
	else if(cnt == 20'd999_999 || err_shake)
		cnt <= 20'd0;
	else if(state == p_filter || state == r_filter)
		cnt <= cnt + 1'b1;


always@(posedge clk or negedge rst)
	if(!rst)
		cnt_full <= 1'd0;
	else if(cnt == 20'd999_998)
		cnt_full <= 1'd1;
	else 
		cnt_full <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		err_shake <= 1'd0;
	else if(state == p_filter &&!cnt_full && !press_key)
		err_shake <= 1'd1;
	else if(state == r_filter &&!cnt_full && !release_key)
		err_shake <= 1'd1;
	else 
		err_shake <= 1'd0;

always@(posedge clk or negedge rst)
		if(!rst)
			scan_cnt <= 2'd0;
		else if(state == scan)
			scan_cnt <= scan_cnt + 1'd1;
			
always@(posedge clk or negedge rst)
	if(!rst)
		key_col_o <= 4'b0000;
	else if(state == scan)
		begin
			case(scan_cnt)
				2'd0: key_col_o <= 4'b1110;
				2'd1: key_col_o <= 4'b1101;
				2'd2: key_col_o <= 4'b1011;
				2'd3: key_col_o <= 4'b0111;
			endcase
		end
always@(posedge clk or negedge rst)
	if(!rst)
		scan_done <= 1'd0;
	else if(scan_cnt == 2'd3)
		scan_done <= 1'd1;
	else
		scan_done <= 1'd0;


always@(posedge clk or negedge rst)
		if(!rst)
			state <= IDLE;
		else begin
			case(state)
				IDLE       :
								if(press_key)
									state <= p_filter;
								else
									state <= IDLE;
				p_filter   :
								if(cnt_full)
									state <= read_row_p;
								else if(err_shake)
									state <= IDLE;
								else 
									state <= p_filter;
				read_row_p :
								if(key_row_i != 4'b1111)
									state <= scan;
								else 
									state <= IDLE;
				scan       :
								if(scan_done)
									state <= result_p;
								else 
									state <= scan;
				result_p   ://100	
								state <= wait_r;				
				wait_r     ://101	
								if(release_key)
									state <= r_filter;
								else 
									state <= wait_r;
				r_filter   ://110	
								if(cnt_full)
									state <= read_row_r;
								else if(err_shake)
									state <= wait_r;
								else 
									state <= r_filter;
				read_row_r ://111
								if(release_key)
									state <= IDLE;
								else 
									state <= r_filter;				
			endcase
		end

always@(posedge clk or negedge rst)
	if(!rst)
		key_flag <= 1'd0;
	else if(state <= result_p)
		key_flag <= 1'd1;
	else 
		key_flag <= 1'd0;
always@(posedge clk or negedge rst)
	if(!rst)
		key_row <= 4'b1111;
	else if(state==read_row_p)
		key_row <= key_row_i; 
always@(posedge clk)
	key_col_r <= key_col_o;
always@(posedge clk or negedge rst)
	if(!rst)
		key_col <= 4'd0;
	else if(key_row_i != 4'b1111)
		key_col <= (~key_col_r) | key_col;
	else 
		key_col <= key_col;		
		
always@(posedge clk or negedge rst)
	if(!rst)
		key_value <= 4'd0;
	else if(state == result_p)
		begin
			case({key_row,key_col})
				8'b1110_0001: key_value <= 4'd0;
				8'b1110_0010: key_value <= 4'd1;
				8'b1110_0100: key_value <= 4'd2;
				8'b1110_1000: key_value <= 4'd3;
				
				8'b1101_0001: key_value <= 4'd4;
				8'b1101_0010: key_value <= 4'd5;
				8'b1101_0100: key_value <= 4'd6;
				8'b1101_1000: key_value <= 4'd7;
	
				8'b1011_0001: key_value <= 4'd8;
				8'b1011_0010: key_value <= 4'd9;
				8'b1011_0100: key_value <= 4'd10;
				8'b1011_1000: key_value <= 4'd11;
				
				8'b0111_0001: key_value <= 4'd12;
				8'b0111_0010: key_value <= 4'd13;
				8'b0111_0100: key_value <= 4'd14;
				8'b0111_1000: key_value <= 4'd15;
				default: key_value <= key_value;
			endcase	
		end

endmodule


