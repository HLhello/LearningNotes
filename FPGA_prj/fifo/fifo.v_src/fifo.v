module fifo(
    wclk,
    rclk,
    rst_n,
    a,
    b,
    data_in,
    data_out,
    empty,
    full
);
input wclk;
input rclk;
input rst_n;  //低位有效
input [3:0] a;
input [3:0] b;
input [15:0] data_in;
output reg[15:0] data_out;
output reg empty;
output reg full;

reg [15:0] rom [9:0];  
reg [3:0] wptr;     //写地址
reg [3:0] rptr;     //读地址
reg [15:0] count;

always @(posedge wclk )
begin 
    if(!full)  //没满
        begin
            rom[wptr] <= data_in;
            count <= count + 1;
            if(wptr == 4'b1001)
                wptr <= 0;
            else 
                wptr <= wptr+1;
        end
    else            //满了
        begin 
            wptr <= wptr;
        end
end

always @(negedge rst_n)
begin
    empty <= 1;
    full <= 0;
    wptr <= 0;
    rptr <= 0;
    count <= 0;
end

always @(count)
begin
    if (count == 0)
        begin
            full <= 0;
            empty <= 1;
        end
    else if (wptr != rptr & count >= 0)
        begin
            full <= 0;
            empty <= 0;
        end
    else if(wptr == rptr)
        begin
            if(a < b)
                begin
                    full <= 1;
                    empty <= 0;
                end
            else if (a>b)
                begin 
                    full <= 0;
                    empty <= 1;
                end
            else
                begin
                    full <= 0;
                    empty <= 0;
                end
        end
end
 
always @(posedge rclk)
begin
    if (!empty)   //没空
        begin
            data_out <= rom[rptr];	
            count <= count + 1;
            rom[rptr] <= 16'b0;
            if (rptr == 4'b1001)
                rptr <= 0;
            else
                rptr <= rptr+1;  
        end
    else               //空了
        begin      
            rptr <= rptr;
        end
end

endmodule

