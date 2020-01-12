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

- 4 输入逻辑门，转换为 Verilog 的思想是将 4 个输入变量进行逻辑操作，得到 1 比特结果

```verilog
assign out_and = in[3] & in[2] & in[1] & in[0];
```

- 另一种写法使用缩减运算符的语法，和将位展开的写法相同，但更加简便，我们将在后续的课程中加以展开。

### **Problem 15 : Vector concatenation operator**

- 片选操作符用于选择向量的一部分比特。而连接操作符 { a,b,c }，将较小的向量连接在一起，用于创建更大的向量。连接操作符是一个很常用的运算符。下面举些例子：

- ```verilog
  {3'b111, 3'b000} => 6'b111000
  {1'b1, 1'b0, 3'b101} => 5'b10101
  {4'ha, 4'd10} => 8'b10101010     // 4'ha and 4'd10 are both 4'b1010 in binary
  ```

- 连接操作符的基本语法使用 **{ }** 将较小的向量括起来，每个 { } 内的向量使用**逗号**作为间隔。

- 连接运算符中的向量**务必需要标注位宽**，不然综合器怎么能知道你的结果需要多宽的位宽。因此 { 1,2,3 } 这样的操作是非法的，并会产生一个 Error：unsized constants are not allowed in concatenations.

- 习惯上，我们会把位连接符用在赋值语句的右侧，表示将较小的向量连接成较大的向量，赋予左值。但实际上位连接符同样可以用在赋值语句左侧，比如：

- ```verilog
  assign {cout,sum} = a + b + cin;
  ```

- 在表示全加器时，可以使用一句 assign 语句实现结果和进位的赋值。再看一些 HDLBits 上的栗子：

  ```verilog
  input [15:0] in;
  output [23:0] out;
  // 连接符用于赋值语句左侧，交换了字节的顺序
  assign {out[7:0], out[15:8]} = in;
  // 连接符用于赋值语句右侧，交换了字节的顺序
  assign out[15:0] = {in[7:0], in[15:8]}; 
  // 此语句作用上与上两句相同交换了字节顺序，但不同的是赋值语句右侧为16位
  assign out = {in[7:0], in[15:8]};
  //赋予左值后，右值扩展为24位，高8位赋零，前两句中，高8位为未赋值状态 
  ```

### **Problem 16 : Replication operator**

- 连接操作符允许我们将短小的向量连接在一起构成更宽的向量。很方便，但有的时候需要将多个重复的向量连接在一起，诸如 assign a = {b,b,b,b,b,b}; 这样的语句写多了是非常让人忧愁的。而重复操作符语法就可以在这种情况下帮到你，允许你将一个向量重复多次，并将它们连接在一起，语法是这样：{ 重复次数 { 向量 } }。

- 重复次数必须是一个常量，而且请特别注意重复操作符**有两对 { }**.外层的 {} 不能少。

- ```verilog
  {5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
  {2{a,b,c}}          // The same as {a,b,c,a,b,c}
  {3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
                      // the second vector, which is two copies of 3'b110.
  ```

- 如果写成 {3'd5, 2{3'd6}} ,少了一对 {} 是错误的。

### **Problem 17 : More Replication**

- 例题，将5bit数组成25位数，将 5 个 1bit 信号分别组成两个 25 bit 信号，输出向量为这两个 25bit 向量的逐位操作的结果。如果两个待比较信号某比特相同，则结果向量对应的该比特位 1 。即：

- out[24] = ~a ^ a; // a == a, so out[24] is always 1.
  out[23] = ~a ^ b;
  out[22] = ~a ^ c;
  ...
  out[ 1] = ~e ^ d;
  out[ 0] = ~e ^ e;

- ```verilog
  module top_module (
      input a, b, c, d, e,
      output [24:0] out );//
  
      // The output is XNOR of two vectors created by 
      // concatenating and replicating the five inputs.
      // assign out = ~{ ... } ^ { ... };
      assign out = ~{{5{a}},{5{b}},{5{c}},{5{d}},{5{e}}} ^ {{5{a,b,c,d,e}}};
  endmodule
  ```

### **Problem 18  : Vector reversal 1**

- 应为problem16
- 没看懂， TODO

### **Problem 19 : Modules**

- 本题开始，我们将讨论一早我们就见识但还没有深入了解的概念：模块。

- 截止目前，我们已经对 Verilog 中模块这一概念建立了初步的印象：模块是一个电路，通过输入输出端口和外部的电路联系。无论多大，多复杂的数字电路都是由一个个模块以及其他组成部分（比如 assign 赋值语句以及 always 过程块）互相连接所构成的。在一个模块中可以例化下一级的模块，这就形成了层级的概念（hierarchy）。

- 当你从顶层模块的角度看去，下层模块对你来说就是一个黑盒子，盒子里的内容并不重要。重要的是模块的输入输出端口。

- 模块中可以例化其他模块，但在模块中不允许再定义其他模块。这项语法规则类似于在 C 语言函数中可以调用其他函数，但不能定义其他函数。

- **模块信号连接的两种方式**

  - 在实例化模块时，有两种常用的方式来进行模块端口的信号连接：按端口顺序以及按端口名称连接端口。

  - **按端口顺序**，`mod_a instance1 ( wa, wb, wc ); `wa, wb, wc 分别连接到模块的 第一个端口（in1），第二个端口（in2）以及第三个端口（out）。这里所谓的端口顺序指的是模块端口的定义顺序。这种方式的弊端在于，一旦端口列表发生改变，所有模块实例化中的端口连接都需要改变。

  - **按端口名称**，`mod_a instance2 ( .out(wc), .in1(wa), .in2(wb) ); `在这种方式中根据端口名称指定外部信号的连接。这样一来就和端口声明的顺序完全没有关系。一旦模块出现改动，只要修改相应的部分即可。实际上，一般都使用这种方式来进行模块实例化。

- ```verilog
  module top_module ( input a, input b, output out );
          mod_a U_mod_a(
            .in1(a)
          , .in2(b)
          , .out(out));
      //mod_a U_mod_a(a, .b, out); //使用按照端口顺序的方式 声明信号连接
  endmodule
  ```

- 本题中同时使用了两种方式定义了端口的信号连接，实际上按照端口名称连接的方式用得更多，因为更加容易处理模块端口列表的变动。

- 值得注意的是，在实例化模块时，一般一个端口用一行表示，这样更直观一些。至于逗号放在前面还是放在后面，那倒无所谓。但我看过 NVIDIA 的开源代码将逗号放在前面之后，觉得这样挺好的，故也就这么写了。

### **Problem 20: Connecting ports by position(Module pos)**

- ```verilog
  module mod_a ( output, output, input, input, input, input );
  ```

- ```verilog
  module top_module ( 
      input a, 
      input b, 
      input c,
      input d,
      output out1,
      output out2
  );
  
      mod_a name(out1,out2,a,b,c,d);
      
  endmodule
  ```

### **Problem 21: Connecting ports by name(Module name)**

- ```verilog
  module mod_a ( output out1, output out2, input in1, input in2, input in3, input in4);
  ```

- ```verilog
  module top_module ( 
      input a, 
      input b, 
      input c,
      input d,
      output out1,
      output out2
  );
  
      mod_a name(
          .out1(out1),
          .out2(out2),
          .in1(a),
          .in2(b),
          .in3(c),
          .in4(d));
      
  endmodule
  ```

### **Problem 22: Three modules(Module shift)**

- 给出了一个名为my_dff的模块，包含两个输入和一个输出(实现D触发器的功能)。实例化三个my_dff，然后将它们连接在一起，构成长度为3的移位寄存器。注意：clk端口需要连接到所有的寄存器实例上。

- ```verilog
  module my_dff ( input clk, input d, output q );
  ```

