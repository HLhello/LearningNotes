module FSM1(
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
output reg o1;
output reg o2;
output reg err;

localparam  IDLE = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              ER = 3'b100;

reg [2:0]state;

always@(posedge clk or negedge rst)
    if(!rst)
        begin
            state <= IDLE;
            {o1,o2,err} <= 3'b000;
        end
    else 
        begin 
            state <= 3'bx;          //|//|\\这两句话相当重要！！！
            {o1,o2,err} <= 3'b000;  //|\\|//这两句话相当重要！！！
            case(state)
                IDLE: begin 
                        if(!i1)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                        if(i1 & i2)begin state <= S1; {o1,o2,err} <= 3'b100; end 
                        if(i1 & !i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  S1: begin 
                        if(!i2)begin state <= S1; {o1,o2,err} <= 3'b100; end 
                        if(i1 & i2)begin state <= S2; {o1,o2,err} <= 3'b010; end
                        if(!i1 & i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  S2: begin 
                        if(i2)begin state <= S2; {o1,o2,err} <= 3'b010; end
                        if(i1 & !i2)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                        if(!i1 & !i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  ER: begin 
                        if(i1)begin state <= ER; {o1,o2,err} <= 3'b111; end
                        if(!i1)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                    end
            endcase 
        end

endmodule