module divf(
    clk,
    rst,
    div_clk
);

parameter div_num = 12;
parameter state = 0;//半分频为0，奇数分频为1，偶数分频为2

input clk;
input rst;
output div_clk;

reg[24:0]cnt;

case(state)
    0:  begin
            reg 
        end
    1:  begin 
            reg pos_clk;
            reg neg_clk;
            always@(posedge clk or negedge rst)
                if(!rst)
                    cnt <= 25'd0;
                else if(cnt==0 && pos_clk)
                    cnt <= (div_num>>1)- 1'd1;
                else 
                    cnt <= cnt - 1'd1;
            always@(posedge clk or negedge rst)
                if(!rst)
                    pos_clk <= 1'b0;
                else if(cnt == 0)
                    pos_clk <= ~pos_clk;
                else 
                    pos_clk <= pos_clk;
            always@(negedge clk or negedge rst)
                if(!rst)
                    neg_clk <= 1'b0;
                else
                    neg_clk <= pos_clk;
            assign div_clk = pos_clk & neg_clk;
        end 
    2:  begin
            reg divclk;
            always@(posedge clk or negedge rst)
                if(!rst)
                    cnt <= 25'd0;
                else if(cnt == 25'd0)
                    cnt <= (div_num>>1)- 1'd1;
                else 
                    cnt <= cnt - 1'd1;
            always@(posedge clk or negedge rst)
                if(!rst)
                    divclk <= 1'b0;
                else 
                    divclk <= ~divclk;
            assign div_clk = divclk;
        end
endcase 

endmodule 