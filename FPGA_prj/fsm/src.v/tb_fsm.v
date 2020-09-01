`timescale 1ns/1ns
`define clk_period 20
module tb_fsm;

reg clk;
reg rst;
reg din;
wire dout;

fsm fsm(
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

integer i = 18;
wire [17:0]x = 18'b11_0010_0100_0010_0101;

initial begin
    rst = 1'b0;
    din = 0;
    #(`clk_period+1);
    rst = 1'b1;
    #200;
    repeat(18) begin
        #`clk_period;
        i = i-1;
        din = x[i];
    end
    #200;    
    $stop;
end

endmodule 


