

## C语言基础知识

1. bit，byte

   - 位 bit 度量数据的最小单位

   - 字节 byte 一个字节有八位
   - k 1k = 1024byte	M 1M = 1024k	G 1G = 1024M

2. 语言  
   - 执行速度是限制语言的关键因素
   - 机器语言-->指令和程序 -->操作码，操作数
   - 汇编语言  开发导弹使用机器语言
   - C语言-->面向过程的语言
   - C语言特点 --> 执行速度快、代码量小、功能强大、编程自由
   - 7C语言缺点 --> 可移植性差，过于自由
3. 编译器
   - 高级语言不能直接运行
   - 编译器  翻译高级语言到机器语言
     - vs2013，qt ......



### C与C++的区别

cpp 全称 cplusplus。cpp兼容c

C面向过程，C++面向对象

语法上没有太大的区别

### C语言头文件及预处理命令

头文件导入头文件的定义，include 就是把整个文件导入进来，不仅可以包含.h也可包含其他文件类型例如.txt

#include <系统文件>  or #include “自己编写的”，  < >系统文件 “ ” 自己编写的文件

“#”与“include”之间可以有多个空格

“#”预处理指令可以不加分号，“#”开头的就是预处理命令

头文件中存放一些定义，很少做实际的运算，头文件的好处是可以通用，比如一些用的上的定义

可以让其他文件来调用他，这样就节省了代码量

.h--->head 的简称，就像一本书的目录，目录上

### C语言主函数 main

```c
void main()   //最精简的c程序

{

}			//空项目没有什么可以生成，所以可以编译成功

```

入口点提示程序从哪里开始执行main函数有且只有一个  从main开始，从main结束

任何c程序都可以以main作为入口点，从main开始执行，从main结束

main函数 初中数学的函数，y= F(x) 有一个x 就有一个y与之对应

有一个输入，就有一个输出对应

void是函数返回值的类型，也就是函数的输出类型，void是返回值为空类型，可以没有输出

main是函数的名称，（）是函数的输入为空就是输入为空

{} 就是函数体，也就是函数实现的内容，就是把输入加工为输出，输入输出都可以为空。

括号，大括号都不能少

### C语言常识

注释方法 -->  //行注释  /* 段落注释*/ 编译器不编译注释，不影响生成的exe文件大小

编译器自动忽略空格空行 空格个数不限制

C语言一行可以写好几个一句，一般写一句

C语言的输入输出靠标准库<stdio.h>就是标准库

getchar（）等待输入一个字符

断点起到调试程序是让程序一段一段执行，便于观察程序内部状态

1. C语言的命令行编程

```
#include <stdio.h>

void main()

{

	printf("learn c ");

}
```

ipconfig  查看本机I的IP地址

cd 进入目标目录

cd 后加目标文件夹的绝对路径 可以从当前文件夹到目标文件夹

未定义标识符错误没导入库

system（“pause”）---->可以让窗口暂停下来

所有的c程序只要是黑窗口，都可以在命令行下进行

c黑窗口程序可以调用其他任何C语言黑窗口程序在命令行下执行

调用的方法是

```c
system("c:\\cmd.exe") //调用system函数，传入路径
```

tasklist 显示进程

route print 显示路由

命令行

2.windows弹窗设置

<windows.h>

```c++
#include <stdlib.h>
#include <windows.h>
void main()
{
    printf("hello 嗨喽")；
    MessageBox(0,"锄禾日当午"，"汗滴禾下土"，0)
    /*第一个参数设置为0，第一个参数是依赖的窗口的编号，相当于是谁弹出的窗口，0为系统弹出，第二个参数是对话框内的内容，第三个参数是对话框的标题，第四个参数是对话框的类型*/
    ShellExecute(0,"open","网址或者应用地址"，0,0,1)
        /*
    		第三个可以是网址，文件路径，或者notepad等应用
            第二个参数可以换成 printf打印函数
	        */
}
```







3.头文件源文件以及include包含指令

1. cpp是c++的文件，也就是英文cplusplus的简称，可以兼容C语言
2. 头文件 .h----> head的简称，

头文件是源文件的辅助文件，一般把一些变量，函数定义到头文件，而将函数的实现放在源文件。

3. #include 是预编译指令，将其他文件的内容包含进来，可以包含头文件，也可以包含其他任意类型的文件
4. 预编译指令一般不需要加 “;” 对于include来说加上也不影响执行
5. c++的源文件是兼容C语言的，写C语言可以用c++的源文件，也可以使用C语言的源文件
6. #include可以包含任意类型，不仅.h可以.c也可以.cpp
7. 同样的一个作用域范围 变量不可以重名
8. 内容重复包含，出现了重名，不要重复包含
9. 头文件就是为了避免重复包含
10. 一般情况下函数声明放在头文件，变量定义和函数实现放在头文件
11. vi 进入编辑器--->编辑文件--->esc 退出插入模式  ------>w 文件名退出并保存------->gcc 文件名 -------》产生.out文件----》./a.out 运行文件



4. C语言的编程流程

5.  数据结构与算法

   对数据结构+算法 = 程序

   程序解决之后再优化

   有穷性，算法必须是明确的，算法每一步都必须有效，每一步结果都确定

   自顶向下，逐步细化，模块化设计，结构化编码

   分析问题所需要的步骤，一步一步实现

   面向过程---》底层需要确定的步骤

   面向对象---》应用层

   C语言的编程步骤

   1：编辑源代码 .c .h 文件写好了以后生成.obj

   2：编译源文件 代码被编译为二进制文件.obj后打包一些调用的库，链接成.exe可执行文件

   3： 从.obj链接成.exe  



   比如  

   源文件呼叫110  编译后变成呼叫的二进制.obj，链接将110 的实体与.obj捆绑生成可执行的.exe文件



​    转义字符

```
int main()

{
	printf("hello world");
	printf("\n\a");  //  \n换行 \a发出声音  
	printf(`)
}
```

### 变量与常量的概念

常量就是计算机内存里面不变的数据

变量就是计算机内存里面需要并且经常改变的数据



| 内存地址 | 指令或数据 |
| -------- | ---------- |
| 00001000 | 0ADF3      |

计算在CPU中运行

CPU  控制和运算

### 变量命名的规则

字母数组下划线，严格区分大小写，地址不同，变量不同，不能使用C语言的关键字，见名知意，

vs2013可以使用汉字当字母

### 定义变量

int num ; 定义变量，一定要分配内存

int a,b,c ; 合法

int a=1,b=2; 合法

C语言定义变量的格式比较自由

使用变量一定要初始化吗，变量如果不初始化，就会产生垃圾数据

### 定义常量

const  固定恒定

左值 能放在等号左边的值

常量可读不可写，变量可读可写

定义常量后，修改一次，就行了

修改一次可以改变全局

使用见名知意的名字，简单代替复杂的一些常量

#define 后不用；

### 变量的数据类型

进制问题

2,8,10,16 进制，，逢x经进1

计算机存储数据

计算机是八位一字节定义一个地址将所有内存都能被地址编号

源码反码补码



unsigned short   2 byte  很简短的整数，一般是节约内存，嵌入式开发注意数据溢出！！！！  32位一下的系统，int与short等价

unsigned int 4 byte 表示范围大，嵌入式开发应该与short一样使用

unsigned long 4 byte 32，64 位系统， int 与long 等价

无符号unsigned 表示的正数跟大一些 	

### 浮点型数据类型

浮点型数据的可以使用e，例如1.23e4 = 12300.000

单精度和双精度

floot fl;//四个字节

fl = 1234.5;

double db;八个字节

db = 123.45e4;

计算机如何表示浮点数和定点数

计算机表示整数比较简单，表示带有小数点的数据稍微麻烦

计算机通常使用定点数来表示整数和纯小数，分别称为定点整数和定点小数

对于既有整数，又有小数的数，有两种方法

一种是规定小数点的位置固定不变，称为定点

另一种是小数点的位置不固定，可以浮动，称为浮点数，一般用浮点数表示

123.45e2  ---->   123.45尾数，10基数，2指数

表示实数使用浮点数，浮点数小数点是可以浮动的，所以更节省内存

<float.h>,f包含float极限的头文件FLOAT_MAX,FLOAT_MIN表示int类型能够表示的极大值和极限值

<limits>包含int极限的头文件INT_MAX,INT_MIN表示int类型能够表示的极大值和极限值

float 作为实数，可以表述的数比int 的范围更广，由于小数点不固定以及利用科学计数法

例如：

```c
1000000000000000000000000000000000000000000000000000

//int 类型表示必然是不够的，多以就需要使用，float科学计数法

0000000000000000000000000000000000000000000000000.1

