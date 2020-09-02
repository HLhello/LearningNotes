/**/
//输出迟滞一拍
module seq_check_10010(
    clk,
    rst,
    din,
    dout
);

input clk;
input rst;
input din;
output reg dout;

localparam  IDLE = 5'b00000,
              S1 = 5'b00001,
              S2 = 5'b00010,
              S3 = 5'b00100,
              S4 = 5'b01000,
              S5 = 5'b10000;
              
reg [4:0]state;

always@(posedge clk or negedge rst)
    if(!rst)
        begin
            state <= IDLE;
            dout <= 1'b0;
        end
    else 
        case(state)
            IDLE: begin 
                    dout <= 1'd0;
                    if(din == 1'b1) 
                        state <= S1; 
                    else 
                        state <= IDLE; 
                  end
              S1: begin
                    dout <= 1'd0;
                    if(din == 1'b0) 
                        state <= S2; 
                    else 
                        state <= S1;   
                    end
              S2: begin 
                    dout <= 1'd0;
                    if(din == 1'b0) 
                        state <= S3; 
                    else 
                        state <= S1;   
                    end
              S3: begin 
                    dout <= 1'd0;
                    if(din == 1'b1) 
                        state <= S4; 
                    else 
                        state <= IDLE; 
                    end
              S4: begin 
                    if(din == 1'b0) 
                        begin
                            state <= S5; 
                            dout <=1'b1;
                        end
                    else
                        begin
                            state <= S1;   
                            dout <= 1'b0;
                        end
                    end
              S5: begin 
                    dout <= 1'd0;              
                    if(din == 1'b0) 
                        state <= S3; 
                    else 
                        state <= S1;   
                    end
              default:
                    begin
                        state <= IDLE;
                        dout <= 1'b0;
                    end
        endcase

endmodule 


/*
//检测到10010的0时立即输出
module seq_check_10010(
    clk,
    rst,
    din,
    dout
);

input clk;
input rst;
input din;
output dout;

localparam  IDLE = 5'b00000,
              S1 = 5'b00001,
              S2 = 5'b00010,
              S3 = 5'b00100,
              S4 = 5'b01000,
              S5 = 5'b10000;
              
reg [4:0]current_state;
reg [4:0]next_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(current_state or din or rst)
    begin
        next_state = 5'bxxxxx;
        case(current_state)
            IDLE: begin if(din == 1'b1) next_state = S1; else next_state = IDLE; end
              S1: begin if(din == 1'b0) next_state = S2; else next_state = S1;   end
              S2: begin if(din == 1'b0) next_state = S3; else next_state = S1;   end
              S3: begin if(din == 1'b1) next_state = S4; else next_state = IDLE; end
              S4: begin if(din == 1'b0) next_state = S5; else next_state = S1;   end
              S5: begin if(din == 1'b0) next_state = S3; else next_state = S1;   end
        endcase
    end

assign dout = (next_state == S5 && din == 0) ? 1'b1 : 1'b0;
endmodule 
*/

/*
//检测到10010的0时立即输出
module seq_check_10010(
    clk,
    rst,
    din,
    dout
);

input clk;
input rst;
input din;
output dout;

localparam  IDLE = 7'b0000000,
              S1 = 7'b0000001,
              S2 = 7'b0000010,
              S3 = 7'b0000100,
              S4 = 7'b0001000,
              S5 = 7'b0010000,
              S6 = 7'b0100000,
              S7 = 7'b1000000;
              
reg [6:0]current_state;
reg [6:0]next_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(rst or current_state or din)
    begin 
        next_state = 7'bxxx_xxxx;
        case(current_state)
            IDLE: begin if(din == 1'b1) next_state = S1; else next_state = IDLE; end
              S1: begin if(din == 1'b0) next_state = S2; else next_state = S1;   end
              S2: begin if(din == 1'b0) next_state = S3; else next_state = S6;   end
              S3: begin if(din == 1'b1) next_state = S4; else next_state = S7;   end
              S4: begin if(din == 1'b0) next_state = S5; else next_state = S1;   end
              S5: begin if(din == 1'b0) next_state = S3; else next_state = S1;   end
              S6: begin if(din == 1'b1) next_state = S1; else next_state = S2;   end
              S7: begin if(din == 1'b1) next_state = S6; else next_state = S2;   end
         default: next_state = IDLE;
        endcase
    end
    
assign dout = (next_state == S5 && din == 0) ? 1'b1 : 1'b0;

endmodule 
*/

