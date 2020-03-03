//module key_board(
//	clk,
//	rst,
//	key_row_i,
//	key_col_o,
//	key_flag,
//	key_value
//);
//
//input clk;
//input rst;
//input [3:0]key_row_i;
//output [3:0]key_col_o;
//output key_flag;
//output [3:0]key_value;
//
//localparam	IDLE       = 11'b0000_0000_001,
//				p_filter   = 11'b0000_0000_010,
//				read_row_p = 11'b0000_0000_100,
//				scan_c0    = 11'b0000_0001_000,
//				scan_c1    = 11'b0000_0010_000,
//				scan_c2    = 11'b0000_0100_000,
//				scan_c3    = 11'b0000_1000_000,
//				result_p   = 11'b0001_0000_000,
//				wait_r     = 11'b0010_0000_000,
//				r_filter   = 11'b0100_0000_000,
//				read_row_r = 11'b1000_0000_000;
//				
//reg [19:0]cnt1;
//reg en_cnt1;
//
//always@(posedge clk or negedge rst)
//	if(!rst)
//		cnt1 <= 20'd0;
//	else if(en_cnt1)
//		begin
//			if(cnt1 == 20'd999_999)
//				cnt1 <= 20'd0;
//			else 
//				cnt1 <= cnt1 + 1'b1;
//		end
//	else 
//		cnt1 <= 20'd0;
//
//reg cnt1_done;
//always@(posedge clk or negedge rst)
//	if(!rst)
//		cnt1_done <= 1'd0;
//	else if(cnt1 == 20'd999_999)
//		cnt1_done <= 1'd1;
//	else 
//		cnt1_done <= 1'b0;
//
//reg [25:0]cnt2;
//reg en_cnt2;
//
//always@(posedge clk or negedge rst)
//	if(!rst)
//		cnt2 <= 26'd49_999_999;
//	else if(en_cnt2)
//		begin
//			if(cnt2 == 26'd0)
//				cnt2 <= 26'd999_999;
//			else 
//				cnt2 <= cnt1 - 1'b1;
//		end
//	else 
//		cnt2 <= 26'd49_999_999;
//
//reg cnt2_done;
//always@(posedge clk or negedge rst)
//	if(!rst)
//		cnt2_done <= 1'd0;
//	else if(cnt2 == 26'd0)
//		cnt2_done <= 1'd1;
//	else 
//		cnt2_done <= 1'b0;
//
//reg [10:0]state;
//always@(posedge clk or negedge rst)
//		if(!rst)
//			state <= IDLE;
//		else begin
//			case(state)
//				IDLE       :
//								if(key_row_i != 4'b1111)
//									state <= p_filter;
//								else 
//									state <= IDLE;
//				p_filter   :
//								if(cnt1_done)
//									state <= read_row_p;
//								else 
//									state <= p_filter;
//				read_row_p :
//								if(key_row_i != 4'b1111)
//									state <= scan_c0;
//								else 
//									state <= IDLE;
//				scan_c0    :
//								if(key_row_i != 4'b1111)
//									state <= p_filter;
//								else 
//									state <= IDLE;	
//				scan_c1    :
//								state <= scan_c2;
//				scan_c2    :
//								state <= scan_c3;
//				scan_c3    :	
//								state <= result_p;			
//				result_p   :	
//								state <= wait_r;				
//				wait_r     :	
//								if(key_row_i != 4'b1111)
//									state <= r_filter;
//								else 
//									state <= wait_r;
//				r_filter   :	
//								if(cnt1_done)
//									state <= read_row_r;
//								else 
//									state <= r_filter;				
//				read_row_r :
//								if(key_row_i == 4'b1111)
//									state <= IDLE;
//								else 
//									state <= r_filter;				
//				default    :state <= IDLE;				
//			endcase
//		end
//		
//endmodule
//