- ```verilog
  module top_module (
  	input clk,
  	input d,
  	output q
  );
  
  	wire a, b;	// 声明两个wire变量，命名为a, b
  
  	// 对my_dff进行了三次实例化，用了三个不用的名字 (d1, d2, and d3).
  	// 端口使用了位置连接的方式( input clk, input d, output q)
  	my_dff d1 ( clk, d, a );
  	my_dff d2 ( clk, a, b );
  	my_dff d3 ( clk, b, q );
  
  endmodule
  ```

### **Problem 23: Modules and vectors(Module shift8)**

- ```verilog
  module my_dff8 ( input clk, input [7:0] d, output [7:0] q );
  //该模块为一个8bit数据寄存器，将输入的数据在下一时钟输出
  ```

- ```verilog
  module top_module (
  	input clk,
  	input [7:0] d,
  	input [1:0] sel,
  	output reg [7:0] q
  );
  
  	wire [7:0] o1, o2, o3;		// 声明每一个触发器的输出
  	
  	// Instantiate three my_dff8s
  	my_dff8 d1 ( clk, d, o1 );
  	my_dff8 d2 ( clk, o1, o2 );
  	my_dff8 d3 ( clk, o2, o3 );
  
  	// 这是实现4选1选择器的一种方法
  	always @(*)		// 组合逻辑always块
  		case(sel)
  			2'h0: q = d;
  			2'h1: q = o1;
  			2'h2: q = o2;
  			2'h3: q = o3;
  		endcase
  
  endmodule//该模块的功能是？
  ```

### **Problem 24，25 ，26 : Adder 1(Module add)**，**Adder 2(Module fadd)**，**Carry-select adder (Module cseladd)**

- 设计三中类型的加法器TODO

### **Problem 27: Adder–subtractor (Module addsub)**

- 根据加法器设计减法器TODO

### **Problem 28: Always blocks(combinational) (Alwaysblock1)**

- 我们知道数字电路是由导线连接的逻辑门组成，因此任何电路都可以表示为module和assign语句的某种组合。但是，有时候这不是描述电路最简便的方法。过程块(比如always块)提供了一种用于替代assign语句描述电路的方法。

- 有两种always块是可以综合出电路硬件的：

  - ```verilog
    组合逻辑：always @(*)
    时序逻辑：always @(posedge clk)
    ```

  - 组合always块相当于assign语句，因此组合电路存在两种表达方法。具体使用哪个主要取决于使用哪个更方便。**过程块内的代码与外部的assign代码不同**。过程块中可以使用更丰富的语句(比如if-then,case)，但不能包含连续赋值。但也引入了一些非直观的错误。(*过程连续赋值确实可以存在，但与连续赋值有些不同，并且不可综合)

  - 例如，assign和组合always块描述相同的电路。两者均创造出了相同的组合逻辑电路。只要任何输入(右侧)改变值，两者都将重新计算输出。

    - ```verilog
      assign out1 = a & b | c ^ d;
      always @(*) out2 = a & b | c ^ d;
      ```

  - 对于组合always块，敏感变量列表总是使用(*)。如果把所有的输入都列出来也是可以的，但容易出错的(可能少列出了一个)，并且在硬件综合时会忽略您少列了一个，仍按原电路综合。 但仿真器将会按少列一个来仿真，这导致了仿真与硬件不匹配。(在SystemVerilog中，使用always_comb)

  - 使用assign语句和组合always块来构建与门。

  - ```verilog
    // synthesis verilog_input_version verilog_2001
    module top_module(
        input a, 
        input b,
        output wire out_assign,
        output reg out_alwaysblock
    );
    
        assign out_assign = a & b;
        
        always@(*)
            out_alwaysblock = a & b;
        
    endmodule
    ```

### **Problem 29: Always blocks(clocked) (Alwaysblock2)**

- 时序always块也会像组合always块一样生成一系列的组合电路，但同时在组合逻辑的输出生成了一组触发器(或寄存器)。该输出在下一个时钟上升沿(posedge clk)后可见，而不是之前的立即可见。

- **阻塞赋值和非阻塞赋值**

  - ```verilog
    连续赋值(assign x=y;)：不能在过程块内使用；过程阻塞赋值(x=y;)：只能在过程块中使用；
    过程非阻塞赋值(x<=y)：只能在过程块内使用。
    ```

  - 在组合always块中，使用阻塞赋值。

  - 在时序always块中，使用非阻塞性赋值。

  - 记住组合用阻塞性，时序用非阻塞性就可以了

  - 具体为什么对设计硬件用处不大，还需要理解Verilog模拟器如何跟踪事件，但不遵循此规则会导致极难发现非确定性错误，并且在仿真和综合出来的硬件之间存在差异。

- 使用assign语句，组合always块和时序always块这三种方式来构建异或门。 请注意，时钟always块生成了与另外两个不同的电路，多了一个触发器，因此输出会有一定的延迟。

  - ```verilog
    module top_module(
        input clk,
        input a,
        input b,
        output wire out_assign,
        output reg out_always_comb,
        output reg out_always_ff   
    );
        assign out_assign = a ^ b;
        always@(*) 
            out_always_comb = a ^ b;
        always@(posedge clk) 
            out_always_ff <= a ^ b;
    endmodule
    ```

### **Problem 30: If statement(Always if)**

- if语句通常对应一个二选一多路复用器，如果条件为真，则选择其中一个输入作为输出；反之如果条件为假，则选择另一个输入所谓输出。if语句必须在过程块内使用。

- 下面给出了一个基本的if语句和其综合出来的电路。

  - ```verilog
    always @(*) begin
        if (condition) begin
            out = x;
        end
        else begin
            out = y;
        end
    end
    //等价于下面这句话
    assign out = (condition) ? x : y;
    ```

### **Problem 31: If statement latches(Always if2)**

- **常见的错误来源：如何避免引入锁存器**

  在设计电路时，必须首先具体考虑电路：

  1、我想实现一个逻辑门；

  2、我想实现一个具有输入并产生输出的组合逻辑块；

  3、我想实现一组组合逻辑，紧接着一组触发器。

- 除了你指定的情况以外，会发生些什么，答案是什么也不会发生。输出保持不变，输出保持不变，这就意味着电路需要记住当前状态，从而产生锁存器。组合逻辑(比如逻辑门)不能记住任何状态。而这往往就导致了电路的错误，所以说语法正确的代码不一定能产生合理的电路(组合逻辑+触发器)。

- 上述这类情况下的错误，除非锁存器是故意生成的。组合电路输出必须在所有输入的情况下都有值。这意味着必须需要else子句或着输出默认值。

- ```verilog
  //******latches******************************************
  always @(*) begin
      if (cpu_overheated)
         shut_off_computer = 1;
  end
  //*******比较上下两种情况*********************************
  always @(*) begin
      if (cpu_overheated)
          shut_off_computer = 1;
      else
          shut_off_computer = 0;
  end
  
  //******latches******************************************
  always @(*) begin
      if (~arrived)
         keep_driving = ~gas_tank_empty;
  end
  //*******比较上下两种情况*********************************
      always @(*) begin
          if (~arrived)
              keep_driving = ~gas_tank_empty;
          else
              keep_driving = ~arrived;
      end
  ```

### **Problem 32: Casestatement(Always case)**

- Verilog中的case语句**几乎**等同于if-else if-else序列，它将一个表达式与其他表达式列表进行比较。它的语法和功能与C语言中的switch语句稍有不同：

  - ```verilog
    always @(*) begin     // This is a combinational circuit
        case (in)
          1'b1: begin 
                   out = 1'b1;  // begin-end if >1 statement
                end
          1'b0:    out = 1'b0;
          default: out = 1'bx;
        endcase
    end
    ```

  - 1、case语句以case开头，每个case项以冒号结束。而switch语句没有。

  - 2、每个case项只执行一个语句。 这样就不需要C语言中break来跳出switch。但这也意味着如果您需要多个语句，则必须使用begin ... end。

  - 3、case项允许重复和部分重叠，执行程序匹配到的第一个，而C语言不允许重复的case项目。

