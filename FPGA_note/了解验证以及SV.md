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