// float  1.0e-40就能够表示出
```



<math.h>包含sqrt开平方的声明

### 字符常量‘a’ 与 字符变量

定义： 用单引号括起来的单个普通字符或转义字符

普通字符包括大小写字母以及数字

‘a’ ，		‘\n’，		‘\x41’   单引号可以包括的东西

使用双引号可以代表字符序列后面要加上--->  \0

每个字符串尾自动加个 ‘\0’ , 作为字符串结束的标志，空字符串有一个结束表示\0，所以占一个字节，由于‘\0’的占位，所以字符串的长度要加一个字节

双引号和单引号的区别

char 只能定义单引号，双引号则不行

printf("hello"); =putchar('h'); ... putchar('o');

也可以使用ASCII表的字符的数字,	'101' 十进制；	‘\x41’  十六进制； 	'\101'八进制



字符 ‘ 1 ’  与  整数  1   的区别

字符 ‘ 1 ’ 只是代表一个形状为1的符号，在需要时按原样输出在内存中以ascii码形式存储，占1个字节  0011 0001

整数1 是以整数存储方式（二进制补码方式）存储的占2个或4个字节

0000 0000 0000 0001

%c 就是打印字符 %d就是打印字符的编码ascii

字符型数据和整型数据可以相互运算

例

```c
char ch = 'A';
printf("%c, %d",ch,ch)； //输出 A，66
ch = ch+1;
printf("%c, %d",ch,ch)； //输出 B，67 
```



 

声明的意义就是让编译器知道变量的存在

| 变量地址  | 变量类型 | 变量名 |
| --------- | -------- | ------ |
| 001001011 | int      | num    |

| 地址      | 数据 |
| --------- | ---- |
| 001001011 | 5    |

int num = 5 ；

（1）建立变量符号表，让每一个变量映射内存空间，让编辑器知道变量的存在

（2）变量的数据类型只是系统分配多少内存空间

（3）变量的数据类型指示了系统如何解释存储空间的值

（4）变量的数据类型确定了该变量的取值范围，说明了变量的数据极限

（5）不同的数据类型有不同的操作



起始点+长度可以确定变量从哪里开始从哪里结束

float 是通过指数的形式存储的

duble 类型不可以进行求余

### 类型转换

自动转换：char  short 会直接转换成int，char 不会转换为short

int可以转换为float，double float；float可以转换为double

数据较大会从有符号向无符号转换，

unsigned int unum = 4294967000u; //u标注无符号常量的作用

### 局部变量和全局变量

```c
#include <stdio.h>
int n = 10;  //全局变量
void func1(){
    int n = 20;  //局部变量
    printf("func1 n: %d\n", n);
}
void func2(int n){
    printf("func2 n: %d\n", n);
}
void func3(){
    printf("func3 n: %d\n", n);
}
int main(){
    int n = 30;  //局部变量
    func1();
    func2(n);
    func3();
    //代码块由{}包围
    {
        int n = 40;  //局部变量
        printf("block n: %d\n", n);
    }
    printf("main n: %d\n", n);
    return 0;
}


//运行结果：
//func1 n: 20
//func2 n: 30
//func3 n: 10
//block n: 40
//main n: 30
```

**局部变量（Local Variable）**：定义在函数体内部的变量，作用域仅限于函数体内部。离开函数体就会无效。再调用就是出错。

**全局变量（Global Variable）:**定义：所有的函数外部定义的变量，它的作用域是整个程序，也就是所有的源文件，包括.c和.h文件。

1. 在main函数中定义的变量也是局部变量，只能在main函数中使用；同时main函数中也不能使用其他函数中定义的变量。main函数也是一个函数，与其他函数地位平等

2. 形参变量、函数体内定义的变量都是局部变量，实参给形参传值的过程也就是给局部变量赋值的过程

3. 可以在不同的函数中使用相同的变量名，他们表示不同的数据，分配不同的内存，互不干扰，也不会发生混乱

4. 在语句块（由一对{}包含的若干条语句）中也可以定义变量，其作用域仅限于当前的语

### 

###强制类型转换
（类型）（表达式）
数据溢出的问题
数据盒子最多容纳两位
max ---->99  --->99+1 --->00
在加一位，进位数据被舍弃
所以得到的结果为00
###类型转换的二进制原理
printf打印的范围
#include <stdio.h>
#include <limit.h>

void main()
{
​	//%d 有符号十进制的输出  int
​	//%u 无符号十进制的输出 unsigned int
​	printf
​	//使用数据一定要在范围之内
​	//越过数据极限，就输出意料之外的数据

}

数据复制本质上就是将二进制的数
short x = 255; 0000 0000 1111 1111
unsigned char ch = x; 1111 1111
short x = 256; 0000 0001 0000 0000
unsigned char ch = x; 0000 0000

数据的填充
char  类型 一个字节8位 0000 0

有符号的小数据向有符号的大数据转换，可以保证结果的正确
就像老鼠从小盒子到大盒子，可以保证老鼠的完整
大数据转小数据会产生截取。下数据转大数据会产生填充
有符号的小数据转有符号的大数据，旺旺按照符号填充
无法符号小数据转换无符号大数据
符号位为0就填充0，符号位为1就填充1
unsigned 要转换的数据没有符号位，就统一填充为0
有符号小数据转换无符号大数据
整数可以保证正确，负数按照二进制来解析，不能保证结果的正确
首先数据在极限范
围之内是正确的，在极限范围之内就不保证正确
负数在内存中是按照补码来显示的
 printf 本质是不管原来数据是什么类型，我统一按照我自己的方式来进行解析
指定是%d就是%d，指定是%u就是%u
正数是原码负数是补码，针对负数，跟据原码求补码，根据补码求原码
计算机赋值的时候，不管三七二十一
就是把二进制发的值赋值过来，
有符号才有补码，无符号不谈补码

 #标准库函数<stdlib.h>
 _itoa（num, str, 2）
 标准库第一个要转换的数据，第二个是字符串，第三个是转换的进制
####
所有数据的极限
printf（"%d,%d", INT_MAX, INT_MAIN)调用int的最值
 打印无符号，一定要使用%u
 数据类型只是一个盒子，决定其极限值
 数据类型的大小，不同类型占多少个字节
 ###
 类型提升
 char short 字符，无论有无符号，在表达式中，都会转换为int或者unsigned
 可以跨平台
 不同的平台，不同的编译器，同一整数数据类型可能大小不一样
 C语言提供了一个标准库<stdint.h>
 只要支持c99的编译器就都行
 <stdbool.h>支持C语言的bool变量
 bool型变量关注成立不成立

 ###运算符与表达式
 常用的运算符与表达式
 1+2，就是一个表达式，+是操作符，操作数就是1和2
  算术表达式，关系表达式，函数表达式
  函数的表达书sqrt（a+b）
  运算符规则
  运算符不能相邻，除了加减号
  乘号不能省略
  运算优先级使用（）
  算数，关系，逻辑，位操作
  操作数，运算符，表达式
  int整数运算只保留整数，
  C语言中要区分参与运算的类型
  参与运算的含有整数，
  在数学运算中，两个整数的运算结果一定是整数
  求余运算符%不能包含duble，float
  两边都必须是整型数据
  整数无发直接打印，需要转换成字符串
  main函数是程序入口点，int是函数返回值类型，一个函数可以没有返回值
  ++ 或者-- 不能用于常数或表达书
  ++在前是先自增在引用
  ++在后是先引用再自减
  运算符优先级和结合性
  优先级是指那种运算在前，括号可以改变优先级
   ++的优先级高于乘除法也高于加减法
   运算级，与自增自减的位置决定先引用还是自增
   ###赋值运算符
   常量不是左值不能被赋值
   赋值号会默认将赋值号右边的数据转换成左边变量额的类型，
   如果实数转整数会有精确度的损失
   复合数据运算符转换规则
   按照等价形式转换
   赋值运算符的值就是最终赋值以后变量的值
   赋值运算符是从右向左执行
   表达式的解析是从右向左
   赋值号的数据类型转换
   ###逗号运算符
   多个表达式的值用逗号连接在一起，就是逗号表打死
   按照顺序求值，值为最后一个表达式的值
   逗号运算符优先级最低
   int i= （1,2,3）； 正确
   int i= 1,2,3； 错误
   逗号分隔作用
   用于求值时，就是顺序求值，从左向右
   用于分隔多条语句时就是分隔作用从左向右

   ###
   关系表达式
   结合性就是计算方向是从左到右
   同样的运算符就是从左向右的
   一般形式：表达式|运算符|表达式
   关系运算符的优先级
   运算符先判断优先级，在按照从左向右运算
   ###
   关系运算符的特殊性
   关系表达式可以是整型浮点型也可以是字符型
   但是一般不用比较两个常量字符串
   对于浮点型数据，由于存储形式特殊，小数点采用近似结果
   因此不推荐使用 == 或者！=进行关系运算

   float最多精确到6-7位，double精确到小数点13-14位
   所以存在不精确

   定义常量，编译器为了节约内存，常量不可以修改
   无论常量多少个引用
   都是一个常量
   字符串之间，比较大小关系没有任何意义，只有相等或者不等才有意义
   相等的常量都存在一个地址
   针对字符串比较的是地址
   字符串变量会另外开辟地址，常量只有一个地址
   而判断等于或者不等于时
   判断的是地址一不一样

###
逻辑运算符
逻辑非运算符高于算数运算符
算数运算符高于关系运算符
关系运算符高于逻辑与运算符
逻辑与运算符高于逻辑或运算符
逻辑或运算符高于辅助运算符
###
理解短路表达式
计算机从左向右执行，
对于与来说，一个表达式为0，那么整个表达式的值就是0
有一个不符合剩下一个是否符合，都不符合
对于或来说，一个表达式为1，那么整个表达式的值就是1
一个符合剩下一个是否符合，都符合
在C语言总，若通过左边一个条件确定逻辑运算的值，右边的条件就不在执行
这就是短路效应
###
条件运算符
x = 1? x:y
条件运算符的优先级高于赋值运算符
条件运算符结合方向从右向左
若a<b<c<d
y = a > b ? a : c > d ? c : d
-->y = d 
###
左值和程序实体
程序实体是内存的一块克表示的区域
左值是左值表达式的简称
是指明一个程序实体的表达式
判断一个表达式是否是左值的方式就是看他能不能放在等号的左边
能放在左边就说明是左值
左值指明了一块内存区域
赋值运算其实是改变这一区域内容的操作
const int num 定义一个常量，初始化的时候就可以放在赋值号的左边
不能先定义在赋值，也就是上述方法是错误的
必须在定义时就进行赋值
const int num = 10；
只有在初始化的时候可以赋值
在C语言中不能直接赋值给寄存器没有任何意义
例如 a+1，等等这样的表达式没有程序实体
在cpu 寄存器里面
例如 float a 声明了一个浮点型的变量a
则a 是左值，因为他指明了一个内存实体，在内存中能找到，可以放在赋值号的左边
但表达式a+1 就不能放在赋值号的左边不是左值
他们在内存里面，C语言不能给cpu 的寄存器赋值，没有意义



###
   数据输入输出
   scanf("%d",&num)
   printf 格式控制输出输入函数
   getchar（）putchar（）字符输入输出函数
   printf一一对应，  
   输出表中的数据可以是合法的常量，变量与表达式
   要与格式控制中的格式字符一一对应
   printf("结果是：%d\n")
   %后面：跟格式字符组成，将输出数据转换为指定格式输出
   “结果是”：字符串原样输出，
   “\n”：转义字符，对输出形式进行控制
   ###
   格式说明
   %d一以带符号的十进制形式输出整数
   %o-以无符号的八进制形式输出整数
   %x—以无符号的十六进制形式输出整数
   %u—以无符号的十进制形式输出整数
   %c-以字符形式输出单个字符
   %s-输出字符串
   %f— 以小数点形式输出单、双精度实数
   %e-   以标准指数形式输出单、双精度实数
   %g—选用输出宽度较小的格式输出实数



   0就是填充数据的，如果有0，就用0填充



   ​			表达式语句     		运算符表达式语句

   ​								赋值语句

   ​			函数调用语句

   C语言的语句空语句，块语句

   ​			流程控制语句			结构化语句		条件语句（if，switch）

   ​												循环语句（while，do while， for）

   ​								非结构化语句		限定转向语句（break，continue，return）

   ​												非限定转向语句（goto语句）

### 语句

块语句一般用于函数，用于循环，用于选择

可以用于避免变量的重名

不同的块语句，同名变量编译器会处理成不同的内存地址的变量

### 结构化程序设计

把一个需要解决的问题分解成若干模块来处理

结构化的程序设计的核心问题是算法和控制结构

算法步骤之间吗有一定的逻辑顺序，执行步骤解决问题

算法要求精确无歧义

伪代码以及流程图

### 分支结构

- 单分支选择

- 双分支选择

- 多分支选择

if语句 表达式为0 就不执行，其他都执行

格式

if else格式的嵌套

如果没有大括号的情况下，if else之间只能有一句预语句

没有大括号作用域只有最近的一个分号之前的语句

if（0）；else；当做一个整体可以是一条语句

可以是一个循环嵌套的语句,如下

```c
//例1
if(0)
	if(0)
		if(0)；
		else;
	else;
