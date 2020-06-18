`timesclae 1ns/1ns
`define clk_period 20

module tb_mod3();

reg clk;
reg rst;
reg din;

wire dout;

mod3 mod3(
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin
    rst = 1'b0;
    din = 1'b0;
    #200;
    rst = 1'b1;
    #201;

end


endmodule 