/**/
//迟滞一拍时钟
module seq_check_hello(
	clk,
	rst,
	din,
	dout
);

input clk;
input rst;
input [7:0]din;

output reg dout;

localparam	IDLE     = 5'b00000,
            check_H  = 5'b00001,
            check_e  = 5'b00010,
            check_l1 = 5'b00100,
            check_l2 = 5'b01000,
            check_o  = 5'b10000;

reg [4:0]state;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= IDLE;
			dout <= 1'b0;
		end
	else 
		case(state)
            IDLE : begin 
                    dout <= 1'b0;
                    if(din == "H")
                        state <= check_H;
                    else 
                        state <= IDLE;
                    end
			check_H : begin
                    dout <= 1'b0;
                    if(din == "e")
                        state <= check_e;
                    else if(din == "H")
                        state <= check_H;
                    else 
                        state <= IDLE;
                    end
			check_e : begin
                    dout <= 1'b0;
                    if(din == "l")
                        state <= check_l1;
                    else if(din == "H")
                        state <= check_H;
                    else 
                        state <= IDLE;
                    end
			check_l1: begin
                    dout <= 1'b0;
                    if(din == "l")
                        state <= check_l2;
                    else if(din == "H")
                        state <= check_H;
                    else
                        state <= IDLE;
                    end
			check_l2: begin
                    if(din == "o")
                        begin dout <= 1'b1; state <= check_o; end
                    else if(din == "H")
                        begin dout <= 1'b0; state <= check_H; end
                    else
                        begin dout <= 1'b0; state <= IDLE; end
                    end
			check_o : begin
                    dout <= 1'b0;
                    if(din == "H")
                        state <= check_H;
                    else 
                        state <= IDLE;
                    end
			default: begin dout <= 1'b0; state <= IDLE;end
		endcase 

endmodule 


/*
//检测到hello的输入时立即拉高输出
module seq_check_hello(
	clk,
	rst,
	din,
	dout
);

input clk;
input rst;
input [7:0]din;

output reg dout;

localparam	IDLE     = 5'b00000,
            check_H  = 5'b00001,
            check_e  = 5'b00010,
            check_l1 = 5'b00100,
            check_l2 = 5'b01000,
            check_o  = 5'b10000;

reg [4:0]current_state;
reg [4:0]next_state;

always@(posedge clk or negedge rst)
	if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(rst or current_state or din)
    begin 
        next_state = 5'bxxxxx;
        dout = 1'b0;
        case(current_state)
            IDLE : begin 
                    dout <= 1'b0;
                    if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_H : begin
                    dout = 1'b0;
                    if(din == "e")
                        next_state = check_e;
                    else if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_e : begin
                    dout <= 1'b0;
                    if(din == "l")
                        next_state = check_l1;
                    else if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_l1: begin
                    dout <= 1'b0;
                    if(din == "l")
                        next_state = check_l2;
                    else if(din == "H")
                        next_state = check_H;
                    else
                        next_state = IDLE;
                    end
			check_l2: begin
                    if(din == "o")
                        begin dout = 1'b1; next_state = check_o; end
                    else if(din == "H")
                        begin dout = 1'b0; next_state = check_H; end
                    else
                        begin dout = 1'b0; next_state = IDLE; end
                    end
			check_o : begin
                    dout <= 1'b0;
                    if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			default: begin dout = 1'b0; next_state = IDLE;end
		endcase 
    end
endmodule 
*/

/*
//迟滞一拍时钟
module seq_check_hello(
	clk,
	rst,
	din,
	dout
);

input clk;
input rst;
input [7:0]din;

output reg dout;

localparam	IDLE     = 5'b00000,
            check_H  = 5'b00001,
            check_e  = 5'b00010,
            check_l1 = 5'b00100,
            check_l2 = 5'b01000,
            check_o  = 5'b10000;

reg [4:0]current_state;
reg [4:0]next_state;

always@(posedge clk or negedge rst)
	if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(rst or current_state or din)
    begin 
        next_state = 5'bxxxxx;
        case(current_state)
            IDLE : begin 
                    if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_H : begin
                    if(din == "e")
                        next_state = check_e;
                    else if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_e : begin
                    if(din == "l")
                        next_state = check_l1;
                    else if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			check_l1: begin
                    if(din == "l")
                        next_state = check_l2;
                    else if(din == "H")
                        next_state = check_H;
                    else
                        next_state = IDLE;
                    end
			check_l2: begin
                    if(din == "o")
                        next_state = check_o;
                    else if(din == "H")
                        next_state = check_H; 
                    else
                        next_state = IDLE; 
                    end
			check_o : begin
                    if(din == "H")
                        next_state = check_H;
                    else 
                        next_state = IDLE;
                    end
			default: next_state = IDLE;
		endcase 
    end

always@(posedge clk or negedge rst)
    if(!rst)
        dout <= 1'b0;
    else if(next_state == check_o && din == "o")
        dout <= 1'b1;
    else 
        dout <= 1'b0;

endmodule 
*/