- 如果存在大量的case项，则case语句比if语句更方便。 因此，在本练习中，创建一个6选1的多路复用器。当sel介于0和5之间时，选择相应的数据输入。 其他情况输出0。数据输入和输出均为4位宽。

- **注意：不要生成锁存器(详见：Problem 31: If statement latches(Always if2))。**

- ```verilog
  // synthesis verilog_input_version verilog_2001
  module top_module ( 
      input [2:0] sel, 
      input [3:0] data0,
      input [3:0] data1,
      input [3:0] data2,
      input [3:0] data3,
      input [3:0] data4,
      input [3:0] data5,
      output reg [3:0] out   
  );
      always@(*) begin  // This is a combinational circuit
          case(sel)
          3'b000: out = data0;
          3'b001: out = data1;
          3'b010: out = data2;
          3'b011: out = data3;
          3'b100: out = data4;
          3'b101: out = data5;
          default: out = 4'b0000;
          //注意这里一定要用default声明一下不在case项里的输出，否则会生成不必要的寄存器，影响电路的功能
          endcase
      end
  
  endmodule
  ```

### **Problem 33: Priority encoder(Always case2)**

- ```verilog
  // synthesis verilog_input_version verilog_2001
  module top_module (
      input [3:0] in,
      output reg [1:0] pos);
  
  always@(*)
      case(in)
      4'b0000: pos = 2'b00;
      4'b0001: pos = 2'b00;
      4'b0010: pos = 2'b01;
      4'b0011: pos = 2'b00;
      4'b0100: pos = 2'b10;
      4'b0101: pos = 2'b00;
      4'b0110: pos = 2'b01;
      4'b0111: pos = 2'b00;
      4'b1000: pos = 2'b11;
      4'b1001: pos = 2'b00;
      4'b1010: pos = 2'b01;
      4'b1011: pos = 2'b00;
      4'b1100: pos = 2'b10;
      4'b1101: pos = 2'b00;
      4'b1110: pos = 2'b01;
      4'b1111: pos = 2'b00;
      default: pos = 2'b00;
      endcase
  
  endmodule
  ```

### **Problem 34: Priority encoder with casez(Always casez)**

- 如果case语句中的case项与某些输入无关，就可以减少列出的case项(在本题中减少到9个)。这就是casez的用途：它在比较中将具有值z的位视为无关项(即输入01都会匹配到)。
- case项是按顺序检查的(实际上，它更像是生成一个巨大的真值表然后生成超大的门)。注意有输入(例如，4'b1111)匹配多个case项。选择第一个匹配(因此4'b1111匹配第一个case项，out = 0)。
- 还有一个类似的casex，将输入的x和z都视为无关。不认为casex比casez有什么特别的好处。(作者个人感觉没必要用casex，z和x状态的问题涉及电路的基本知识)
- 符号"?" 是z的同义词，所以2'bz0与2'b?0相同。

- ```verilog
  always @(*) begin
      casez (in[3:0])
          4'bzzz1: out = 0;   // in[3:1]输入什么都可以
          4'bzz1z: out = 1;
          4'bz1zz: out = 2;
          4'b1zzz: out = 3;
          default: out = 0;
      endcase
  end
  ```

### **Problem 35: Always nolatches(Always nolatches)**

- ```verilog
  module top_module (
      input [15:0] scancode,
      output reg left,
      output reg down,
      output reg right,
      output reg up  ); 
  
  always@(*)
      casez(scancode)
          16'he06b: begin up = 1'b0; down = 1'b0; left = 1'b1; right = 1'b0; end
          16'he072: begin up = 1'b0; down = 1'b1; left = 1'b0; right = 1'b0; end
          16'he074: begin up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b1; end
          16'he075: begin up = 1'b1; down = 1'b0; left = 1'b0; right = 1'b0; end
          default:  begin up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0; end
      endcase
  
  endmodule
  ```

- ```verilog
  module top_module (
      input [15:0] scancode,
      output reg left,
      output reg down,
      output reg right,
      output reg up  ); 
  
  always@(*)
  begin
      up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0;
      casez(scancode)
          16'he06b: left = 1'b1;
          16'he072: down = 1'b1;
          16'he074: right = 1'b1; 
          16'he075: up = 1'b1;
      endcase 
  end
  //会报一个没有default的警告，但是两者电路都一样，因为都设置了所有情况的默认值
  endmodule
  ```

### **Problem 36: Conditional ternary operator(Conditional)**

- Verilog跟C语言一样有一个三元运算符( ? : )。

  - ```verilog
    condition ? if_true : if_false
    ```

- 举个栗子：

  - ```verilog
    (0 ? 3 : 5)     // 输出是5，因为条件"0"始终是false的
    (sel ? b : a)   // 一个二选一MUX，通过sel的值选择a或者b
    
    always @(posedge clk)         // 一个T触发器
      q <= toggle ? ~q : q;
    
    always @(*)                   // 一输入的状态转换逻辑
        A: next = w ? B : A;
        B: next = w ? A : B;
      endcase
    
    assign out = ena ? q : 1'bz;  // 三态缓冲器
    // 一个三选一MUX
    ((sel[1:0] == 2'h0) ? a : (sel[1:0] == 2'h1) ? b : c )
    ```

### **Problem 37: Reduction operators(Reduction)**

- 归约运算符，对一个向量的所有位进行操作，如(a[0]&a[1]&a[2]&a[3]...)，对于长的标量来说，这很麻烦。

- 归约运算符(Reduction Operators)可以对向量的每一位位进行AND，OR和XOR，产生一位输出：

  ```text
  &a [3：0] // AND:a[3]&a[2]&a[1]&a [0]相当于(a[3：0]== 4'hf)
  |b [3：0] // OR: b[3]|b[2]|b[1]|b [0]相当于(b[3：0]!= 4'h0)
  ^c [2：0] // XOR:c[2]^c[1]^c[0]
  ```

- ```verilog
  module top_module (
      input [7:0] in,
      output parity); 
  
      assign parity = ^in;
      
  endmodule
  ```

- 奇偶校验是检验传输数据中1的个数，当然有奇数有偶数，，这时候就需要用我们的校验位了，通过检验位将传输1的个数变成奇数就是奇校验，变成偶数就是偶校验。比如：

  ```text
  8'b01100100   //原数据
  9'b01100100_0 //奇校验
  9'b01100100_1 //偶校验
  ```

### **Problem 38: Reduction: Even wider gates(Gates100)**

- ```verilog
  module top_module( 
      input [99:0] in,
      output out_and,
      output out_or,
      output out_xor 
  );
      
      assign out_and = & in;
      assign out_or  = | in;
      assign out_xor = ^ in;
  
  endmodule
  ```

### **Problem 39: Combinational for-loop: Vector reversal2(Vector100r)**

- Problem 18，我感觉这两个问题的语句都不能综合

### **Problem 40 Combinational for-loop: 255-bit population count**

- 能不能被综合？？？**TODO**

### **Problem 41 Generate for-loop: 100-bit binary adder 2**

- **TODO**

### **Problem 42 Generate for-loop: 100-digit BCD adder**

- 生成语句可以动态的生成verilog代码，当对矢量中的多个位进行重复操作时，或者当进行多个模块的实例引用的重复操作时，或者根据参数的定义来确定程序中是否应该包含某段Verilog代码的时候，使用生成语句能大大简化程序的编写过程。

- 使用关键字generate 与 endgenerate来指定范围。generate语句有generate-for、generate-if、generate-case三种语句，本题中我们使用generate-for语句。

- generate-for语句：

  - **（1） 必须有genvar关键字定义for语句的变量。**
  - **（2）for语句的内容必须加begin和end（即使就一句）。**
  - **（3）for语句必须有个名字。**

