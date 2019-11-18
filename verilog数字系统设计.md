### Problem 1：zero	

- 最简单的顶层文件

- ```verilog
  module top_module(
  	output zero
  );
  
  assign zero = 0;
  endmodule
  ```

### Problem 2：wire

- wire是verilog中的一种信号类型

  - wire 的中文可以翻译为导线，但 Verilog 中的 wire 和现实中的导线不同，wire 应该理解为一个**信号**，信号是有方向性的，wire 从 A 点输出，输入到 B 点和 C 点。wire 一般只有一个 source，即从某一点输出，但可以有多个 sinks，即输入到多个点。A 点通常会被称为一个驱动（driver），把某个值驱动到 wire 上。

- 把驱动的概念引进到 Verilog 中，可以写作：

  ```verilog
  assign left_side = right_side;
  ```

- right_side 的值就被驱动到 left_side 中，以上的语法结构名为**连续赋值**（continous assignment）。但请注意与软件中的赋值操作做区分，Verilog 中的赋值是使用一条带有方向的导线连接了两个信号，所以 left_side **始终等于** right_side，随 right_side 变化而变化。而软件中的赋值是一种事件，某个时刻 left_side 的值变成了和 right_side 相同的值。

- 模块中的端口也带有方向性，主要分为输入 input 和输出 output 端口。输入端口是由模块外部的信号驱动的，而输出端口则又会驱动另一个外部信号。如果我们通过一个模块来模拟 wire，那么从模块内部来看，输入端口就直接驱动输出端口。

-  **wire 是 Verilog 中的一种数据类型，代表的是信号，而不是连线。**

### Problem 2：wire4

- wire 的源一般只能有一个，终点确可以有多个。一个源可以驱动多个信号。本题中，我们要使用三个信号源 a,b,c 驱动四个信号 w,x,y,z.

  - a -> w
    b -> x
    b -> y
    c -> z

- 当你使用多条 assign 语句时，他们之间的顺序是无关紧要的，这点同顺序执行的软件代码不同。事实上，大部分 Verilog 代码之间的**顺序都不会对结果产生影响**。assign 描述的是端口之间的连接关系，而不是一次复制右值，赋给左值的复制黏贴，连接关系不存在先后之分。

- 我们一般这么声明端口信号

  ```verilog
  input a; 
  ```

  但实际上我们声明的是

  ```verilog
  input wire a;
  ```

  所以，assign 语句并不是创建 wire ，而是将创建 wire 之间的连接。

  ```verilog
  module top_module (
  	input a,
  	input b,
  	input c,
  	output w,
  	output x,
  	output y,
  	output z  );
  	
  	assign w = a;
  	assign x = b;
  	assign y = b;
  	assign z = c;
  	
  endmodule
  ```

- **wire 是信号，而 assign 语句则建立了信号之间的连接，这种连接是有方向性。**

### **Problem 4 :** Notgate

- 与 wire 模块相同，非门模块中 in 被连接到 out，相比 wire 模块，唯一的区别在于：输出信号 out 是将输入信号 in 取反得到。

- 我们在 assign 语句中增加的逻辑操作符为 ~（**逐位取反**），由于我们的信号位宽为 1 位，我们也可以使用！（**逻辑取反**）。二者的区别在于逻辑取反的结果始终只有一位，而逐位取反结果的位宽和输入信号位宽相同，在每一个位上逐位（bitwise）取反。

- ```verilog
  module top_module (
  	assign	out = ~ in;
  endmodule
  ```

- 非门在 wire 的模块上稍加改造，对 assign 语句添加逻辑运算符实现。

- 逻辑操作，逐位操作

### Problem 5，6，7，8：Andgate，Norgate，Xnorgate

- ~ 非逻辑的优先级大于 | 或。
- 但现在电路仍然比较简单，很容易描述出前一级的输出，但如果前一级的输出很复杂，那么要使用 assign 语句描述出两级电路的输入输出关系集合就比较困难。使用硬件描述语言的好处在于，你可以描述出前一个模块的输出，将其赋给中间信号，并将中间信号作为下一级信号的输入。这样，你**永远只需要一次描述一个模块**。

### **Problem 9 : 7458**

- 一种10输入2输出的芯片，包含与门和非门

### Problem 10：Vectors

- 什么是 Verilog 中的向量（vector）？向量是一组 wire 信号的集合，通过赋予这一组信号的集合一个名称，以便于访问其中的 wire 信号。

