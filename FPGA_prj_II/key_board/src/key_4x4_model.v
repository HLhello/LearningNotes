`timescale 1ns/1ns

module key_4x4_model(Key_Col,Key_Row);
	
	input [3:0] Key_Col;
	output reg [3:0]Key_Row;
	
	reg [15:0] myrand;
	reg [3:0] Key_Row_r;
	reg key_row_sel;
	reg [1:0]now_col,now_row;
	
	initial begin
		now_col = 0;
		now_row = 0;
		key_row_sel = 0;
		myrand = 0;	
	end
	
	initial begin
		Key_Row_r = 4'b1111;
		#50000000;
		press_key(0,0);
		press_key(0,1);
		press_key(0,2);
		press_key(0,3);
		
		press_key(1,0);
		press_key(1,1);
		press_key(1,2);
		press_key(1,3);
		
		press_key(2,0);
		press_key(2,1);
		press_key(2,2);
		press_key(2,3);
		
		press_key(3,0);
		press_key(3,1);
		press_key(3,2);
		press_key(3,3);		
		$stop;
	end	
	
	task press_key;
		input [1:0]row,col;
		begin
			key_row_sel = 0;
			Key_Row_r = 4'b1111;
			Key_Row_r[row] = 0;
			now_row = row;
			repeat(20)begin
				myrand = {$random} % 65536;
				#myrand Key_Row_r[row] = ~Key_Row_r[row];
			end
			key_row_sel = 1;
			now_col = col;
			#22000000;
			key_row_sel = 0;
			Key_Row_r = 4'b1111;
			repeat(20)begin
				myrand = {$random} % 65536;
				#myrand Key_Row_r[row] = ~Key_Row_r[row];
			end
			Key_Row_r = 4'b1111;			
			#22000000;		
		end
	endtask
	
	always@(*)
	if(key_row_sel)
		case(now_row)
			2'd0:Key_Row = {1'b1,1'b1,1'b1,Key_Col[now_col]};
			2'd1:Key_Row = {1'b1,1'b1,Key_Col[now_col],1'b1};
			2'd2:Key_Row = {1'b1,Key_Col[now_col],1'b1,1'b1};
			2'd3:Key_Row = {Key_Col[now_col],1'b1,1'b1,1'b1};
		endcase		
//		else if(now_col == 2'd1)
//			Key_Row = {1'b1,1'b1,Key_Col[now_col],1'b1};
//		else if(now_col == 2'd2)
//			Key_Row = {1'b1,Key_Col[now_col],1'b1,1'b1};
//		else
//			Key_Row = {Key_Col[now_col],1'b1,1'b1,1'b1};
//	end
	else
		Key_Row = Key_Row_r;

	
endmodule

//`timescale 1ns/1ns
//
//module key_4x4_model(key_col,key_row);
//
//	input [3:0]key_col;
//	output reg [3:0]key_row;
//	
//	reg [15:0]shake_time;
//	reg [3:0]key_row_r;
//	reg key_row_sel;
//	reg [1:0]now_col,now_row;
//	
//	initial begin
//		now_col = 0;
//		now_row = 0;
//		key_row_sel = 0;
//		shake_time = 0;
//	end
//	
//	initial begin 
//		key_row_r = 4'b1111;
//		#50000000;
//		press_key(0,0);
//		press_key(0,1);
//		press_key(0,2);
//		press_key(0,3);
//		
//		press_key(1,0);
//		press_key(1,1);
//		press_key(1,2);
//		press_key(1,3);
//		
//		press_key(2,0);
//		press_key(2,1);
//		press_key(2,2);
//		press_key(2,3);
//		
//		press_key(3,0);
//		press_key(3,1);
//		press_key(3,2);
//		press_key(3,3);
//		
//		$stop;
//	end
//	
//	task press_key;
//		input [1:0]row,col;
//		begin
//			key_row_sel = 1'b0;
//			key_row_r = 4'b1111;
//			key_row_r[row] = 1'b0;
//			now_row = row;
//			repeat(20)begin
//				shake_time = {$random}%65536;
//				#shake_time key_row_r[row] = ~key_row_r[row];
//			end
//			key_row_sel = 1'b1;
//			now_col = col;
//			#22000000;
//			key_row_sel = 1'b0;
//			key_row_r = 4'b1111;
//			repeat(20)begin
//				shake_time = {$random}%65536;
//				#shake_time key_row_r[row] = ~key_row_r[row];
//			end
//			key_row_r = 4'b1111;
//			#22000000;
//		end
//	endtask
//	
//	always@(*)
//		if(key_row_sel)
//			case(now_row)
//				2'd0:key_row = {1'b1,1'b1,1'b1,key_col[now_col]};
//				2'd1:key_row = {1'b1,1'b1,key_col[now_col],1'b1};
//				2'd2:key_row = {1'b1,key_col[now_col],1'b1,1'b1};
//				2'd3:key_row = {key_col[now_col],1'b1,1'b1,1'b1};
//			endcase
//		else 
//			key_row = key_row_r;
//endmodule 