- 举个栗子

  - ```verilog
    //创建一个2进制转换器
    Module gray2bin
    #(parameter SIZE = 8)
    (
      input [SIZE-1:0] gray,
      output [SIZE-1:0] bin
    )；
    genvar gi;  //在generate语句中采用genvar声明
        generate
        for (gi=0; gi<SIZE; gi=gi+1) 
            begin : genbit    //for语句必须有名字
                assign bin[i] = ^gray[SIZE-1:gi];
            end
        endgenerate 
    endmodule
    ```

- ```verilog
  module top_module( 
      input [399:0] a, b,
      input cin,
      output cout,
      output [399:0] sum 
  	);
  wire [399:0] cout_temp;
  //与上题同理，还是先计算cout[0],我声明一个wire型的cout_temp来存放每次计算后cout的值。
  bcd_fadd inst1_bcd_fadd (
      .a(a[3:0]),
      .b(b[3:0]),
      .cin(cin),
      .cout(cout_temp[0]),
      .sum(sum[3:0])
      );
  genvar i;
  generate
  	for(i=4; i<400; i=i+4)
  		begin: bcd
  			bcd_fadd inst_bcd_fadd(
                  .a(a[i+3:i]), 
                  .b(b[i+3:i]), 
                  .cin(cout_temp[i-4]), //上次计算输出的cout
                  .cout(cout_temp[i]), //本次计算输出的cout，在下次计算中变为cin
                  .sum(sum[i+3:i])
  		);
  	end
  endgenerate 
      
  assign cout = cout_temp[396];   
  
  endmodule
  ```

### **Problem 43 Wire**

- ```verilog
  module top_module (
      input in,
      output out);
   assign out = in;//wire型输出
  endmodule
  ```

### **Problem 44 GND**

- ```verilog
  module top_module (
      output out);
      assign out = 1'b0;//接地
  endmodule
  ```

### **Problem 45 NOR**

- ```verilog
  module top_module (
      input in1,
      input in2,
      output out);
  // 一个或非门
  assign out = ~(in1 | in2);
  
  endmodule
  ```

### **Problem 46 Another gate**

- ```verilog
  module top_module (
      input in1,
      input in2,
      output out);
  //一个与门，但输入in2需要取反。
  assign out = in1 & (~in2);
  
  endmodule
  ```

### **Problem 47 Two gates**

- ```verilog
  module top_module (
      input in1,
      input in2,
      input in3,
      output out);
  
      wire temp;
  	// 一个异或门，一个同或门，声明一个wire型的temp来存放同或门的输出。
      assign temp = in1 ^~ in2;
      assign out = temp ^ in3;
  
  endmodule
  ```

### **Problem 48 More logic gates**

- ```verilog
  //Module Declaration
  module top_module( 
      input a, b,
      output out_and,
      output out_or,
      output out_xor,
      output out_nand,
      output out_nor,
      output out_xnor,
      output out_anotb
  );
      assign out_and = a & b;
      assign out_or  = a | b;
      assign out_xor = a ^ b;
      assign out_nand = ~(a & b);
      assign out_nor = ~(a | b);
      assign out_xnor = ~(a ^ b);
      assign out_anotb = a & (~b);
  
  endmodule
  ```

### **Problem 49 : 7420 chip**

-  7420 chip是拥有两组4输入的与非门芯片

- ```verilog
  module top_module
      (
          input  p1a, p1b, p1c, p1d,
          output p1y,
          input  p2a, p2b, p2c, p2d,
          output p2y
      );
  
      assign p1y = ~(p1a & p1b & p1c & p1d);
      assign p2y = ~(p2a & p2b & p2c & p2d);
  
  endmodule
  ```

### **Problem 50 Truth tables **

- 真值表
-  在前面的练习中，我们使用简单的逻辑门和多个逻辑门的组合。这些电路是组合电路的例子。组合意味着电路的输出只是其输入的函数（在数学意义上）。这意味着对于任何给定的输入值，只有一个可能的输出值。因此，描述组合函数行为的一种方法是显式地列出输入的每个可能值的输出应该是什么。这是一张真值表。
-  对于n个输入的布尔函数，有2n个可能的输入组合。真值表的每一行列出一个输入组合，因此总是有2n行。输出列显示每个输入值的输出应该是什么。

### **Problem 54 Combine circuits A and B**

- ```verilog
  //Module Declaration
  module top_module
  (
      input x, 
      input y, 
      output z
  );
  
  wire z1, z2, z3, z4;
  //就是一个简单的电路，看懂是什么意思就行
  assign z1 = (x^y) & x;//^按位异或,&按位与
  assign z2 = x ^~ y;//按位同或
  assign z3 = (x^y) & x;
  assign z4 = x ^~ y;
  
  assign z = (z1 | z2) ^ (z2 & z3);
  
  endmodule
  ```

### **Problem 55 Ring or vibrate**

- 软硬件编程思路
  - 一般进行软件编程时，我们是先关注输入( if (input are _))，再关注输出( then (output are ))。
  - **而在硬件编程时，我们需要转变思维方式，在确保输出是正确的情况下，再思考输入。( The (output should be _) when (inputs are __))。**
  - **能够思考和转换两种风格是硬件设计所需的最重要技能之一。**

- 设计一个电路

  -  假设你正在设计一个电路来控制手机的振铃器和振动电机。当手机来电时(input ring)，电路必须把震动( output motor = 1 )或响铃( output ringer = 1 )打开，但不能同时打开。当手机处于震动模式时( input vibrate = 1 )，则打开震动( output motor = 1 )。否则打开响铃。

  - 要求：仅使用assign语句来实现该组合电路。

  - ```verilog
    //Module Declaration
    module top_module (
        input ring,
        input vibrate_mode,
        output ringer,       // Make sound
        output motor         // Vibrate
    );
        assign motor = ring & vibrate_mode;
        assign ringer  = ring & (!vibrate_mode);
    endmodule
    ```

### **Problem 56 Thermostat**

- Thermostat，恒温器。

- 设计一个电路，根据需要打开和关闭加热器、空调和鼓风机风扇。

  - 要求：恒温器可以处于两种模式之一：制热（mode = 1）和制冷（mode = 0）。在制热模式下，当温度过低时（too_cold = 1），打开加热器，但不要使用空调。在制冷模式下，当温度过高（too_hot = 1）打开空调，但不要打开加热器。当加热器或空调打开时，也打开风扇使空气循环。此外，即使加热器和空调关闭，用户也可以请求将风扇打开（fan_on = 1）。

  - ```verilog
    module top_module
    (
        input too_cold,
        input too_hot,
        input mode,
        input fan_on,
        output heater,
        output aircon,
        output fan
    );
    
    assign heater = mode  & too_cold;
    assign aircon = !mode & too_hot;
    assign fan    = (mode & too_cold) | (!mode & too_hot) | fan_on;
    
    endmodule
    ```

### **Problem 57 3-bit population count**

-  设计一个电路来计算输入中 ‘ 1 ’ 个数。需要使用for循环，TODO

### **Problem 58 Gates and vectors**

-  有一个4bit输入的电路，我们需要了解4bit输入数据之间的关系。

  - **out_both**: 输入的每一个bit均需要检测该bit位与其左侧（即高比特位）是否全为 ‘ 1 ’ 。 示例： `out_both[2]`应检测`in[2]` 与 `in[3]` 是否均为 ‘ 1 ’ 。因为`in[3]` 为输入的最高位，故我们无需检测`out_both[3]`

  - **out_any**: 输入的每一个bit均需要检测该bit位与其右侧（即低比特位）两者其中一个为 ‘ 1 ’ 。 示例： `out_any[2]`应检测`in[2]` 与 `in[1]` 两者其中一个为 ‘ 1 ’ 。因为`in[0]` 为输入的最低位，故我们无需检测`out_any[0]`

  - **out_different**: 输入的每一个bit均需要检测该bit位与其左侧（即高比特位）两者是否不同。 示例： `out_different[2]`应检测`in[2]` 与 `in[3]` 两者是否不同 。在本节中，我们将输入变成一个环，所以`in[3]`的左侧为`in[0]`。

  - ```verilog
    module top_module( 
        input [3:0] in,
        output [2:0] out_both,
        output [3:1] out_any,
        output [3:0] out_different);
    
        assign out_both      = {{in[3] & in[2]}, {in[2] & in[1]}, {in[1] & in[0]}};
        assign out_any       = {{in[3] | in[2]} , {in[2] | in[1]} , {in[1] | in[0]}};
        assign out_different = {{in[0] ^ in[3]}, {in[3] ^ in[2]}, {in[2] ^ in[1]}, {in[1] ^ in[0]}};
    
    endmodule
    ```

