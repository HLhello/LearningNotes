加（+）减（-）乘（*）除（/）

移位拼接  { }





逻辑与（&&），逻辑或（||），逻辑非（!）

逻辑值有真假，即结果只有0或者1

a = 4'b1011; b = 4'b0000;

wire c; c = a && b ====> c = 0;

a = 4'b1011; b = 4'b0001;

wire c; c = a && b ====> c = 1;

a = 4'b1011; b = 4'b0000;

wire [3:0]c; c = a & b ====> c = 0000;

a = 4'b1011; b = 4'b0110;

wire [3:0]c; c = a & b ====> c = 0010;

a = 4'b1000; b = 4'b0000;

wire c; c = a II b ====> c = 1;

a = 4'b1011; b = 4'b0000;

wire [3:0]c; c = a | b ====> c = 1011;

a = 4'b1011; b = 4'b0000;

wire [3:0]c; c = ~a  ====> c = 0100;

在always块中进行赋值的都必须是reg型的

 模块名与文件名必须一样

时钟信号生成

```verilog
initial clk = 1'b1;
always#10 clk = ~clk;
```





同步异步清零相关概念

同步异步相对于时钟信号，也就是说摸个信号是同步的还是异步的要看他发生变化时是不是按照时钟信号来的

同步清零相对于异步清零，对于资源的消耗是不同的

```verilog
//同步复位
always@(posedge clk )
    if(!rst)
        cnt <= 4'd0;
//异步复位
always@(posedge clk or negedge rst)
    if(!rst)
        cnt <= 4'd0;

```



task调用

task 是可以被综合的

initial也是可以被综合的，但是吧不经常使用



```verilog
`timescale 
task reset_sys；
    begin
        rst = 0;
        #200;
        rst = 0;
        #200;
    end
endtask

task uart_tx;
input [7:0]data;
begin
    uart_tx = 1;
    #1000;
    uart_tx = 0;
    #1000;
    
    uart_tx = data[0];
    #1000;
    uart_tx = data[1];
    #1000;
    uart_tx = data[2];
    #1000;
    uart_tx = data[3];
    #1000;
    uart_tx = data[4];
    #1000;
    uart_tx = data[5];
    #1000;
    uart_tx = data[6];
    #1000;
    uart_tx = data[7];
    #1000;
    
    uart_tx = 1;
    #1000;
end
endtask

initial begin 
    uart_tx (8'h12)
    uart_tx (8'h4)
end
```



下午任务：

使led按照1秒钟的速率进行翻转

使Led按照1秒钟的频率进行闪烁

代码

功能仿真

板级验证

非等占空比的信号产生方法

UART串口通信

通用异步收发传输器（universal asynchronous receivertransmitter）

是一种异步收发传输器，骑在数据发送时将并行数据转换成串行数据来传输，在数据接收时将接收到的串行数据转换成并行数据，可以实现全双工传输和接收。

标准 RS232，RS449，RS423等接口标准规范和总线标准规范

uart是异步串行通信口的接口标准和总线标准，他们规定了通信口的传输速率，连接特性

关键参数 

- 数据位，可选择位5,6,7,8；电脑只认标准的通信协议
- 波特率，300,1200,2400,9600,115200
- 起始位停止位加数据位共10bits的数据
-  

