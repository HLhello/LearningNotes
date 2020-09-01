module div_clk #(
    parameter div_num = 4'd6
)(
    clk,
    rst,
    clk_out
);

input clk;
input rst;
output clk_out;

reg [3:0]pos_cnt;
reg [3:0]neg_cnt;
wire pos_clk;
wire neg_clk;

always@(posedge clk)
    if(!rst)
        pos_cnt <= 4'd0;
    else if(pos_cnt == div_num-1'b1)
        pos_cnt <= 4'd0;
    else 
        pos_cnt <= pos_cnt + 1'b1;

        
always@(negedge clk)
    if(!rst)
        neg_cnt <= 4'd0;
    else if(neg_cnt == div_num-1'b1)
        neg_cnt <= 4'd0;
    else 
        neg_cnt <= neg_cnt + 1'b1;

assign pos_clk = (pos_cnt < div_num>>1) ? 1'b0 : 1'b1;
assign neg_clk = (neg_cnt < div_num>>1) ? 1'b0 : 1'b1;

assign clk_out = div_num[0] ? (pos_clk & neg_clk) : pos_clk;
        
endmodule