### **Problem 59 Even longer vectors**

- 将problem58输入从4bit改成100bit

- ```verilog
  module top_module( 
      input [99:0] in,
      output [98:0] out_both,
      output [99:1] out_any,
      output [99:0] out_different );
  
      assign out_both = in[98:0] & in[99:1];
      assign out_any  = in[99:1] | in[98:0];
      assign out_different = in ^ {in[0],in[99:1]};
  
  endmodule
  ```

### **Problem 60 : 2-to-1 multiplexer (Mux2to1)**

- 选择器是一个使用频次很高的模块，选择器从多个输入数据流中选取一个输出到公共的输出端。在综合的过程中一些 Verilog 语法会显式地被"翻译"为选择器，可以在综合结果中看到对应的选择器模块。

- ```verilog
  module top_module( 
      input a, b, sel,
      output out 
  );    
  assign out = (sel) ? b : a;
  //实现二选一多路器    
  endmodule
  ```

- 三元运算符（Ternary operator）的使用方式是这样的：

  - ```cond ? iftrue : iffalse``` cond 条件为真，则表达式的值为 iftrue，反之表达式的值为 iffalse。具体看 (sel)?b:a 式，当 sel 为真时，结果为 b，反之结果为 a。

  - Verilog 三元运算符原理和 C 语言中的三元运算符相同。但使用更加频繁，尤其是和 assign 的组合：               ```assign out = (sel)?b:a;```

  - 嵌套的用法也十分常用,比如求 a,b,c 中的最大值，可以在一个三元运算符中嵌套两个三元运算符。

  - ```verilog
    assign max = (a > b) ? 
        		(a > c) ? a : c 
        		: 
        		(b > c) ? b : c ;
    ```

### **Problem 61 : 2-to-1 bus multiplexer (Mux2to1v)**

- 本题与上一题的区别在于信号从单比特宽度变成总线信号，但选择器的原理以及对应的代码与前一题相同，这里不再赘述。

### **Problem 62 : 9-to-1 multiplexer (Mux9to1v)**

- 本题中需要实现一个 9 选 1 选择器，sel 信号作为选择信号，当 sel = 0 时选择 a，sel = 1 时选择 b,以此类推。sel 信号位宽为 4bit，当 sel 大于 8 时，输出 16'hffff。

- ```verilog
  module top_module( 
      input [15:0] a, b, c, d, e, f, g, h, i,
      input [3:0] sel,
      output reg [15:0] out );
      //本题如果使用 assign 语句实现会非常繁复，这里使用逻辑上更加直观的 case 语句。
      //case 语句只能在 always 块中使用。本题为组合逻辑，使用 @(*) 作为敏感列表。
      always @(*)begin
          case(sel)
              4'd0:out = a;
              4'd1:out = b;
              4'd2:out = c;
              4'd3:out = d;
              4'd4:out = e;
              4'd5:out = f;
              4'd6:out = g;
              4'd7:out = h;
              4'd8:out = i;
              default:out=16'hffff;
          endcase
      end
  endmodule
  ```

### **Problem 63 : 256-to-1 multiplexer (Mux256to1)**

- 本题中需要实现一个 256 选 1 选择器，sel 信号作为选择信号，当 sel = 0 时选择 in[0]，sel = 1 时选择 in[1],以此类推。

- ```verilog
  module top_module (
  	input [255:0] in,
  	input [7:0] sel,
  	output  out
  );
  // Select one bit from vector in[]. The bit being selected can be variable.
  assign out = in[sel];//直接将 sel ，这个变量，作为片选向量 in 的 index。
  //assign out = in >> sel;//也可以将输入向量 in 右移 sel 位，高位被截去，输出最低位上的 in[sel]。
  endmodule
  ```

### **Problem 64 : 256-to-1 4-bit multiplexer (Mux256to1v)**

- 本题中需要实现一个 256 选 1 选择器，sel 信号作为选择信号，当 sel = 0 时选择 in[3:0]，sel = 1 时选择 in[7:4],以此类推。同上一题的区别在于，位宽从 1 位变到了 4 位。

- ```verilog
  module top_module (
  	input [1023:0] in,
  	input [7:0] sel,
  	output [3:0] out
  );
  // We can't part-select multiple bits without an error, but we can select one bit at a time,
  // four times, then concatenate them together.
  assign out = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4+0]};
  // Alternatively, "indexed vector part select" works better, but has an unfamiliar syntax:
  // assign out = in[sel*4 +: 4];		// Select starting at index "sel*4", then select a total width of 4 bits with increasing (+:) index number.
  // assign out = in[sel*4+3 -: 4];	// Select starting at index "sel*4+3", then select a total width of 4 bits with decreasing (-:) index number.
  // Note: The width (4 in this case) must be constant.
  endmodule
  ```

- 本题如果延续上一题的思考方式: ```assign out = in[ sel * 4+3 : sel * 4 ];ERROR```  但这个表达式不符合 Verilog 片选操作符的语法。片选多个比特的正确语法有两种：

- ```verilog
  assign out = in[sel*4 +: 4];
  // 从 sel*4 开始，选择比特序号大于sel*4 的 4 位比特，相当于[sel*4+3:sel*4]
  assign out = in[sel*4+3 -: 4];	
  // 从 sel*4+3 开始，选择比特序号小于 sel*4+3 的 4 位比特，相当于[sel*4+3:sel*4]
  ```

- 至此，多路选择器的题目就结束了。在位宽较小的多路选择器中，我们可以使用 assign 语句，三元表达式，case 语句等。在位宽较宽的多路选择器中，需要根据需求灵活地使用位选择符或者位连接符

### **Problem 65 : Half adder (Hadd)**   _______________________________________________________________________________________________________________________

- 本题中需要实现一个 2 进制 1bit 加法器，加法器将输入的两个 1bit 数相加，产生两数相加之和以及进位。

- ```verilog
  module top_module( 
      input a, b,
      output cout, sum );
      assign {cout,sum} = a + b;
  endmodule
  ```

### **Problem 66 : Full adder (Fadd)**

- 本题中需要实现一个 2 进制 1bit 全加器，全加器与上一题中的加法器的区别在于，除了将输入的两个 1bit 数相加之外，还累加来自前级的进位，产生相加之和以及进位。

- ```verilog
  module top_module( 
      input a, b, cin,
      output cout, sum );
      assign{cout,sum} = a + b + cin;
  endmodule
  ```

### **Problem 67 : 3-bit binary adder(Adder3 )**

- 在上一题中，我们实现了一个全加器，本题中需要通过实例化 3 个全加器，并将它们级联起来实现一个位宽为 3 bit 的二进制加法器，加法器将输入的两个 3bit 数相加，产生相加之和以及进位。

- **分析：**一个 3bit 全加器由 3 个 1bit 全加器组成，每一比特位对应一个全加器。涉及到进位时，假设最低位产生进位，那个一个 1'b1 就会加到更高 1bit 的全加器中。信号连接时，最低位的 cout 就是次低位的 cin 信号，以此类推。