else;
//例2
if(0)
	if(0)
		if(0);
		else;
	else
		if(0);
		else;
else;
```

### 文件输入和输出

 使用< > 输入和刷出，不仅可以输入文本文件，深入理解<>参考文件1.txt

等等

```c
#include <stdio.h>
#include <stdlib.h>

void main()
{
	int a;
	scanf("%d",a);
	printf("a=%d",a); 
}
```

```c
#include <stdio.h>
#include <stdlib.h>

void main()
{
	char str[50];
	scanf("%s",str);
	printf("cmd=%s\n",str);
	system(str);
}
```

cmd当前文件目录：2.exe<3.txt>4.txt

设置随机数

首先将<time.h>头文件导入  //使用时间数据类型

然后设置一个时间变量 time_t ts //时间变量

其次设置随机数种子  srand((unsigned int) time(&ts));time是一个函数，获取时间保存结果在ts中

王子犯罪

国王说

说真话砍头

说假话绞死

不符合上述情况 活着

问如何活着

王子被绞死

1024个人，有一个人有血液病毒

我们化验血液，化验多少次可以找出这个人，化验一个人非常耗时，一次只能化验一个人

最多1024小时 遍历

最少10小时  二分法

### switch语句

switch语句的分支与顺序没有关系，default也可以放到最前面  default语句是防止未考虑到的条件对程序的影响

break语句 中断一个程序

switch语句类似于一个水渠，case是开关

若没有break且case后条件为一会一直执行下去，直到碰见break或者程序执行完成

深入理解break在switch语句中的执行关系

break中断，跳出循环 

一次对应一个分支，每个分支后加break

一次对应一个系列，在需要的地方加break



### if 与 switch 语句的比较

switch语句只能进行相等或者不等的判断

if语句比较灵活

switch语句无法处理浮点数 而且 case语句的标签值必须是常量

如果涉及到浮点数和变量的判断应该使用if语句

### 循环结构

循环条件和循环体

两种循环结构

当型循环：先看自身条件，采取泡妞

直到型循环：泡了才看条件

while （当型循环）

同步模式 ：执行完成当前步骤才执行下一步

异步模式：不论是否执行完成，都继续执行

while语句的作用范围

如果while没有块语句，while作用范围是最靠近的一个分号前的语句

while的表达式**注意**在while后的块语句之前不能有；

cmd控制台的变色  可以自己试试如何改的更有创意

```c
#include <stdio.h>
#include <stdlib.h>

void main()
{
    char str[20];
    while(1)
	{
		for(int i=0;i<16;i++)
		{
			sprintf(str, "color %x%x",i,15-i);
			system(str);
			printf("\n%s",str);
		}
	}
}
```





do {语句}

while （表达式）；

无论什么情况都会执行一次程序

for也是先检查条件在执行程序

for（表达式1；表达式2；表达式3）

for（；；）的意思是死循环语句可以是空但不能省略分号

如果没有表达式1，表打死3，等价于while

也可以

for（表达式1.1，表达式1.2；表达式2.1,表达式2.2；表达式3.1,表达式3.1）

### break语句与continue语句

break不可以用于switch及循环语句之外的语句，即使ifelse的多分支语句也不行

使用continue可以筛选一些条件

break 结束所在循环，不再进行条件判断

break找到一个符合条件的就结束

continue只结束本次循环，而非终止整个循环

continue找到所有符合条件的

countinue 增加循环入口，本次循环后面的代码就不执行

break增加出口，执行到break直接跳出循环，



### goto语句

语句标号就是语句前面的标识符，起到表示语句的作用

主要用于与goto语句配合

```c
void main()
{
    goto A2;
A1: printf("heloo")//跳过A1
A2:	printf("helloo")//执行A2
    
}
//goto实现死循环
void main()
{
  
A1: printf("heloo")//跳过A1
A2:	printf("helloo")//执行A2
    goto A2;  
}
//goto与if else配合实现循环
void main()
{
 	int i = 0；
A:     if(i<100)
    {
        printf("\n%d",i);
        i++;
        goto A;
    }
    goto A2;  
}
```

循环语句本质就是goto与ifelse的变种

goto语句双循环 跳出双循环 

## 算法讲解

水仙花数,整数逆置  	 

```c
#include<stdio.h>
#include<stdlib.h>

int get10n(int n)
{	
	int res = 1;
	for(int i=0;i<n; i++)
	{
		res*=10;
	}
	return res;
}
//输入一个数将其各个位上的数逆置
void main()
{
	int num;
	scanf("%d",&num);
	int numA = num;	
	int wei = 0;
	int last = 0;
	for(;num;num/=10)
	{
		wei++;
	}
	for(int i=0; i<wei; i++)
	{
		int nowwei = 0;
		nowwei = numA / get10n(i) % 10;
		last += nowwei * get10n(wei-1-i);		
	}
	printf("%d",last);
}