- 向量类似于总线，一般将向量视为位宽超过 1 位的 wire 信号，不是特别在意向量这个概念本身。

- wire [7:0] w ; 声明了一个 8 bit 位宽的信号，向量名为 w，等价于 8 个 1bit 位宽的 wire 信号。

  ```verilog
  assign w_0 = w[0]; //取出了向量中最低位的 wire 信号
  ```

- 如果你对 C 语言的数组非常熟悉的话，请注意声明向量时，位宽位于向量名之前。但在片选向量中某个 bit 时，使用的语法同 C 语言数组中取出某个数的语法相同。

  ```verilog
  wire [99:0] my_vector;      // Declare a 100-element vector 
  assign out = my_vector[10]; // Part-select one bit out of the vector 
  ```

- 在同时声明多个向量时，位宽对于声明的多个向量都是起作用的，比如：

  ```verilog
  wire [7:0] x,y;  //y 也被声明为位宽为 8 的向量
  ```

### **Problem 11 : Vector in more detail**

- 向量组合了多个相关 wire 信号，通过向量名可以更方便地访问向量中信号。

- **声明向量**：向量在声明时，必须遵循：

  ```text
  type [upper:lower] vector_name;
  //其中 type 指定了向量的类型，一般为 wire 或者 reg 型。
  //如果向量为模块的输入输出端口，那么可以在 type 中添加 input/output 定义。
  ```

- **举一堆栗子**

  ```verilog
  wire [7:0] w;         // 8-bit wire
  reg  [4:1] x;         // 4-bit reg
  output reg [0:0] y;   // 1-bit reg  output port (但仍然是一个向量)
  input wire [3:-2] z;  // 6-bit wire input (在位宽中使用负数作为 index 是可以的，代表倒数第二位)
  output [3:0] a;       // 4-bit output wire. wire 为默认定义，在没有显式声明的情况下
  wire [0:7] b;         // 8-bit wire b[0]是这个向量的 最高位 MSB（most-significant bit）
  ```

- 这里你需要了解一个向量的比特顺序（*endianness*）信息，比特顺序取决于向量的 LSB 是向量的高位还是地位。比如声明为 [3:0] w 的向量，LSB 是 w[0]，如果声明为 [0:3] w,那么 w[3] 是 LSB 。**LSB 指的是二进制数中权值最低的一位。**

- 在 Verilog 语法中，你可以将向量声明为 [3:0], 这种语法最为常见，但也可以将向量声明为 [0:3] 。这都是可以的，但必须在**声明和使用时保持一致**。如果声明为 wire [3:0] w ，但使用 w[0:3]赋值，这是不允许的。

- **保持前后如一的比特顺序是很重要的一点，一些你挠破头都定位不了的 BUG 可能就是字节顺序不一致导致的**

