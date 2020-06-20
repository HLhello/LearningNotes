module diy_fifo(
    clk,
    rst,
    wr,
    w_data,
    rd,
    
    empty,
    full,
    r_data
);

//对队列的参数设置。建议这样写，便于以后代码的移植
//如果以后要实现数据宽度为16，深度为2^8的FIFO。只需改N =16 M=8即可
parameter N = 8, //数据宽度
parameter M = 4 //fifo的地址宽度

input clk, //输入时钟
input rst, //输入复位信号
input wr, //输入写使能
input [N-1:0] w_data, //输入输入
input rd, //输入读使能

output empty, //输出fifo空标志
output full, //输出fifo满标志
output [N-1:0] r_data //输出读取的数据

reg [N-1:0] array_reg [2**M - 1:0];//寄存器组，用来充当FIFO队列

reg [M-1:0] w_ptr_reg; //定义写指针，指示当前写的位置
reg [M-1:0] w_ptr_next;//下一个状态写的位置
reg [M-1:0] w_ptr_succ;//写位置的下一个位置

reg [M-1:0] r_ptr_reg;//定义读指针，指示当前读的位置
reg [M-1:0] r_ptr_next;//下一个状态读的位置
reg [M-1:0] r_ptr_succ;//读位置的下一个位置

reg full_reg, full_next;//定义FIFO满和空的信号
reg empty_reg, empty_next;

assign full = full_reg;
assign empty = empty_reg;

wire wr_en;
assign wr_en = wr & ~full_reg;

// 数据的读取。数据读取是一直在读取的，不过读取的是之前的值。
assign r_data = array_reg[r_ptr_reg];

//数据的写入，在数据的上升沿的时候，有写使能信号，将数据写入。
always@( posedge clk )
    if( wr_en )
        array_reg[w_ptr_reg] <= w_data;
    else
        array_reg[w_ptr_reg] <= array_reg[w_ptr_reg];

/*状态跳转
在复位信号有效，读/写指针都指向0地址。此时队列状态为空。
在复位不有效，且在时钟的上升沿，读/写指针的值，队列空，满状态的值又下一状态决定。否则保持 */

always@( posedge clk ) begin
    if( !rst )begin
        w_ptr_reg <= 0;
        r_ptr_reg <= 0;
        full_reg <= 1'b0;
        empty_reg <= 1'b1;
        end
    else begin
        w_ptr_reg <= w_ptr_next;
        r_ptr_reg <= r_ptr_next;
        full_reg <= full_next;
        empty_reg <= empty_next;
        end
    end


/*读命令：在读命令下，如果队列不为空，讲当前读指针的下一个指针赋值给读指针的下一个状态，同时将队列的满标志置0。
然后判断读指针的下一个指针是否和写指针的值一样。一样的话，说明，队列为空。否则不为空。 */
/*写命令：在写命令下，如果队列不为满，将当前写指针的下一个指针赋值给读指针的下一个状态，同时将队列的空标志置0。
然后判断写指针的下一个指针是否和读指针的值一样。一样的话，说明，队列为满。否则不为满。*/
/*读写命令：在读写命令下， 直接改变对应指针的下一个状态值。*/
//下一个状态的判定
always@(*)
    begin
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        full_next = full_reg;
        empty_next = empty;
        w_ptr_succ = w_ptr_reg + 1'b1;
        r_ptr_succ = r_ptr_reg + 1'b1;
        case( {wr,rd} )
            2'b01: begin
                if( ~empty_reg ) begin
                    r_ptr_next = r_ptr_succ;
                    full_next = 0;
                    if( r_ptr_succ == w_ptr_reg )
                        empty_next = 1'b1;
                    else
                        empty_next = 1'b0;
                    end
                end
            2'b10: begin
                if( ~full_reg ) begin
                    w_ptr_next = w_ptr_succ;
                    empty_next= 0;
                    if( w_ptr_succ == r_ptr_reg )
                        full_next = 1'b1;
                    else
                        full_next = 1'b0;
                    end
                end
            2'b11: begin
                if( ~full_reg && ~empty_reg ) begin
                    w_ptr_next = w_ptr_succ;
                    r_ptr_next = r_ptr_succ;
                    end
                else if( full_reg ) begin //在满的状态，不允许写
                    r_ptr_next = r_ptr_succ;
                    full_next = 0;
                    end
                else if( empty_reg ) begin //在空的状态，不允许写
                    w_ptr_next = w_ptr_succ;
                    empty_next = 0;
                    end
                end
        endcase
    end
endmodule