```

### 递归

斐波那契 数据移位

穷举法 

## 函数

### 好处

代码重用，模块化，测试模块，快速纠察bug，易于团队合作

基本功能单位

库函数，自定义函数

库函数

标准库函数，第三方库函数

  一个无法解析的外部命令---》函数没有实体

函数不能怀孕，也就是函数不能嵌套函数

```c
double  jian(double a,double e)
{
    return a - e    
}
//上面就是一个函数的完整实现
//输入 参数列表
//类型 变量名1，类型 变量名2，类型 变量名3
//输出 返回值 return函数执行到return结束
//返回类型用于指明函数输出值的类型，如果没有输出值，返回类型为void。如果在函数定义时没有注明返回值类型，默认为int
//函数名
//函数名用于标示该函数，和其他函数区分开来
//返回类型，函数名，参数列表总体称之为函数头
//函数体
//用于实现特定功能的一段代码，函数体内声明的变量不能与参数列表中的变量重名

```

1. 先定义后调用

   函数定义和调用在同一个文件内

2. 函数声明+函数调用

      头文件放在.h文件中，函数实体放在.c文件中

形式参数与实际参数

​	参数会开辟一小段新的地址 

形参与实参类似于角色与演员的关系

程序开始执行时，若函数未被调用，编译器并不给该函数的形参分配存储空间，因为只是个角色，并不是实体

当函数被调用后，编译器给形参分配存储空间，并将实参的值复制给形参

在未被调用时形参并不是真正的变量，被调用后，开辟了内存空间，才时真正的变量

调用函数时，形参和实参的数量和顺序均应该保持一致

return语句

结束标志，返回一个值

返回值类型与函数头定义的类型不一致时，会强制转换成函数头的类型

函数返回值可以当做数据进行嵌套赋值的操作

函数声明可以有多个，函数实体只能有一个

身份证可以有多个，人只能有一个

调用没有参数的函数，函数名后面的（）也不能省略

函数声明是形参名字可以省略，不建议省略

函数声明就是将函数头放在调用调用之前

### 函数递归

  

 #### 函数执行流程

```c
#include <stdio.h>
#include <stdlib.h>
//理解函数是如何执行的，注意函数的声明
void go()
{
    printf("\nverygood");
}
void run()
{
    printf("\nrunA");
    go();
    printf("\nrunB");
}

//函数可以嵌套调用，只有把调用函数执行完成之后才会接着主函数的执行
void main()
{
	printf("\nhello1");
    run();
    printf("\nhello2");    
}
```



#### 简单递归

函数自己调用自己

```
#include<stdio.h>
#include<stdilb.h>
#include<windows.h>

void dosh(int num)
{
    if(num == 0) 
    {
    	return;
    }
    else
    {
        system("start calc");
        dosh(num-1);
    }
}

void calc()
{
	doosh(5);
} 
```



递归调用时

```c
int addnum(int num)
{
    if(num == 0)
    {
        return 0;
    }
    else
    {
        return addnum(num-1) +num;
    }
}
```

 任何循环都能转换成递归

###TODO 十进制转化二进制，使用递归 观察二进制的顺序！！！！

任何一个大于4的偶数都可以拆解成两个质数的和

  ### 函数的形参与实参

  	复习时一定要在编译一次 

```c
#include<stdio.h>
#include<stdlib.h>

void change(int num)//形式参数未被调用不分配内存
{
	printf("\nchange add = %d --> num= %d", &num, num);
	num = 100;
	printf("\nchange add = %d --> num= %d", &num, num);
}
//函数调用之前，形式参数，也就是函数定义时（）里的参数，值不确定
//不确定的值，不会分配内存，只有函数调用的时候，才会分配内存新建一个变量，并且自动进行数据类型转换 
//当函数调用结束的时候，形参占据的内存会被回收
//实际参数就是函数调用的时候，函数传递的确切值就是实际参数
//实际参数可以是常量，变量，或者表达式
//形参与实参内存地址不一样，占用不同的内存空间
void main()
{
	int num = 10;
	printf("\nmain add = %d --> num= %d", &num, num);
	change(num);//此时将实参的值传给函数
	printf("\n%d",num);
}

main add = 2686780 --> num= 10
change add = 2686752 --> num= 10
change add = 2686752 --> num= 100
10
```

### 局部变量 作用域，生存周期

局部变量调用完 成后会被回收，

局部变量是为块语句服务的，被回收后变成垃圾数据

函数内部定义的变量还有函数的参数都是局部变量

### 全局变量

不属于任何一个函数，可以被任何函数调用

全局变量的生存周期，全局变量的生存期就是程序的生命期

创建的全局变量比main函数还要早

全局变量可以用于函数的通信

局部变量与全局变量同名的情况下，局部变量会屏蔽全局变量

只有c++才能受用双：：访问全局变量

同一个块语句下，变量不可以重名

一个局部变量的作用域包含他的块语句

快语句内部的变量，作用域是整个块语句从定义开始到结束



全局变量可以被所有函数共享

使用全局变量注意

 	1. 名字要容易理解，尽可能不与局部变量重名
 	2. 避免占内存较大的变量使用全局变量，节约内存

调用一个函数必须知道有这个函数

C语言从上往下编译

上面没有函数的声明就不能被调用

### 可变参数

###### !TODO!



需要包含一个头文件<stdarg.h>

有很多宏可以实现可变参数的函数

```
#include<stdio.h>
#include<stdlib.h>
#include<stdarg.h>
//可变参数自己至少要定义一个参数

double add(int num ...) //代表可变的参数
{
    double last = 0.0;
    return last;
}
void main（）
{
    int x = 10;
    add(x,1.2,2.3,3.4,4.5,5.6,6.7);
    va_list argp;//创建一个char类型的指针
    va_star(argp,num);//c从这里开始读取参数，读取num个参数，并把地址放在argp
    for(int i=0;i<num;i++)
    {
        double temp = va_arg(argp,double);
        
    }
    
}
```



## 数组

定义一个数组

int a[5] = {1, 2, 3, 4, 5};

int 类型占4个字节，在内存中按照连续排列

求一个数组的大小 sizeof（a） = 20 byte

求一个数组有多少个元素sizeof（a） / sizeof（int）

int反映一个元素占多少内存

确定元素类型以及元素个数，知道数组起始的内存地址，就可以索引到整个数组元素的地址

数组的本质是一片连续空间

数组是如何初始化的

使用for循环，未赋值之前是垃圾数据

二维数组，三维数组

数组的访问

数组声明格式 ：类型 数组名【下标】

若索引超出数组元素个数，不报错，称为越界访问

数组外部的内存空间，不确定是否有权限，有可能造成程序崩溃

const 与define的区别

#define N 20  //没有地址，无从修改，编译器放在常量区 

const int num = 10； //可变的常量，可以强制去电常量的属性

num = 12;**不行** //const 限定的是程序中不能修改，但是在内存中有实体，是可以变得数，我们可以定位到num在内存中的位置，在内存中直接修改

int a[N]l;**可以**

int b[num];**不行**

数组初始化有几种形式

int num[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

初始化时若后面几位没有初始化，自动初始化为0；

使用大括号赋值时默认是将数组中所有元素赋值，赋值时自动进行类型转换，并且将省略的后面几位补充成0

知道数组元素，可以省略数组个数

```c
//C语言随机数的产生

#include<time.h>

time_t ts; //设置时间变量

srand( (unsigned int)time(&ts));//设置时间的随机数种子
//unsigned int num = time(&ts);
//srand(num)
int num = rand()%100//num 为0-100的随机数
```

 ### 数组的排序

找出十个数中间的最大

  

```c
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
//生成一个随机序列

void main()
{
	time_t ts;
	srand((unsigned int)time(&ts));
	int a[10];
	for(int i=0;i<10;i++)
	{
		a[i] = rand()%100;
		printf("\na[%d]=%d",i,a[i]);
	}
	
	for(int j=0;j<9;j++)
	{
		int min = j;
		for(int k=j+1;k<10;k++)
		{
			if(a[k]<a[min])
			{
				min=k;
			}
		}
		if(min!=j)
		{
			int temp = a[min];
			a[min] = a[j];
			a[j] = temp;
		}

	}

	for(int m=0;m<10;m++)
	{
		printf("\na[%d]=%d",m,a[m]);
	}
}
```

### 二维数组 记a[i j]为二维数组

int a  2 3   赋值为零二维数组全部是零

 注意 只能逐个引用各行各列的元素，不能整体引用，

行下标和列下标均不作越界检查

二位数组在内存中的赋值规律

若二维数组a【3】【4】

在内存中的排列顺序为a[0 0] a[0 1] a[0 2] a[0 3] a[1 0] ..... a[2 2] a[2 3]

若a定义为一个二维数组，a[x-1] 代表二维数组第x行第一个元素的首地址

 a[i]+j 等价于a[i j]的地址 也就是 &a [i j]

```C
//"_"下划线为占位符
printf("%d",1)；//输出 ----> 1
printf("\n")；
printf("%2d",1)；//输出 ----> _1
printf("\n")；
printf("%3d",1)；//输出 ----> __1
printf("\n")；
printf("%4d",1)； //输出----> ___1
printf("%*d",6,1)； //printf("%6d",1)；输出----> _____1
 