- **p1 ：变量隐式声明的危害**

  - 你知道吗，变量的隐式声明是 Verilog 中 BUG 的一大来源。
  - 信号变量有两种声明方式，一是使用 wire 或者 assign 语句进行显示声明和定义，二是综合器的隐式声明和定义。
  - 当你将一个未定义声明的信号连接到模块的输入输出端口时，综合器会“**热心**”地帮助你声明这个信号。但我可以向你保证，综合器没有厉害到能通过上下文，察言观色，“热心而正确”地帮你声明信号，它只会将其声明为 **1 bit wire 型信号**，当你本来需要使用一个超过 1 bit 的向量，但又忘记声明时，综合器往往就好心办坏事了。（当然综合器会在这个生成 Warning，所以查看下 Warning 是查找 BUG 的好办法）
  - 

  ```verilog
  wire [2:0] a, c;    // Two vectors 
  assign a = 3'b101;  // a = 101 
  assign b = a;       // b =   1  隐式声明并定于了 b
  wire assign c = b;  // c = 001  <-- bug 来了 b 被 coder 默认为和 a 相同的 3'b101，但其实 b 只有 1bit宽
  my_module i1 (d,e); // d e 都被隐式声明为 1bit wire
                      //如果模块期望的是 vector 那么 BUG 就产生了
  ```

  - 隐式声明的错误很容易在连接 IP 核的时候产生，从 IP 核模板文件复制来 IP 核模块后。往往会忘记声明连接 IP 模块之间的中间变量，而这些变量的隐式声明就可能被综合器“好心办了坏事”。
  - 通过添加 ``default_nettype none` 宏定义会关闭隐式声明功能，那么这样一来，使用未声明的变量就会变成一个 Error 而不再只是 Warning。

- **unpacked vs. packed 数组**

  - 在声明向量时，一般向量的位宽写在向量名之前。位宽定义了向量的 packed 维度，该向量中每位信号都被视作一个块进行操作（在仿真中，硬件中有所不同）。unpacked 维度定义在向量名之后，通常用来定义向量数组。（简单得说定义在向量名之前的是向量的位宽，定义在向量名之后的维度可以理解为向量数组的长度，同 C 语言中的数组长度概念相同，一般用来对存储器建模。）

  - ```verilog
    reg [7:0] mem [255:0];   // 256 unpacked elements, each of which is a 8-bit packed vector of reg.
    reg mem2 [28:0];         // 29 unpacked elements, each of which is a 1-bit reg.
    ```

    获取向量元素：片选

    通过向量名可以获得整个向量，在下方的 assign 语句中，向量名 a 代表了向量中的所有比特位信号

    ```verilog
    assign w = a;
    ```

  - 在 assign 赋值操作中，如果等号左右两侧信号的位宽不同，那么就会进行截断或者补零操作。

    - 左侧信号位宽**大于**右侧信号位宽，右值的低位赋予左值对应的低位，左值高位的部分**赋零**。

    - 左侧信号位宽**小于**右侧信号位宽，右值的低位赋予左值对应的低位，右值高位的部分直接被**截断**。即保留右值的低位。

    - 使用 [] 可以对信号进行片选，选择信号中特定几位比特，以下是一些片选的例子。

    ```verilog
    w[3:0]      // Only the lower 4 bits of w
    x[1]        // The lowest bit of x
    x[1:1]      // ...also the lowest bit of x
    z[-1:-2]    // Z 最低两位
    b[3:0]      // 如果 b 在声明时 声明为 wire [0:3] b;则不能使用 b [3:0]进行选择
    b[0:3]      // b的高四位.
    assign w[3:0] = b[0:3];    // 将 b 的高位赋予 w 的低位 w[3]=b[0], w[2]=b[1], etc.
    ```

  - ```verilog
    `default_nettype none     // Disable implicit nets. Reduces some types of bugs.
    module top_module( 
        input wire [15:0] in,
        output wire [7:0] out_hi,
        output wire [7:0] out_lo );
        assign out_hi = in[15:8];
        assign out_lo = in[7:0];
    endmodule
    ```

### **Problem 12 : Vector part select**

- ```verilog
  module top_module (
  	input [31:0] in,
  	output [31:0] out
  );
  
  	assign out[31:24] = in[ 7: 0];	
  	assign out[23:16] = in[15: 8];	
  	assign out[15: 8] = in[23:16];	
  	assign out[ 7: 0] = in[31:24];	
  	
  endmodule
  ```

### **Problem 13 : Bitwise operators**

- 逐位逻辑运算符(&)和逻辑运算符(&&)之间的差别

  - 逐位逻辑运算符：对于 N 比特输入向量之间的逻辑比较，会在 N 比特上**逐位**进行，并产生一个 N 比特长的运算结果。

  - 逻辑运算符：任何类型的输入都会被视作**布尔值**，*零*->**非**，*非零*->**真**，将布尔值进行逻辑比较后，输出一个 1 比特的结果。

- ```verilog
  module top_module( 
      input [2:0] a,
      input [2:0] b,
      output [2:0] out_or_bitwise,
      output out_or_logical,
      output [5:0] out_not
  );
      assign out_or_bitwise = a | b;
      assign out_or_logical = a || b;
  
      assign out_not[2:0] = ~a;	// Part-select on left side is o.
      assign out_not[5:3] = ~b;	//Assigning to [5:3] does not conflict with [2:0]
  endmodule
  ```

### **Problem 14 : Four-input gates**

- 分别构建一个 4 输入与门，或门以及异或门。
- 

```verilog
module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = & in;
    assign out_or  = | in;
    assign out_xor = ^ in;
endmodule
```

4 输入逻辑门，转换为 Verilog 的思想是将 4 个输入变量进行逻辑操作，得到 1 比特结果

```verilog
assign out_and = in[3] & in[2] & in[1] & in[0];
```

另一种写法使用缩减运算符的语法，和将位展开的写法相同，但更加简便，我们将在后续的课程中加以展开。