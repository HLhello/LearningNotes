/***************************************************
*	Module Name		:	ir_decode		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   红外遥控解码模块
**************************************************/

module ir_decoder(
			Clk,      //模块时钟50M
			Rst_n,    //模块复位
			
			iIR,      //红外信号输入
			
			Get_Flag, //一次接收完成标志
			irData,   //解码数据
			irAddr    //解码地址
		);

	input Clk;
	input Rst_n;
	input iIR;
	
	output Get_Flag;
	output [15:0]irData;
	output [15:0]irAddr;
	
	reg [18:0]cnt;//time counter
	reg [3:0]state;
	
	reg T9ms_ok;
	reg T4_5ms_ok;
	reg T_56ms_ok;
	reg T1_69ms_ok;
	
	reg Get_Data_Done;
	reg Cnt_en;
	reg timeout;
	reg [5:0]data_cnt;
	
	reg [31:0]data_tmp;
	
	assign irAddr = data_tmp[15:0];
	assign irData = data_tmp[31:16];
	
	localparam 
		IDEL = 4'b0001,
		LEADER_T9 = 4'b0010,
		LEADER_T4_5 = 4'b0100,
		DATE_GET = 4'b1000;
		
	reg s_IR0,s_IR1;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		s_IR0 <= 1'b0;
		s_IR1 <= 1'b0;
	end
	else begin
		s_IR0 <= iIR;
		s_IR1 <= s_IR0;
	end
	
	reg s_IR0_Temp,s_IR1_Temp;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		s_IR0_Temp <= 1'b0;
		s_IR1_Temp <= 1'b0;
	end
	else begin
		s_IR0_Temp <= s_IR1;
		s_IR1_Temp <= s_IR0_Temp;
	end
	
	wire ir_pedge,ir_nedge;
	
	assign ir_pedge = !s_IR1_Temp && s_IR0_Temp;
	assign ir_nedge = s_IR1_Temp && !s_IR0_Temp;

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		T9ms_ok <= 1'b0;
	else if(cnt > 19'd325000 && cnt <19'd495000)
		T9ms_ok <= 1'b1;
	else
		T9ms_ok <= 1'b0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		T4_5ms_ok <= 1'b0;
	else if(cnt > 19'd152500 && cnt <19'd277500)
		T4_5ms_ok <= 1'b1;
	else
		T4_5ms_ok <= 1'b0;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		T_56ms_ok <= 1'b0;
	else if(cnt > 19'd20000 && cnt <19'd35000)
		T_56ms_ok <= 1'b1;
	else
		T_56ms_ok <= 1'b0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		T1_69ms_ok <= 1'b0;
	else if(cnt > 19'd75000 && cnt <19'd90000)
		T1_69ms_ok <= 1'b1;
	else
		T1_69ms_ok <= 1'b0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)	
		cnt <= 19'd0;
	else if(Cnt_en == 1'b1)
		cnt <= cnt + 1'b1;
	else
		cnt <= 19'd0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)	
		timeout <= 1'b0;
	else if(cnt >= 19'd500000)
		timeout <= 1'b1;
	else 
		timeout <= 1'b0;

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		state <= IDEL;
		Cnt_en <= 1'b0;
	end
	else if(!timeout)begin
		case(state)
			IDEL:
				if(ir_nedge)begin
					Cnt_en <= 1'b1;
					state <= LEADER_T9;
				end
				else begin
					state <= IDEL;
					Cnt_en <= 1'b0;
				end
			
			LEADER_T9:
				if(ir_pedge)begin
					if(T9ms_ok)begin
						Cnt_en <= 1'b0;
						state <= LEADER_T4_5;
					end
					else begin
						state <= IDEL;	
					end
				end
				else begin
					state <= LEADER_T9;
					Cnt_en <= 1'b1;
				end
					
			LEADER_T4_5:
				if(ir_nedge)begin
					if(T4_5ms_ok)begin
						Cnt_en <= 1'b0;
						state <= DATE_GET;
					end
					else begin
						state <= IDEL;	
					end
				end
				else begin
					state <= LEADER_T4_5;
					Cnt_en <= 1'b1;
				end
					
			DATE_GET:
				if(ir_pedge && !T_56ms_ok)
					state <= IDEL;
				else if(ir_nedge && (!T_56ms_ok && !T1_69ms_ok))
					state <= IDEL;			
				else if(Get_Data_Done)
					state <= IDEL;	
				else if(ir_pedge && T_56ms_ok)begin
					Cnt_en <= 1'b0;
				end
				else if(ir_nedge && (T_56ms_ok || T1_69ms_ok))begin
					Cnt_en <= 1'b0;				
				end
				else
					Cnt_en <= 1'b1;
			default:;
		endcase
	end
	else begin
		Cnt_en <= 1'b0;
		state <= IDEL;	
	end
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		Get_Data_Done <= 1'b0;
		data_cnt <= 6'd0;
		data_tmp <= 32'd0;
	end
	else if(state == DATE_GET)begin
		if(ir_pedge && (data_cnt == 6'd32))begin
			data_cnt <= 6'd0;
			Get_Data_Done <= 1'b1;
		end
		else begin
			if(ir_nedge)
				data_cnt <= data_cnt + 1'b1;
			if(ir_nedge && T_56ms_ok)
				data_tmp[data_cnt] <= 1'b0;
			else if(ir_nedge && T1_69ms_ok)
				data_tmp[data_cnt] <= 1'b1;
			Get_Data_Done <= 1'b0;
		end	
	end
	
	assign Get_Flag = Get_Data_Done;

endmodule
