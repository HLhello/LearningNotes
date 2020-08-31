module seq_check(
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

reg [4:0]current_state;
reg [4:0]next_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(current_state or din or rst)
    begin
        next_state <= 5'bxxxxx;
        case(next_state)
            IDLE: begin if(din == 1'b1) next_state <= S1; else next_state <= IDLE; end
              S1: begin if(din == 1'b0) next_state <= S2; else next_state <= S1;   end
              S2: begin if(din == 1'b0) next_state <= S3; else next_state <= S1;   end
              S3: begin if(din == 1'b1) next_state <= S4; else next_state <= IDLE; end
              S4: begin if(din == 1'b0) next_state <= S5; else next_state <= S1;   end
              S5: begin if(din == 1'b1) next_state <= S1; else next_state <= S3;   end
        endcase
    end

always@(posedge clk or negedge rst)
    if(!rst)
        dout <= 1'b0;
    else if(next_state == S5 && din == 1'b1)
        dout <= 1'b1;

endmodule 