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


