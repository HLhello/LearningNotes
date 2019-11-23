## 一

1. 设计定义
2. 模块划分，接口定义
3. 设计输入（verilog vhdl，sv）
4. 分析和综合（quartus，vivado，ise）
5. 功能仿真（modelsim）
6. IO分配，布局布线
7. 时序仿真
8. 配置文件的生成，配置（烧写）fpga
9. 在线调试（嵌入式逻辑分析仪）

wire

- wire型数据通常用来表示用以assign关键字指定的组合逻辑信号
- verilog程序模块中输入输出信号类型默认时自动定义为wire型
- wire型信号可以用作任何方程式的输入，也可以用作assign语句或实例原件的输出

reg

- reg型数据常用来表示always模块内的指定信号，常代表触发器
- 在时序逻辑always模块内被赋值的每一个信号都必须被定义为reg型
- reg型数据的默认初始值是不定值

## 二

1. 流水灯*.v代码输入

2. testbench文件

   1. ```verilog
      `testbench 1ns/1ps -->单位/精度
      #100-->延时100ns
      `testbench 10ns/1ps
      #100-->延时100*10ns
       0.1ns = 1ps，仿真精确到小数点后一位
      #100.1
      
      module tb_xxxxx;
          
          待测试模块
          
      endmodule  
      ```

## 三 block & nonblock

```verilog
module block_noblock(
    clk, 
    rst, 
    a,
    b,
    c,
    out
);
    input clk;
    input rst;
    input a,b,c;
    output [1:0] out;
    
    reg [1:0] d;
    
    always@(posedge clk)
        if(!rst)
            out = 2'd0;
    	
    
endmodule
```

## 四 state machine

1. 检测hello字符串
   - 1： 等待H的到来
     - 如果检测到H，进入状态2
     - 否则一直等待H的带来
   - 2：检测e
     - 如果检测到e，进入状态3
     - 否则回到状态1
   - 3：检测l
     - 如果检测到l，进入状态4
     - 否则回到状态1
   - 4：检测l
     - 如果检测到l，进入状态5
     - 否则回到状态1
   - 5：检测o
     - 如果检测到o，LED翻转，同时回到状态1
     - 否则直接回到状态1
2. 

```verilog
module checkhello(
	clk,
    rst,
    data_in,
    led
);
    input clk;
    input rst;
    input data_in;
    output led;
    //独热码
    parameter check_H = 5'b00001;
    parameter check_e = 5'b00010;
    parameter check_l1 = 5'b00100;
    parameter check_l2 = 5'b01000;
    parameter check_o = 5'b10000;
    reg [2:0]state;
    always@(posedge clk)
        if(!rst)
            state <= check_H;
    	else begin
            case(state)
                check_H:
                    if(data_in=="H") 
                    	state<=check_e;
                	else 
                        state<=check_H;
                check_e:
                    if(data_in=="e") 
                    	state<=check_l1;
                	else 
                        state<=check_H;
                check_l1:
                    if(data_in=="l") 
                    	state<=check_l2;
                	else 
                        state<=check_H;
                check_l2:
                    if(data_in=="l") 
                    	state<=check_o;
                	else 
                        state<=check_H;
                check_o:begin
                    state<=check_H;
                    if(data_in=="o")
                        led <= ~led;
                	else 
                        led <= led;
                end
                default:  state <= check_H;
            endcase 
        end
endmodule  
    
```

3. 一段式状态机，两段式状态机，三段式状态机



4. 同步状态机的原理结构和设计

   1. 下一状态 = F（当前状态，输入信号）
   2. 输出信号 = G（当前状态，输入信号）mealy状态机

   - mealy状态机：时序逻辑的输出不但取决于状态还取决于输入，大部分都是mealy状态机
   - moore状态机：时序逻辑电路的输出只取决于当前状态

## 五 pll

1. phase-locked loop
   1. 相位锁定的环路，也就是常说的锁相环，锁相环在模拟电路和数字电路系统中均有广泛的应用，很多mcu芯片如stm32，msp430，等都集成了片上的pll，用来通过片外较低频率的晶振产生的时钟倍频得到较高频率的时钟信号以供mcu内核和片上的外设使用，在很多的洗衣芯片中也用到得了pll来通过较低的晶振时钟得到符合协议要求的时钟信号，例如典型的usb协议芯片