- ```verilog
  module top_module( 
      input [2:0] a, b,
      input cin,
      output [2:0] cout,
      output [2:0] sum );
  	
      adder U1(
          .a(a[0])
          ,.b(b[0])
          ,.cin(cin)
          ,.cout(cout[0])
          ,.sum(sum[0])
      );
      adder U2(
          .a(a[1])
          ,.b(b[1])
          ,.cin(cout[0])
          ,.cout(cout[1])
          ,.sum(sum[1])
      );
      adder U3(
          .a(a[2])
          ,.b(b[2])
          ,.cin(cout[1])
          ,.cout(cout[2])
          ,.sum(sum[2])
      );
  endmodule
  //**************another file*******************************
  module adder( 
      input a, b, cin,
      output cout, sum );
      assign{cout,sum} = a + b + cin;
  endmodule
  ```

### **Problem 68 : Adder (**Exams/m2014 q4j**)**

- 实现一个 4-bit 全加器

- ```verilog
  module top_module (
  	input [3:0] x,
  	input [3:0] y,
  	output [4:0] sum
  );
  // This circuit is a 4-bit ripple-carry adder with carry-out.
  assign sum = x+y;	// Verilog addition automatically produces the carry-out bit.
  // Verilog quirk: 
  // Even though the value of (x+y) includes the carry-out, 
  // {x+y} is still considered to be a 4-bit number (The max width of the two operands).
  // This is correct:
  // assign sum = (x+y);
  // But this is incorrect:
  // assign sum = {x+y};	// Concatenation operator: This discards the carry-out
  endmodule
  ```

### **Problem 69 : Signed addition overflow**

- 本题讨论的是有符号数相加的溢出问题中，需要实现一个 2 进制 8bit 有符号数加法器，加法器将输入的两个 8bit数补码相加，产生相加之和以及进位。

- ```verilog
  module top_module (
      input [7:0] a,
      input [7:0] b,
      output [7:0] s,
      output overflow
  );
  //只考虑了两个符号相同的数，那么符号不同的数呢？符号不同的数可能造成溢出吗？不可能，就不可能改变符号位
  //符号不同的数相加不会溢出，结果或正或负没有意义
  //减法是将负数转换为补码进行的
  assign s = a + b;
  assign overflow = ( a[7] && b[7] && ~s[7] ) || (~a[7] && ~b[7] && s[7]);
      // ( a[7] && b[7] && ~s[7] )考虑两个负数向加产生一个负数：溢出（1&&1&&~1=1），未溢出（1&&1&&~0=0）
      // (~a[7] && ~b[7] && s[7] )同上
  endmodule
  ```

### **Problem 70 100-bit binary adder**

- 题目要求我们创建一个100bit的二进制的加法器，该电路共包含两个100bit的输入和一个cin， 输出产生sum和cout。

- ```verilog
  module top_module( 
      input [99:0] a, b,
      input cin,
      output cout,
      output [99:0] sum 
  );
  
  wire [99:0] cout_temp;
  //这还是将本次计算的cout当作下次计算的cin来使用
  fadd inst1_fadd(
      .a(a[0]),
      .b(b[0]),
      .cin(cin),
      .cout(cout_temp[0]),
      .sum(sum[0])
  );
  genvar i;
  generate 
      for(i=1; i<100; i=i+1)
          begin: add //例化100次全加器
              fadd inst2_fadd(
                  .a(a[i]),
                  .b(b[i]),
                  .cin(cout_temp[i-1]),
                  .cout(cout_temp[i]),
                  .sum(sum[i])
              );
          end
  endgenerate
  assign cout = cout_temp[99];
  endmodule
  //**************another file************************
  module fadd (
      input a, b, cin,
      output sum, cout
  );
  
  assign {cout, sum} = a + b + cin;
  /*or: assign sum = a ^ b ^ cin;
        assign cout = a&b | a&cin | b&cin;*/
  endmodule
  ```

### **Problem 71 4-digit BCD adder**

- bcd加法器，跟前面差不多，略

### **Problem 72,73 ,74,75: 3-variable, 4-variable, 4-variable, 4-variable**

- 根据卡诺图写出电路逻辑
- 数电知识TODO
- 在编写verilog之前，我们可先化简卡诺图。
  - sop(最小项之和)
  - pos(最大项之积)。
- **最小项：**一个真值表定义一个布尔函数，一个布尔函数可以用乘积项的逻辑和来表示，对应这些乘积项函数的值为逻辑1。如果所有的变量都以原变量或反变量的形式出现，且仅出现一次，这样的乘积项叫做最小项（minterm）
- 一个布尔函数可以由真值表中所有使函数值为1的最小项的逻辑和来表示，这样的表达式叫做最小项之和（sum of minterm）

### **Problem 76 Minimum SOP and POS**

### **Problem 77 Karnaugh map**

### **Problem 78 Karnaugh map**

### **Problem 79 K-map implemented with a multiplexer**

### **Problem 80 : D flip-flop (Dff)**

- 接下来的题目是属于触发器，锁存器的专题。我们会从用 Verilog 实现基础 D 触发器开始，学习触发器这一数字电路中最重要的电路之一。

- D 触发器是一个电路，存储 1bit 数据，并定期地根据触发器的输入(d)更新这 1 bit 数据，更新通常发生在时钟上升沿(clk)。存储的数据会通过输出管脚(q)输出。

- 绝大多数时候，我们不会在 Verilog 代码中显示例化一个触发器（作者没这么做过，但应该是可以做的），我们在时钟敏感的 always 块中的语句一般都会被综合工具转换为相应的触发器。

- D 触发器可以认为是一个触发器和一段最简单的组合逻辑块（blob :想表达逻辑块的时候用我，别用 block）的组合。其中组合逻辑块仅仅是一段 wire。（q 直接输出了触发器的存储值）

- ```verilog
  module top_module (
      input clk,    // Clocks are used in sequential circuits
      input d,
      output reg q 
  );
  // Use a clocked always block
  //   copy d to q at every positive edge of clk
  //   Clocked always blocks should use non-blocking assignments
  always@(posedge clk) begin
      q <= d;
  end
  endmodule
  ```

### **Problem 81 : D flip-flops (Dff8)**

- 实现 8 个 D 触发器，听上去好像很累的样子，实则 Verilog 语言的抽象帮助我们省去不少麻烦。输入 a，b 的位宽变为 8 位，但 always 块中的语句与上一题完全相同。

- 综合工具根据位宽，综合出了 8 个 D 触发器。一般没有八位触发器的说法。这里反映了综合工具能分析代码，生成相应的触发器电路，其实综合器还能将复杂得多的语句转为相应的电路。

- ```verilog
  module top_module (
      input clk,
      input [7:0] d,
      output [7:0] q
  );
      always@(posedge clk) begin
      	q <= d;
      end
  endmodule
  ```

### **Problem 82 : DFF with reset (Dff8r)**

- 在上题的 8 个 D 触发器基础上，这题我们要给触发器配上同步复位端口。

- 什么同步复位？当时钟上升沿到来时，如果同步复位端有效（本题中复位高电平有效，即 reset），那么任凭你触发器此前输出或者输入的是 0，是 1，输出一律变为 0。

- 复位电路对于那些经常需要恢复到初始状态的电路是必要的，复位相较于断电重新加载程序恢复到初始状态的速度要快得多。但也有一些电路则不需要复位设计。（作者也是有所耳闻那些不需要复位的电路，平常自己还是会加上复位电路）

- ```verilog
  module top_module (
      input clk,
      input [7:0] d,
      output [7:0] q
  );
      always@(posedge clk) begin
          if(reset)
              q <= 8'b0;
          else
      	    q <= d;
      end
  endmodule
  ```

### **Problem 83 : DFF with reset value (Dff8p)**

- 同步复位，下降沿触发

- ```verilog
  module top_module (
      input clk,
      input reset,
      input [7:0] d,
      output [7:0] q
  );
      always@(negedge clk) begin//下降沿触发
          if(reset)
              q <= 8'h255;//同步复位为1
          else
      	    q <= d;
      end
  endmodule
  ```

