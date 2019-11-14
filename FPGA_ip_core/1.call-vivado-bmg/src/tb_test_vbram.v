`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/14 16:14:05
// Design Name: 
// Module Name: tb_test_vbram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define PERIOD 5
`define SD 0.1    //synchronous delay eg. flip flop
`define AD 0.2    //asynchronous delay eg. combinational logic
`define SEEK_SET 0
`define SEEK_CUR 1
`define SEEK_END 2

module tb_test_vbram();
reg clk;
reg rst;
reg wea;
reg [15:0]din;
wire [15:0]dout;

integer fp_r, fp_w;
integer cnt_rd;

glbl glbl();

initial begin
    fp_r = $fopen("din.txt","r");
    if(!fp_r)
    begin
        $display("could not open \"din\"");
        $stop;
    end
    
    fp_w = $fopen("dout.txt","w");
    if(!fp_w)
    begin
        $display("could not open \"dout\"");
        $stop;
    end
    
    clk = 1'b0;
    rst = 1'b1;
    @(posedge clk)
    #`SD rst = 1'b0;
    repeat(100)
        @(posedge clk);
    #`SD rst = 1'b1;
    @(posedge clk);
	//*****************************************
    repeat(5) begin
        repeat(100)
            @(posedge clk);
			
        repeat(16)begin
            @(posedge clk);
            #`SD wea  = 1'b1;
            cnt_rd = $fscanf(fp_r, "%d", din);
        end
		
		@(posedge clk);
        #`SD wea = 1'b0;
        cnt_rd = $fseek(fp_r, 0, `SEEK_SET);
        repeat(16)
            @(posedge clk);
    end
	//*****************************************
	
	repeat (100)
		@(posedge clk);	
    
	$fclose(fp_r);
    $fclose(fp_w);
    $stop;
end

always #`PERIOD clk = ~clk;

always@(posedge clk)
    if(wea == 1'b0)
        $fwrite(fp_w, "%d\n", dout);

test_vbram test4vbram(
        .clk(clk),
        .rst(rst),
        .wea(wea),
        .din(din),
        .dout(dout)
        );
		

endmodule
