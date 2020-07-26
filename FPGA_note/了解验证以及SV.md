systemverilog可以做设计，验证，SVA（assertion，断言，用于时序检查）

验证的语言有很多，可以用c/c++，verilog/VHDL，opera，vera，e等

验证的方法学，ovm，uvm

断言：比如主机给从机发送req（请求信号），经过几拍，从机返回ack（应答信号）

使用verilog检查这样的经过几拍检测到ack

```verilog 
if(req == 1)
    cnt <= cnt+ 1'b1;

if(cnt == 10)
    if(ack ~= 1)
        	error;
```

验证：spec-->verification req--->test plan 计划-->UVM，各种门类

refmodel（c/c++）对比RTL代码

debug   回归测试，注意随机种子

code coverage   用工具收集

DUT，DUV

verilog中testbench功能

- 产生激励 generate stimulus
- 将激励输入到待测试设计（DUV design under verification）
- 获取相应（capture response）
- 检查相应的正确性（check the response for correctness）
- 根据验证目标评估验证进度（measure the progress against the overall verification goals ）

验证的核心是前四步，验证的难点是？

- 对一个待测试设计（DUT）产生什么样的激励
- 对于激励的响应是否正确





