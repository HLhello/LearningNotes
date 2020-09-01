module async_rst_sync(
    clk,
    rst_n,
    a,
    c
);

input clk;
input rst_n;
input a;
output reg c;

reg b;
/*=1=*********************************
always@(posedge clk)
    if(!rst_n) 
        b <= 1'b0;
    else 
        b <= a;  
always@(posedge clk)
    if(!rst_n) 
        c <= 1'b0;
    else 
        c <= b;       
/*=2=*********************************
always@(posedge clk or negedge rst_n)
    if(!rst_n) 
        b <= 1'b0;
    else 
        b <= a;  
always@(posedge clk or negedge rst_n)
    if(!rst_n) 
        c <= 1'b0;
    else 
        c <= b;       
/*=3=*********************************/
reg rst_s;
reg rst_out;
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rst_s <= 1'b0;
    else
        rst_s <= 1'b1;  //这里写成1，而不写成rst_n，是因为根据实际综合效果来看，这样做更节省资源，具体原因参考同步复位
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rst_out <= 1'b0;
    else
        rst_out <= rst_s;//将纯异步的复位信号先打一拍，然后在给异步复位同步释放信号
//可选
//wire rst_o;
//assign rst_o = rst_out;
always@(posedge clk or negedge rst_out)
    if(!rst_out) 
        b <= 1'b0;
    else 
        b <= a;  
always@(posedge clk or negedge rst_out)
    if(!rst_out) 
        c <= 1'b0;
    else 
        c <= b;       
/*************************************/
endmodule
