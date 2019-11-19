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
  
  assign z1 = (x^y) & x;
  assign z2 = x ^~ y;
  assign z3 = (x^y) & x;
  assign z4 = x ^~ y;
  
  assign z = (z1 | z2) ^ (z2 & z3);
  
  endmodule
  ```