### **Problem 84 : DFF with asynchronous reset (Dff8ar)**

- 异步复位，注意电路与上面两个的不同

- ```verilog
  module top_module (
      input clk,
      input areset,   // active high asynchronous reset
      input [7:0] d,
      output [7:0] q
  );//将异步复位加入 always 块的敏感列表当中
      always@(posedge clk or posedge areset) begin
          if(areset)    
              q <= 8'b0;
          else
      	    q <= d;
      end
  endmodule
  ```

### **Problem 85 : DFF with byte enable(Dff16e)**

- 本题中需要创建一个 16 路 D触发器。部分情况下，只需要多路触发器中的一部分触发器工作，此时可以通过 ena 使能端进行控制。使能端 ena 信号有效时，触发器在时钟上升沿工作。

- byteena 使能信号以 byte 为单位管理 8 路触发器在时钟边沿触发与否。byteena [1] 作为 d[15:8] 高位字节的使能端，byteena [0] 则控制 d 的低位字节。

- resetn 为同步，低电平有效复位信号，所有的触发器在时钟上升沿被触发。

- ```verilog
  module top_module (
      input clk,
      input resetn,
      input [1:0] byteena,
      input [15:0] d,
      output reg [15:0] q
  );
  
  always @(posedge clk) begin
      if(~resetn)
          q <= 16'd0;
      else if(byteena[0] || byteena[1]) begin
          if(byteena[1])  //注意不要在判断 byteena 时将 if...if 结构写成 if..else if ..结构
              q[15:8] <= d[15:8];
          if(byteena[0])  //这样会在byteena=2'b11时产生只判断 byteena[1]，忽略byteena[0]的逻辑错误。
              q[7:0] <= d[7:0];
      end
  end
  endmodule
  ```

### **Problem 86 : D latch**

- 锁存器的特征在于，相较于 D触发器的触发事件发生于 **clk** 时钟的**边沿**，锁存器锁存的触发事件发生于使能端 **ena** 的**电平**。

- 回想锁存器，触发器的符号，注意二者的区别

- ```verilog
  module top_module (
      input d, 
      input ena,
      output reg q
  );    
  always@(*)begin
      if(ena)begin
          q<=d;
      end
  end
  endmodule
  ```

### **Problem 87 : DFF**

- ar 代表 asynchronous reset，所以这是一个带有异步复位的 D 触发器，我们在先前的题目中讨论过异步复位的问题。

- ```verilog
  module top_module (
      input clk,
      input d, 
      input ar,   // asynchronous reset
      output reg q
  );
  always@(posedge clk or posedge ar)begin
      if(ar)
          q <= 1'b0;
      else
          q <= d;
  end
  endmodule
  ```

### **Problem 88 : DFF**

- R 代表 synchronous reset，（就不用 SR 或者 SSR 表示了）所以这是一个带有同步复位的 D 触发器，我们在先前的题目中讨论过同步复位的问题。

- ```verilog
  module top_module (
      input clk,
      input d, 
      input r,   // synchronous reset
      output reg q
  );
  	
  always @(posedge clk) begin
      if(r)
          q <= 1'b0;
      else
          q <= d;
  end
  endmodule
  ```

### **Problem 89 : DFF+gate**

- 一个 D 触发器与一个异或门，触发器的输出 q 和输入信号 in 一起作为异或门的输入。异或门的输入作为触发器的输入 d

- ```verilog
  module top_module (
      input clk,
      input in, 
      output reg out);
      always @(posedge clk) begin
          out <= in ^ out;
      end
  endmodule
  ```

### **Problem 90 Mux and DFF**

### **Problem 91 Mux and DFF**

### **Problem 92 DFFS and gates**

### **Problem 93 Create circuit from truth table**

### **Problem 94 Detect an Edge**

- ```verilog
  module top_module (
      input clk,
      input [7:0] in,
      output [7:0] pedge
  );
  
      reg [7:0] temp;
  
      always @ (posedge clk)
          begin
              temp <= in; //temp始终比in晚一个周期
              pedge <= ~temp & in; //当输出为1时检测到上升沿
              //本题刚好与所示时序图相反，其中Q就相当于temp， D就相当于in，检测下降沿是对in取反就好。
          end
  
  endmodule
  ```

### **Problem 95 Detect both edges**

- ```verilog
  module top_module (
      input clk,
      input [7:0] in,
      output reg [7:0] anyedge
  );
  
      reg [7:0] in_temp;
  
      always @ (posedge clk)
          begin
              in_temp <= in;
              anyedge <= in ^ in_temp;//只不过换了一种方式
          end
  
  endmodule
  ```

### **Problem 96 Edge capture register**

- ```verilog
  module top_module (
      input clk,
      input reset,
      input [31:0] in,
      output [31:0] out
  );
      reg [31:0] temp;
      wire [31:0] capture;
  
      //同理，我们先检测输入信号的上升沿。
      always @ (posedge clk)
          begin
             temp <= in; 
          end
      //这里如果采用reg的话会出现时序错误。
      assign capture = ~in & temp;
  
      //检测到上升沿之后，来确定我们的输出
      always @ (posedge clk)
          begin
              if(reset)
                  out <= 32'b0;
              else
                  begin
                      for (int i=0; i<32; i=i+1)
                          begin
                              if(capture[i] == 1'b1)
                                  out[i] <= 1'b1;
                          end
                  end
          end
  
  endmodule
  ```

### **Probelm 97 Dual-edge triggered flip-flop**

- 我们现在对时钟上升沿与下降沿都已经很熟悉了。但是FPGA没有一个同时检测双边沿的触发器，而且always中的敏感列表也不支持(posedge clk or negedge clk)。

- ```verilog
  module top_module (
      input clk,
      input d,
      output q
  );
      reg q1, q2;
      //这里来实现clk的上升沿与下降沿
      assign q = clk?q1:q2;
      always @ (posedge clk)
          begin
              q1 <= d;
          end
      always @ (negedge clk)
          begin
              q2 <= d; 
          end
  endmodule
  ```

- ```verilog
  module top_module(
      input clk,
      input d,
      output q);
  
      reg p, n;
  
      // clk的上升沿
      always @(posedge clk)
          p <= d ^ n;
  
      // clk的下降沿
      always @(negedge clk)
          n <= d ^ p;
  
      //在上升沿时候，p=d^n, 则q=d^n^n=d;
      //在下降沿时候，n=d^p, 则q=p^d^p=d;
      //加载一个新值时会取消旧值。
      assign q = p ^ n;
      
      // 这样写是无法综合的
      /*always @(posedge clk, negedge clk) begin
          q <= d;
      end*/
  endmodule
  ```

### **Problem 98 Four-bit binary counter**

- 设计一个4bit的计数器，从0～15，共16个周期。reset是同步复位且复位为0。

- ```verilog
  module top_module (
      input clk,
      input reset,      // Synchronous active-high reset
      output reg [3:0] q
  );
      always @ (posedge clk)
          begin
              if(reset)
                  q <= 4'b0000;
              else
                  q <= q + 1'b1;
          end
  
  endmodule
  ```

### **Problem 99 Decade counter**

- 同样是4bit计数器，上一题是0～15， 本题我们只计算到0～9。还是同步复位且复位为0。

- ```verilog
  module top_module (
      input clk,
      input reset,        // Synchronous active-high reset
      output [3:0] q
  );
  always @ (posedge clk)begin
      if(reset)
          q <= 4'b0000;
      else if(q <= 4'b1000)
          q <= q + 1'b1;
      else
          q <= 4'b0000;
  end 
  endmodule
  ```

### **Problem 100 Decade counter again**

- 本题和Problem 99 类似，还是1～10的计数器，唯一不同是同步复位为1.