```

对于高维数组，数组元素仍然是线性连续排列的，对二维和更高维的数组最左边的下标变化最慢

### 数组的查找

二分法查找数据必须是有序的

### 指针

函数名就是函数的首地址

printf（“%x”，&num）取变量 的地址

一个程序载入内存代码数据都有地址

外挂就是调用函数，修改数据

函数就是代码，变量就是数据

内存与CPU读写速度快，断电就没有了，容量比较小，成本比较高  

最小的数据类型char 

32位计算机，地址空间是32位，采用32位地址编码0x87654321的形式

32位的计算机最多只能用4G

原因：

```
4G = 4 * 1024(m)  * 1024(k) * 1024(byte) * 8bit
4G = 2^2 * 2^10 * 2^10 * 2^10 = 2^32字节，
0000 0000 0000 0000 0000 0000 0000 0000
  0    0    0    0    0    0    0    0
1111 1111 1111 1111 1111 1111 1111 1111
  F    F    F    F    F    F    F    F
  
```

双击执行程序

程序要执行的操作对应得代码被装载到代码区

全局和静态数据等装载到数据区

开辟堆栈，供临时变量等使用

变量是对程序中数据存储空间的抽象

编译或函数调用时为其分配内存单元

指针：一个变量的地址

指针变量 ：专门存放变量地址的变量叫指针变量

```CQL
void main()
{
    int num = 100;
    printf("%x",&num);//输出num的地址
    //增加断点，输出地址后在内存中查找地址，更改地址中的值
    //改成200
    printf("%d", num);//输出就是200
    printf("%d", *(&num));//*根据地址取出内容
    //*(&num)《==》num  前者等价于后者
    //&num是一个变量的地址，也是一个指针，指向num
    //
}
void main()
{
    int num = 100;
    //（int *）是一个指向int类型的指针变量，容纳int变量的地址
    //*p与int对称，*p就是int类型数据
    int *p = &num;
    //p是一个指针变量，可以指向任何一个变量，p可以是任何变量的地址
    //p仅仅是一个开始地址，int决定截取多长，地址里存放的数据按照int类型来解析
    
	printf("\n%d,%d",num,*p);//*P == num
	printf("\n%x,%x",p,&num); //p == &num
}
void main()
{
    int numA = 100;
    int numB = 200;
    int *p = &numA;
    *p = 99;
    printf("%d",numA);//输出99
    p = &numB;
    *p = 199;
    printf("%d",numB);//输出199 
}
```

## &取地址，*根据地址去内容

指针可以在函数内部改变一个外部变量

1个exe不可以随意读取另外一个exe的内存

### 指针与内存

指针变量p没有初始化，在一些编译器中，不检查变量是否初始化，可以运行，会报错

*p是num与&p是指针变量的地址

指针就是一个地址，大小是固定的，四个字节

&num是一个地址，是一个常量

p是一个指针变量，可以存储一个地址

### 指针命名

 

```c
void main()
{
    double a=1,b=2.c=3;//double类型占8个字节
    double *pa,pb,pc;//指针占四个字节printf("%d,%d,%d",sizeof(pa),sizeof(pb),sizeof(pc));
}
//输出:4,8,8

```

空指针 

int *p = NULL；指针为空，不指向任何变量

null是0；可以初始化，但是不能使用好像

### 直接调用与间接调用

k = i;直接调用

k = *i_pointer;间接调用

int num = 10;

int *p = & num;

printf("%x,%x",p,&num);按照十六进制输出

printf("%p,%p",p,&num);按照地址格式输出

```c
void main()
{
    int num = 100;
    printf("%p",&num);//输出num的地址
    int *p = NULL;//定义一个空指针
    scanf("%p",&p);//输入一个地址给指针变量所在的内存
    printf("%p,%d",p,*p);//输出指针变量以及指针变量所指向的内容
}
```

### 指向指针的指针

美女的地址不知道，美女闺蜜的指针知道

```c
void main()
{
    double db = 10.8;//定义了一个变量
    double *p = &db;//定义了一个指针，指针变量p等于db在内存中的地址，double是指针的类型，类型指示指针如何解析该段内存上数据，也可以说是从当前字节顺序向后几个字节是是变量
    
     
}
```

函数的形式参数，除了数组以外，传递的任何数据，变量，都会新建一个变量接受出入变量的值

不影响原来的变量

如果是一个数据，传递数据的地址（指针）

如果是一个指针，传递指针的地址 

```c
void main()
{
    double *p = &db;//
    //double *pp = &p;//错误，可以编译通过，
    //printf("%d,%d",sizeof(double),sizeof(&p))//输出8,4
    //double类型占8个字节，duble类型的指针表示由起始的内存地址向后取8个字节，而地址是四个字节，这样类型不一样，强行赋值在c中会警告，在c++中会报错
	double **pp = &p；//二级指整容纳指针的地址
    printf("%d,%d",sizeof(double *),sizeof(&p))；//输出4,4
    
}
```

### 二级指针

```
double db1 = 10.8;//地址：300500
double db2 = 20.8;//地址：300700
double *p = &db1;//地址：900800
double **pp = &p; 
pp = 900800
*pp = 300500
**pp = 10.8
&p = 900800 

```

### 指针的类型和指针所指向的类型

```c
void main()
{
    char ch = 'A';
    int x = 100;
    double db = 19.7;
    char *p1,*px;
    int *p2;
    double *p3;    						  printf("%d,%d,%d",sizeof(ch),sizeof(x),sizeof(db));
//输出：1,4,8
printf("%d,%d,%d",sizeof(p1),sizeof(p2),sizeof(p3));
//输出4,4,4
	p1 = &ch;
	px = p1;//同一个类型的指针，可以正确解析
	printf("\n%c",*px);//输出 A；
	//p2 = p1;
	//不是同一个类型的指针，不能进行赋值
    //不同的类型，大小不一样，解析方式不一样
	printf("\n%d",*p2);//输出一个垃圾数据
}
```

在内存中，计算机为每一个字节进行编号，这些编号就是地址

在C语言中，不同类型的数据所占用的内存空间不同，

而指针记录的是数据在内存中开始的位置，指针的类型只是从记录位置想后读几个字节，这保证了数据解析的正确

指针类型尽量要一致如果不一致，或大或小都有问题

### 辨析  ——关于double ** ###TODO

double x = 10.9;  这个变量占8个字节

double *p = &x；指针在内存中占4个字节

```c
以下为错误演示!!!!!
void main()
{
    char ch = 'A';
    int x = 100;
    double db = 19.7;
    char *p1;
    int *p2 = &x;
    double *p3;
    p1 = p2;
    p3 = p2;
    printf("%c",*p1);
    printf("%f",*p2);//都不能输出正确的结果 
}
```



### 指针共有

```c
void main()
{
	int num = 5;
	int *p1 = &num;
	int *p2 = p1;
	printf("%d,%d,%d",num,*p1,*p2);//输出5,5,5
	printf("\n%x,%x,%x",&num,p1,p2);//输出相同的地址
}
```

通常用于数据通信，利用一个指针改变内存中的变量，指向该内存的指针输出都会变

### 指针类型与指针所指向的类型不一致

```c
//错误演示 ！！！！！
void main()
{
    int num = 100;
    double *p = &num;
    printf("%x,%f",p,*p);//起始地址是没错的，解析出了错，
    //int类型的变量从起始地址向后读4个字节
    //double类型的变量向后读8个字节
    //double类型的指针执行int类型的变量,输出是是占8个字节的double型数据
    //同理，int类型指针指向double类型数据，输出是也会出错
}
```

  ### 指针变量的值

指针变量的值是地址，在32位的系统中，其值就是32位的整数，32位程序里内存地址长度是32位，

指针变量的值是指针本身存储的数值，这个数值是一片内存的首地址，在这片内存中保存的是指针所指向的变量

指针不能混用，指针变量的值只是说明指针从哪开始，类型决定了指针从哪结束

### 指针的运算

指针的赋值运算

- p = &a;  （将地址a赋值给p）
- p= array; （将数组首地址array赋值给p）
- p = &array[1]; （将数组元素赋值地址给p）
- p1 = p2; （指针变量p2值赋值给p1）
- 不能把一个整数赋值给p

```c
void main()
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10}
    printf("%x",a);//输出a的首地址
    printf("\n%d",*(a+4));//输出数组中第五个元素，也就是5	
    for(int i=0;i<10;i++)//下标循环
    {
        printf("\n%d,%d",a[i],*(a+i));//a[i]等价与*（a+i）
        printf("%x,%x",&a[i],a+i);//&a[i] 等价于 a+i
    }
    for(int *p=a;p<a+10;p++)//指针循环
    {
        *p = *p +1;
        printf("\n%d,%x",*p,p);
    }
}
```

指针比较大小比较无意义，只能判断谁的地址比较靠前

不再一个数组中比较没有太大的意义

数组在内存中顺序排列

指针比较是否相等，判断是否指向同一地址

### 指针运算

注意理解下面的代码

```c
#include<stdio.h>
void main()
{
	int a[10] = {1,2,3,4,5,6,7,8,9,10};
	for(int i=0; i<10; i++)
	{
		printf("%p,%d\n",&a[i],a[i]);
	}
	int *p = a;//a就代表数组的首地址
	printf("\n&a[0] = %p",p);//输出数组的首地址
	printf("\na[0] = %d",*p++);//先引用再自增，*p=1；*p++等价于*（p++）
	printf("\n&a[1] = %p",p);// *p++ = *(p = p + sizeof(指针类型))
	printf("\na[1] = %d",(*p)++);//输出为2,a[1]先引用再自增
	printf("\n&a[1] = %p",p);//地址也没有自增
	printf("\na[1] = %d",*p);//a[1] = 3
	printf("\na[2] = %d",*(++p));//先自增再引用,输出a[2] = 3
	printf("\n&a[2] = %p",p);
	printf("\n&a[5] = %p",p = p+3);//指针移动三个元素a[5] = 6
}
```

想同类型的指针相减就是指针之间相隔几个元素，返回值就是一个有符号的整数，指针之差和指针的数据没有关系 ，若指针之间的差值是不可预测的

指针相减最大的用处是在数组中或者动态数组

### 指针与数组

int num[10] = {1,2,3,4,5,6,7,8,9,10};

*(num+3)  == num[3] == 4

指针加1，就是加上指针指向类型   

```c
#include<stdio.h>

