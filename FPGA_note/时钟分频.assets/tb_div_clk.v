`timescale 1ns/1ns

module tb_div_clk;

reg clk;
reg rst;
wire clk_out;

div_clk #(
    .div_num(4'd7)
)div_clk (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

initial clk = 1'b0;
always#(`clk_period/2) clk = ~clk;

initial begin
    rst = 1'b0;
    #20 rst = 1'b1;
    #200
    $stop;
end

endmodule 