- ```verilog
  module top_module (
      input clk,
      input reset,
      output [3:0] q);
  
      always @ (posedge clk)
          begin
              if(reset)
                  q <= 4'b0001;
              else if(q <= 4'b1001)
                  q <= q + 1'b1;
              else 
                  q <= 4'b0001;
  
          end
  
  endmodule
  ```

### **Problem 101 Slow decade counter**

- 设计一个0～9的计数器，共10个周期。该计数器采用同步复位且复位为0。但是本题是希望该计数器并不是随着clk的变化而递增，而是随着一个slowena使能信号来控制增加。

- ```verilog
  module top_module (
      input clk,
      input slowena,
      input reset,
      output [3:0] q
  );
  reg [3:0] cnt;
  //period is 10 
  //What is supposed to happen when the counter is 9 and not enabled?
  always @ (posedge clk) begin
      if(reset)
          cnt <= 4'b0;
      else if(slowena == 1'b1) begin //slowena 为高，计数器才能正常运行            
          if(cnt == 4'd9)//因为题目要求周期为10，所以0～9之后下一个为0；
          	cnt <= 4'b0;
          else 
          	cnt <= cnt + 4'd1;
          end
  end
  assign q = cnt;
  endmodule
  ```

### **Problem 102 Counter 1-12**

### **Problem 103 Counter 1000**

- 从1000Hz中分离出1Hz的信号，叫做OneHertz。这个主要用作与数字时钟中。利用一个模10的BCD计数器和尽量少的逻辑门来建立一个时钟分频器。

- 假设三个定时器a，b，c都是模10的计数器，a的输入时钟是1000Hz，每当a计到10的时候，给b一个使能，相当于a计10次，b才计1次，b是a的十分之一，故b的时钟是100Hz。同理c是a的百分之1为10Hz。所以到999是输出就为1Hz了。

- ```verilog
  module top_module (
      input clk,
      input reset,
      output OneHertz,
      output [2:0] c_enable
  ); //
  
      wire [3:0] q0, q1, q2;
  
      assign c_enable = {q1 == 4'd9 && q0 == 4'd9, q0 == 4'd9, 1'b1};
      assign OneHertz = {q2 == 4'd9 && q1 == 4'd9 && q0 == 4'd9};
  
      bcdcount counter0 (clk, reset, c_enable[0], q0);
      bcdcount counter1 (clk, reset, c_enable[1], q1);
      bcdcount counter2 (clk, reset, c_enable[2], q2);
  
  endmodule
  ```

### **Problem 104 4-digit decimal counter**

### **Problem 105 12-hour clock**

- 用计数器设计一个带am/pm的12小时时钟。该计数器通过一个CLK进行计时，用ena使能信号来驱动时钟的递增。

- reset信号将时钟复位为12：00 AM。 信号pm为0代表AM，为1代表PM。hh、mm和ss由**两个BCD计数器**构成hours(01~12)， minutes(00~59) , second(00~59)。Reset信号比enable信号有更高的优先级，即使没有enable信号也可以进行复位操作。

- ```verilog
  module top_module 
      (
          input clk,
          input reset,
          input ena,
          output pm,
          output [7:0] hh,
          output [7:0] mm,
          output [7:0] ss
      );
  
  reg p;  //0 is am, 1 is pm
  reg [7:0] h;
  reg [7:0] m;
  reg [7:0] s;
  
  always @ (posedge clk) begin
      if(reset) begin  //reset to 12:00:00 AM
          p <= 0;
          h <= 8'h12;
          m <= 8'h00;
          s <= 8'h00;
      end
      else begin
          if(ena) begin
              if(s < 8'h59) begin
                  if(s[3:0] < 4'h9) begin  //s[3:0] is ones digit
                      s[3:0] <= s[3:0] + 1'h1; 
                  end
                  else begin
                      s[3:0] <= 0;    //59->00
                      s[7:4] <= s[7:4] + 1'h1; //tens digit 
                  end 
  			end
                  else
                      begin
                          s <= 0; //s清零
                          if(m < 8'h59)   //m同理s
                              begin
                                  if(m[3:0] < 4'h9)
                                      begin
                                          m[3:0] <= m[3:0] + 1'h1; 
                                      end 
                                  else
                                      begin
                                          m[3:0] <= 0;
                                          m[7:4] <= m[7:4] + 1'h1;
                                      end
                              end
                          else
                              begin
                                  m <= 1'h0;
                                  if(h == 8'h11)  //AM / PM 转换
                                      p = !p;
                                  if(h < 8'h12)
                                      begin
                                          if(h[3:0] < 4'h9)
                                              h[3:0] <= h[3:0] + 1'h1;
                                          else
                                              begin
                                                  h[3:0] <= 4'h0;
                                                  h[7:4] <= h[7:4] + 1'h1;
                                              end
                                      end
                                  else
                                      begin //hour 12 -> 1
                                          h <= 1'h1; 
                                      end
                              end
                      end
              end
      end
  end
  
  assign pm = p;
  assign hh = h;
  assign mm = m;
  assign ss = s;
  
  endmodule
  ```

### **Problem 106 4-bit shift register**

- 设计一个4bit异步复位，拥有同步置位和使能的右移移位寄存器。
  - areset : 寄存器复位为0

  - load : 将data[3:0]输入至移位寄存器中

  - ena : 使能信号控制向右移动（q[3]q[2]q[1]q[0] ---> 0q[3]q[2]q[1]，q[0]在移动后消失了，原先q[3]的位置变为0）

  - q : 移位寄存器中的数据

  - 如果ena和load同时为高，load有更高的优先级。

  - ```verilog
    module top_module(
        input clk,
        input areset,  // async active-high reset to zero
        input load,
        input ena,
        input [3:0] data,
        output reg [3:0] q
    ); 
    always @ (posedge clk or posedge areset) begin
        if(areset)
            q <= 4'b0;
        else if (load)
            q <= data;
        else if (ena)
            q[3:0] <= {1'b0, q[3:1]};
    end
    endmodule
    ```

### **Problem 107 Left/right rotator**

- 设计一个100bit的可左移或右移的移位寄存器，附带同步置位和左移或右移的使能信号。本题中，移位寄存器在左移或右移时，不同于Problem106的补0和直接舍弃某一bit位，本题是要求在100bit内循环移动，不舍弃某一bit位同时也不补0。

  - load：load信号将data[99:0] 输入至寄存器内。
  - ena[1:0] 信号选择是否移位和移位的具体方向
  - 2'b01 右移一位
  - 2'b10 左移一位
  - 2'b00 和 2'b11不移动
  - q：移位后寄存器内的数据

- ```verilog
  module top_module(
      input clk,
      input load,
      input [1:0] ena,
      input [99:0] data,
      output reg [99:0] q
  ); 
      always @ (posedge clk)//可以直接使用case语句
          begin
              if(load)
                  q <= data;
              else if (ena == 2'b01)
                  q <= {q[0], q[99:1]};
              else if (ena == 2'b10)
                  q <= {q[98:0], q[99]};
              else if (ena == 2'b00 || ena == 2'b11)
                  q <= q;       
          end
  
  endmodule
  ```

### **Problem 108 Left/right arithmetic shift by 1 or 8**

### **Problem 109 5-bit LFSR**

### **Problem 110 3-bit LFSR**

### **Problem 111 32-bit LFSR**

### **Problem 112,113,114 Shift Register**

- 

  ```verilog
  module top_module (
      input clk,
      input resetn,   // synchronous reset
      input in,
      output reg out);
  	reg q0,q1,q2;
      
      always@(posedge clk)begin
          if(~resetn)begin
              q0	<=	1'b0;
              q1	<=	1'b0;
              q2	<=	1'b0;
              out	<=	1'b0;
          end else begin
              q0	<=	in;
              q1	<=	q0;
              q2	<=	q1;
              out	<=	q2;
          end
      end
  endmodule
  ```

