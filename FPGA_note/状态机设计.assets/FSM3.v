module FSM3(
    clk,
    rst,
    i1,
    i2,
    o1,
    o2,
    err
);

input clk;
input rst;
input i1;
input i2;
output reg  o1;
output reg  o2;
output reg  err;

localparam  IDLE = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              ER = 3'b100;

reg [2:0]next_state;
reg [2:0]current_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;
        
always@(rst or current_state or i1 or i2)
    begin 
        next_state = 3'bx;
        case(current_state)
            IDLE: begin 
                    if(~i1) next_state = IDLE;
                    if(i1 & i2) next_state = S1;
                    if(i1 & !i2) next_state = ER;
                  end
              S1: begin 
                    if(!i2) next_state = S1; 
                    if(i1 & i2) next_state = S2; 
                    if(!i1 & i2) next_state = ER; 
                  end
              S2: begin 
                    if(i2) next_state = S2; 
                    if(i1 & !i2) next_state = IDLE; 
                    if(!i1 & !i2) next_state = ER; 
                  end
              ER: begin 
                    if(i1) next_state = ER;
                    if(!i1) next_state = IDLE;
                  end
        endcase
    end   
    
always@(posedge clk or negedge rst)
    if(!rst)
        {o1,o2,err} <= 3'b000;
    else 
        begin
            {o1,o2,err} <= 3'b000;
            case(next_state)
                IDLE: {o1,o2,err} <= 3'b000;
                  S1: {o1,o2,err} <= 3'b100;
                  S2: {o1,o2,err} <= 3'b010;
                  ER: {o1,o2,err} <= 3'b111;
            endcase 
        end
        
endmodule 