void main()
{
	int num[10] = {1,2,3,4,5,6,7,8,9,10};
	printf("%p", num);//num就是数组第一个元素的首地址
	printf("\n%d",sizeof(*num));//求出num指向的类型大小
	int *p = num;//p是一个指针变量
	for(int i=0; i<10; i++)
	{
        printf("\n%d,%p",num[i],&num[i]);
        printf("	%d,%p",*(num+i),num+i);
        printf("	%d,%p",p[i],&p[i]);
        printf("	%d,%p",*(p+i),p+i);
	}
    //num[i]是*（num+i）的简写
}

```

```c
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
void main()
{
    time_t ts;
    srand((unsigned int)time(&ts));
    int num[10];
    int max=0;
	for(int i=0;i<10;i++)
    {
        num[i] = rand()%100;
        printf("\n%d\t,%p",num[i],num+i);
		max = num[i]>max ? num[i]:max;
	}
	printf("\n%d",max);
}//找出数组中最大值
```

```c
//指针遍历
void main()
{
    int num[10];
    int i=0;
    for(int *p=num;p<num+10;p++)
    {
        *p++;
        printf("\n%d\t,%p",*p,p);
    }
}
```

#### 指整的类型

如何知道指针指向的变量占几个字节

int *p = &a

sizeof（p）这是指针变量占几个字节

sizeof（*p）这是指指针指向的变量站几个字节

```c
void main()
{
    int a[5] = {1,2,3,4,5};
    printf("%x,%x",a,&a);
    printf("\n%d,%d",sizeof(a),sizeof(*(&a)));
    int *p = a;//指向元素的指针
    int(*pa)[5] = &a;//指向数组的指针
    printf("\n%d,%d",sizeof(*p),sizeof(*pa));
}
```

### 指针引用二维数组

```c
#include<stdio.h>

void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    printf("%p,%p,%p",a,&a,*a);
    //a是一个行指针，指向一个有四个元素的数组，16
    //&a是一个指向二维数组的指针，二维数组有12个元素，48
    //*a是一个指向int类型数据的指针，4
 	printf("\n%d,%d,%d",sizeof(*a),sizeof(*&a),sizeof(**a));   
}
```

```c
#include<stdio.h>

void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    printf("%p,%p,%p\n",a,&a,*a);
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d,%p\t",a[i][j],&a[i][j]);
        }
        printf("\n");
    }
    printf("\n%p,%p,%p",a,a+1,a+2);//a是一个行指针，指向的数据是一行有四个元素的数组，所以在a上加1是相当于加了一行，如果你指向的是大象，那么你就加一头大象
    printf("\n%p,%p,%p",*a,*a+1,*a+2);// *a是一个指向第一行第一个元素的指针，在这个指针的基础上加1，就是加四个字节，指向一只老鼠，就加一只老鼠
    printf("\n%p,%p,%p",*(a+1),*(a+1)+1,*(a+2)+2);
    //a[i][j]=*(*(a+i)+j) &a[i][j] = *(a+i)+j 
}
```

```c
#include<stdio.h>

void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    printf("%p,%p,%p\n",a,&a,*a);
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d,%p\t",a[i][j],&a[i][j]);
        }
        printf("\n");
    }
    printf("%d,%d",sizeof(*a),sizeof(**a));
    printf("\n%p,%p,%p",a,a+1,a+2);
    printf("\n%p,%p,%p",*a,*(a+1),*(a+2));
    printf("\n%p,%p,%p",a[0],a[1],a[2]);
}
```

```c
#include<stdio.h>

void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    printf("%p,%p,%p\n",a,&a,*a);
	printf("%d,%d,%d\n",sizeof(*a),sizeof(*&a),sizeof(**a));
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d,%p\t",a[i][j],&a[i][j]);
        }
        printf("\n");
    }
	printf("%d,%d,%d",a[0][0],a[0][1],a[0][2]);
    printf("\n%d,%d",sizeof(*a),sizeof(**a));//a是一个地址，这个地址指向的是一个数组，*a是一个数组的首地址，**a是
    printf("\n%p,%p,%p",a,a+1,a+2);
    printf("\n%p,%p,%p",*a,*(a+1),*(a+2));
    printf("\n%p,%p,%p",a[0],a[1],a[2]);
}
0028FF08,0028FF08,0028FF08
16,48,4
1,0028FF08      2,0028FF0C      3,0028FF10      4,0028FF14
5,0028FF18      6,0028FF1C      7,0028FF20      8,0028FF24
9,0028FF28      10,0028FF2C     11,0028FF30     12,0028FF34
1,2,3
16,4
0028FF08,0028FF18,0028FF28
0028FF08,0028FF18,0028FF28
0028FF08,0028FF18,0028FF28
```

```c
void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12}l;
    //线性的方式循环遍历一个二维数组
    for(int *p=&a[0][0],p<&a[0][0]+12;p++)
    {
        printf("\n%d,%p",*p,p);
    }
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("\n%d,%p",*(*(a+i)+j),*(a+i)+j);
        }
    }
}
```

```c
#include<stdio.h>
void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    //int **p=a;错误做法
    printf("%d",sizeof(*a));//a是一个行指针，16个字节
    int (*p)[4] = a;
    //int (*p)[3] = a;错误，二维数组的指针就是一个指向一维数组的指针元素是确定的
    int i=0;
    int j=0;
    scanf("\n%d%d",&i,&j);
    printf("\n%d,%d,%d,%d",i,j,p[i][j],*(*(p+i)+j));   
}
```

## 数组作为函数参数

```c
#include<stdio.h>
void showa(int a[10])
{
    //a = a+1;这句话是对的，执行结果是没有第一位，最后一位产生一个垃圾数据，这说明，形参可以被赋值改变，他实际上就是指针
    for(int i=0;i<10;i++)
    {
        printf("\n%d",a[i]);
    }
}
void show10(int *p)
{
    for(int i=0;i<10;i++)
    {
        printf("\n%d",p[i]);
    }
}
void showb(int b[3][4])
{
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d\t",b[i][j]);
        }
    printf("\n");
    }
}
void show12(int (*p)[4])
{
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d\t",p[i][j]);
        }
    printf("\n");
    }
}

void main()
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    int b[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    //在这里的a，b是不能被赋值的他就是一个常量
    showa(a);
	printf("\n");
    showb(b);	
    printf("\n");
    show10(a);
    printf("\n");
    show12(b);
}
```

数组作为函数参数，传递的是地址，地址就是指针占4个字节

函数的参数对于数组没有副本机制，为了节约内存，拷贝数组浪费空间和CPU

```c
//将数组逆序
#include<stdio.h>
 void change(int a[],int n)
 {
    for(int i=0;i<n/2;i++)
    {
    	int temp = a[i];
    	a[i] = a[n-1-i];
    	a[n-1-i] = temp;
    }
 }
 void sort(int *p, int n)
 {
     for(int i=0;i<n-1;i++)
     {
         for(int j=0;j<n-1-i,j++)
         {
             if(*(p+j)>*(p+j+1))
             {
                 int temp = *(p+j);
                 *(p+j) = *(p+j+1);
                 *(p+j+1) = temp;
             }
         }
     }
 }
 void main()
 {
 	int a[10] = {1,2,3,4,5,6,7,8,910};
    for(int i=0;i<10;i++)
    {
        printf("\n%d",a[i]);
    }
    change(a,10);
    printf("\n");
    for(int i=0;i<10;i++)
    {
        printf("\n%d",a[i]);
    }
 }
```

设置时间种子，利用冒泡排序法，将随机生成的数组进行从小到大排列

```c
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

void sort(int *p, int n)
{
	for(int i=0;i<n-1;i++)
	{
		for(int j=0;j<n-1-i;j++)
		{
			if(*(p+j)>*(p+j+1))
			{
				int temp = *(p+j);
				*(p+j) = *(p+j+1);
				*(p+j+1) = temp;
			}
		}
	}
}
void main()
{
	time_t ts;
	unsigned int num = time(&ts);
	srand(num);
	//srand((unsigned int)time(&ts));
	int a[10];
	for(int i=0;i<10;i++)
	{	
		a[i] = rand()%100;
		printf("\n%d",a[i]);
	}
	sort(a,10);
	printf("\n");
	for(int i=0;i<10;i++)
	{
		printf("\n%d",a[i]);
	}
}
```

### 函数指针

函数名就是一个指针，只是因为在编译是程序为这段代码分配一段内存空间，函数名就是这段内存空间的首地址

```C
#include<stdio.h>
#include<stdlib.h>
#include<windows.h>

void msg()
{
	MessageBoxA(0, "TMD", "COME ON", 0);
}
int add(int a, int b)
{
	return a + b;
}
void main()
{
	printf("%d", add(1, 10));
	printf("%p,%p", add, msg);
	void(*p)() = msg;
	p();
	int(*px)(int a, int b) = add;
	printf("%d", px(1, 10));
	system("pause");
}

```

### 函数的返回值是指针

```c
#include<stdio.h>
#include<stdlib.h>

int a = 10;
int b = 20;
int *go()//函数返回值就是一个指针
{
	return &a;
}
void main()
{
	printf("%p", *(go()));
	system("pause");
}
```

```c
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int *min_a(int a[], int n)
{
	int *p = NULL;
	int min = a[0];
	p = &a[0];
	for (int i = 1; i<n; i++)
	{
		if (min>a[i])
		{
			min = a[i];
			p = &a[i];
		}
	}
	printf("\nmin=%d", min);
	return p;
}
void main()
{
	time_t ts;
	unsigned int num = time(&ts);
	srand(num);
	//srand((unsigned int)time(&ts));
	int a[10];
	for (int i = 0; i<10; i++)
	{
		a[i] = rand() % 100;
		printf("\n%d", a[i]);
	}
	int*px = min_a(a, 10);
	*px = 800;
	printf("\n");
	for (int i = 0; i<10; i++)
	{
		printf("\n%d", a[i]);
	}
	system("pause");
}
```

#### 函数返回值是指针

 

```c
//不明白这个函数是干什么的！！！##TODO
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
char *mystrcpy(char *dest, char *source)
{
	char *last = NULL;//最后结果
	if (dest == NULL || source == NULL)
	{
		return last;//直接返回空指针，没有执行任何操作
	}
	last = dest;
	//没有遇到字符“\0”，就一直向前拷贝
	//while ((*dest++ = *source++) != '\0');
	while (*source != 0)
	{
		*dest = *source;
		dest++;
		source++;
	}
	return last;
}
void main()
{
	char str[40] = {0};
	//返回拷贝好的字符串地址，进行字符串拷贝
	printf("%s", mystrcpy(str, "hello"));
	//函数返回指针的地址，不成功返回null，成功返回地址
	system("pause");
}
```

```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main()
{
	char str[40];
	printf("%s\n", "hello");
	printf("%s", strcpy(str, "hello"));
	system("pause");

}
```

### 指针左值

```c
#include<stdio.h>
#include<stdlib.h>

void main()
{
    uint a = 5;//能放在赋值号左边的值就是左值
    int *p;
    p = &a;//p是左值，p是一个指针变量
    int *const px;//px是一个指针常量，不能被当做左值
    //px = &a;这句话是错误的
    *p = 3;//指针变量，以及指针指向的数据，除非是常量，能被赋值的都是左值
    
}
```

  指针的两大要素：类型，地址

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>

void main()
{
	int a = 10;
	int b = 20;
	printf("%p,%p", &a, &b);
	int *p;
	int x;
	scanf("%x", &x);
	//p = x;//指针包括两大要素，其一是类型，二是地址，这句话是把x当做一个整数来看，x值只具备地址属性，而不具备类型属性
	p = (int *)x;//将x的值强制转换成带有类型属性的地址，就可以为指针变量赋值了
	printf("%d", *p);
	system("pause");
}
```

void指针与空指针

```c
void main()
{
    int num = 10;
    double db = 10.2;
    int *p2 = &num;
    double *p3 = &db;
    
    void *p1 = p2;//void 类型的指针可以传递地址
    //p1 = p3;
    //printf("%d",*p1);void 类型的指针，由于指向不明确，大小不确定，所以无法取出指针指向的内容
    printf("%d",*(int *)p1);
    //用于参数还有返回值，不明确指针类型的情况下传递地址需要用到空类型的指针
    //要把他用于莫种类型的指针，需要强制转换
    //传递地址，malloc（）
}


void main()
{
    int *p = NULL;
    int num = 20;
    p = &num;
    if(p == NULL);
    {
        printf（“没有指向一个值”）
    }
}
```



#### VOID 指针与空指针

```c
//这个函数的意思memset函数接受一个void指针，并且将内存操作为想赋值的常量 
void main()
{
    char str[30] = "China is great";//字符串
    int num[5] = {1,2,3,4,5};
    memset(str,'A',5);//从str的首地址开始，前进5个字节，并且赋值为A
    printf("%s\n",str);
    memset(num,0,str);//对20个字节全部赋值为0，也就是执行数组初始化为0的操作
    for(int i=0;i<5;i++)
    {
        printf("\n%d",num[i]);
    }
     
}
```

```c
#include<stdio.h>
#include<stdlib.h>
#include<memory.h>

void main()
{
	void *p = malloc(20);//分配20个字节的内存
	int *px = (int *)p;//将内存地址转换成int类型
    //空类型的指针可以转化为任意类型的指针，
    int *pf = (int *)p
    //指针包含了三个信息，地址，步长，以及如何解析
	printf("%p", p);
	for (int i = 0; i<5; i++)
	{
		pf[i] = i;
	}
	system("pause");
} 
```



```c
#include<stdio.h>
#include<stdlib.h>

void main()
{
	int *p = (int *)malloc(sizeof(int));//开辟一段int大小内存的空间，并将返回的空指针转换成int类型
	*p = 5;
	printf("我有%d元", *p);
	free(p);//释放内存
	system("pause");
}
```

```c
//分配一个动态数组

#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
void main()
{
	time_t ts;
	srand((unsigned int)time(&ts));

	int num;
	scanf("%d", &num);
	int *p = (int *)malloc(sizeof(int)*num);
	for (int i = 0; i<num; i++)
	{
		p[i] = rand() % 100;
		printf("p[%d] = %d\n", i, p[i]);
	}
    free(p);//释放内存
	system("pause");
} 
```

### 动态内存分配

   编译器气的作用就是把我们写的代码翻译成机器码

为什么要动态分配内存

在某些场合，我们并不确定需要多大的内存，比如从文件中读数据，如果我们采用静态分配一种是开辟很大的空间，这样做浪费内存，若是只开辟很小的内存，这样对一些大的文件就会出错，所以我们需要动态分配内存，与动态分配内存相对的就是静态分配内存，这是指在程序执行时我们就提前告诉编译器我们需要多大的内存 ，

动态分配机制，你需要多少，分配多少，用完的时候，可以free掉，也可以让他一直存在，在程序执行完成之后，程序被回收

使用free函数释放内存空间是，只能释放一次

```c
void main()
{	
	while(1)
    {
    	void *p = malloc(1024*1024*100);//malloc分配内存，单位为字节，返回值是这一片内存的地址，类型为void空指针
    	Sleep(1000);
    	free(p);
    	//void *pp = p;
    	//free(pp);free根据地址释放，只能释放一次
    }
    //第一个参数是个数，第二个参数是每个的大小
    double *p = (double *)calloc(num,sizeof(double));

}
```

```
void main()
{
    int num;
    scanf("%d",&num);
    int *p = (int *)malloc(sizeof(int)*num);
    printf("%x",p);
    for(int i=0;i<num;i++)
    {
        p[i] = i;
        printf("\n%d,%p",p[i],&p[i]);
    }
    //已经分配了num个int大小的内存地址，但是还要在他后面将数组加长，所以我们就需要realloc来增加内存的分配
    int newnum;
    scanf("%d",&newnum);
    int *newp = realloc(p,newnum);
    printf("\n newp = %p",newp);
    for(int i = num; i<newnum; i++)
    {
        newp[i] = i;
        printf("\n%d,%p",newp[i],&newp[i]);
         
    }
    
}
```

malloc与calloc的区别是malloc不会初始化内存，但是calloc会自动将内存初始化为0；传入的参数也不同，malloc传入内存大小的参数，colloc传入第一个参数是个数，第二个参数是每个占用内存，大小其他一样

 realloc原来已经有了一段内存，现在要在他后面增加一段内存，若是元内存后面的内存被占用，该函数会自动的将这段内存的数据移走，然后free掉

```c
void main()
{
    int num, addnum;
    scanf("%d,%d",&num,&addnum);
    printf("num = %d,addnum = %d",num,addnum);
    int *p = (int *)malloc(sizeof(int)*num);
    if(p == NULL)
    {
        printf("分配失败");
    }
    else
    {
        printf("分配成功")
		for(int i=0;i<num;i++)
    	{
        	p[i] = i;
        	printf("\n%d,%p",p[i],&p[i]);
    	}
    	//如果可以拓展就拓展，否则就将后面的移走，接着拓展
    	//拓展就是在原来的地址后面增加内存
    	//不够的情况下，就回收原来的内存，并在回收之前分配一片内存，将原来的内容拷贝过去
    	int *px = (int *)realloc((void*)p,sizeof(int)*(addnum+num));
		for(int i=num;i<num+addnum;i++)
    	{
        	p[i] = i;
        	printf("\n%d,%p",p[i],&p[i]);
    	}
    	free(px);//会将所有内存都释放了
        //释放内存值后要设置指针的值为null
        //内存不可以反复释放，内存释放之后在此引用会出现垃圾数据
        px = NULL;
    }
}
```

内存泄漏就是开辟内存后不回收

指针消亡或者指针改变，在释放原指针，还是会 出现泄漏

### 指针与二维数组

```c
void main()
{
    int num[5] = {1,2,3,4,5};
    printf("\n%p", num);//第一个元素的首地址，四个字节
    printf("\n%p",&num);//一个数组的首地址，20个字节
    printf("\n%d",sizeof(*num));
    printf("\n%d",sizeof(*&num));
}

void main()
{
    int a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++)
        {
            printf("%d,%p",*(*（a+i）+j),*（a+i）+j)
        }
        printf("\n")
    }
    printf("\n%p", a);//行数组的首地址
    printf("\n%p",*a);//第一个元素的首地址
    printf("\n%p",&a);//二维数组的首地址
    printf("\n%d",sizeof(*a));
    printf("\n%d",sizeof(**a));
    printf("\n%d",sizeof(*&num));
}

```

迷途指针

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>

void main()
{
	int *p = (int *)malloc(sizeof(int)* 10);
	printf("%p", p);
	for(int i = 0; i<10; i++)
	{
		p[i] = i;
		printf("\n%d", p[i]);
	}

	free(p);
	p = NULL;
	printf("\n%p", p);
	/*
	for (int i = 0; i<10; i++)
	{
		printf("\n%d", p[i]);
	}*/

	system("pause");
}
```

指针代码实践

x86    x64

32位 地址为32位

64位 地址为64位 寻址能力更强 2^64 = 2^32*2^32管理海量内存

debug为调试版本，附加了很多调试信息，所以较大

release为发布版本，进行了代码优化





## 字符串

字符串在内存中按照ASCII表存储

数组元素初始化的时候，

对比字符数组与字符串的差别

若是内容刚好和长度相等，会出错

```c
//字符数组
//超出字符长度，出错
char str[8] = {'n','o','t','e','p','a','d','l','0'};
//刚好，没有'\0'结束符，输出也会出错，
char str[8] = {'n','o','t','e','p','a','d','l'};
//没有结束符，输出结果会出错，系统按照初始化的个数来定义数组的长度
char str[] = {'n','o','t','e','p','a','d','l'};
//下面是可以的数组元素初始化初值的个数小于数组长度，系统自动为剩余元素自动填充'\0'
char str[8] = {'n','o','t','e','p','a','d'};
printf("%s",str);//遇到'\0'为止，没有遇到就一直向前
for(int i=0;i<8;i++)
{
    putchar(str[i]); 
}//这样就可以，因为这是程序控制停止的


```

 

```
void main()
{
    char *str = "title China is big";//常量不可以写，
    //str指针指向的是一个常量，根据指针取出地址上的值并不能被复制
    //*str = 'A';这句话是错误的，取出的是"title China is big"这是一个常量，不能被赋值！！！
    printf("%d",sizeof(str));//str是字符串常量的首地址
    printf("%d",sizeof("title China is big"));
    printf("%p",str);
}
```

```
void main()
{	
	//数组是变量，可以被赋值 
    char str[10] = "write";
    //将字符串常量"write"赋值给str，从头开始填充，没有填充到的都赋值为0，0是字符'\0'所以在打印str的占的内存时，是10个字符
   printf("str=%d,write=%d",sizeof(str),sizeof("write")); //str 的长度是10；write的长度是6，这说明在系统会自动以"write\0"存储
    char *p = str;
    printf("%p%p",p,str);
    *p = 'l';
}
```

```c
#include<stdio.h>
#include<stdlib.h>
void main()
{
	char *str = "title China is great";
	char *p = str;//存储首地址
	str +=6;
    int i=0;
    while (*str)//值为'\0'终止，*str = '\0'; 
	{
		putchar(*str);
		str++;//指针向前移动
        i++;
	}
    while (*str!='\0')//值为'\0'终止，*str = '\0'; 
	{
		putchar(*str);
		str++;//指针向前移动
	}
    printf("str length = %d",i)
	system(p);
	system("pause");
}
void main()
{
    char str[30] = "title China is great";
    system(str);
    char *p = str+6;
    while(*p != '\0')
    {
        putchar(*p);
        p++//指针向前移动
    }
    while(p[0]!='\0')
    {
        putchr(p[0]);
        p++;
    }
}
```

## 字符数组初始化

```
void main()
{
    char str[100] = {"color 4f"};//花括号可以省略，C语言允许使用字符串常量初始化字符数组关于二维数组大致想相同
    system(str);
    system("pause");
}
```

### 数组输入输出

```
void main()
{
	char str[100] = {0}
    char *p = str;//使用指针一 定要初始化，否则会出现好多意想不到的错误，没初始化的指针称为野指针
    //使用指针初始化要让指针指向一段可以读写的内存
    //初始化为NULL时，在32位系统中是一段不可以读写的内存，所以会发生读写冲突  
    scanf("%s",p);//初始化
    printf("%s",p);//输出
    system(p);
    system("pause");
    
}
```

```
void main()
{
    //char str[100] = "tasklist";这是可以的
    //char str[100];
    //str[100] = "tasklist";这是不可以的，str[100]代表第101个元素，越界
    //str = "tasklist";str是数组名，是常量不可以修改
    //char *p = "tasklist";//可以，p存储了字符串常量的首地址
    char *p;
    p = "tasklist";//？？与上面冲突了？？？？！！！！！
    printf("%s",p);//输出
    system("p");
    system(pause);
    
}
```

字符串与字符数组之间的关系

```c
# include<stdio.h>
void main()
{
	//字符数组存储字符串，就具备所有数组的特点
    char str[100] = "tasklist"；
    printf("%s\n",str)；
    for(int i=0;i<8;i++)
    {
        printf("%c  %c\n",str[i],*(str+i));//下标法，和指针法输出
    }
    system(str);
    system("pause");
}
```

```
# include<stdio.h>
//函数的副本机制，只有数组例外，数组拷贝非常耗费时间
void change(char str[])//数组传递过来的实际上就是指针
{
	printf("change = %d\n", sizeof(str));//输出指针的大小四个字节
	*str = 'A';//改变指针指向的内容，也就是改变原来的数组	 
	*(str + 1) = 'B';
}

void main()
{
	//字符数组存储字符串，就具备所有数组的特点
	char str[100] = "tasklist";
		printf("main = %d\n", sizeof(str));
	change(str);
	printf("%s\n", str);
	system("pause");
}
```

```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
void main()
{
	char str[100] = { 0 };
	scanf("%s", str);
	printf("%s", str);
	gets(str);
	puts(str);//与上面的方式等价
	system(str);
	system("pause");
}
```

```c
void main()
{
    char str[10] = "ABC",*p;
    //str = "ABC";常量不可以赋值
	p = "ABC";//可以p存储字符号串的首地址
    //int a[5],*pA;
    //a = {1,2,3,4,5};//不能这样初始化
    //pA = {1,2,3,4,5};//不行，指针不可以使用数组初始化
    int a[5] = {1,2,3,4,5}; *pA;
}
```



```
void main()
{
    char str[100] = "我有1000元";
    int num;
    sscanf(str,"我有%d元",&num)；
    printf("%d",num);
}
```

```
void main()
{
    char str1[100] = "my name is hello";
    char str2[30] = "hello";
    char *p = strstr(str1,str2);
    if(p == NULL)
    {
        printf("没找到");
    }
    else
    {
        printf("找到%p，%c",p,*p)
    }
}
```

8