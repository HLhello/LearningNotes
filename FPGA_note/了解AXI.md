## AXI

- AXI（Advanced eXtensible Interface）是一种总线协议，该协议是ARM公司提出的AMBA（Advanced Microcontroller Bus Architecture）3.0协议中最重要的部分，
- AXI 是一种面向高性能、高带宽、低延迟的片内总线。它的地址/控制和数据相位是分离的，支持不对齐的数据传输，同时在突发传输中，只需要首地址，同时分离的读写数据通道、并支持Outstanding传输访问和乱序访问，并更加容易进行时序收敛。
- AXI 是AMBA 中一个新的高性能协议。AXI 技术丰富了现有的AMBA 标准内容，满足超高性能和复杂的片上（SoC）设计的需求。

## AMBA概述

SoC的总线有很多标准，例如Silicore的Wishbone总线、IBM的CoreConnect总线（包括PLB、OPB、DCR）、Altera的Avalon总线、OCP-IP的OCP总线等等。ARM公司的AMBA总线也是其中一种

- AMBA（Advanced Microcontroller Bus Architecture）高级微处理器总线架构，AMBA总线标准定义了高性能嵌入式微控制器的通信标准	
- AMBA是有效连接IP核的“**数字胶**”，并且是ARM复用策略的重要组件
- AMBA不是芯片与外设之间的接口，而是ARM内核与芯片上其他元件进行通信的接口。
- AMBA可以将**RISC处理器（精简指令集处理器）**集成在其他IP芯核和外设中

AMBA总线构成下面几个总线，这些内容加起来就定义出一套为了**高性能SoC**而设计的**片上通信的标准**  （包括AHB、APB、AXI、ASB）

- **AHB** (Advanced High-performance Bus) **高级高性能总线**
  - AHB主要是针对**高效率、高频宽及快速系统模块**所设计的总线，它可以连接如微处理器、芯片上或芯片外的内存模块和DMA等高效率模块；
- **APB** (Advanced Peripheral Bus) **高级外围总线**
  - APB主要用在**低速且低功率的外围**，可针对外围设备作功率消耗及复杂接口的最佳化；APB在AHB和低带宽的外围设备之间提供了通信的桥梁，所以APB是AHB或ASB的二级拓展总线 ；
- **AXI** (Advanced eXtensible Interface) **高级可拓展接口**
  - AXI：高速度、高带宽，管道化互联，单向通道，**只需要首地址，读写并行**，支持乱序，支持非对齐操作，有效支持初始延迟较高的外设，连线非常多；
- **ASB** (Advanced System Bus) **高级系统总线**
  - 用的很少



### AHB与AXI、APB的区别与联系

![AMBA总线性能对比](了解AXI.assets/AMBA总线性能对比.png)

- AHB是先进的高性能总线，AXI是先进的可扩展接口，APB是高级外围总线；
- AHB和APB都是单通道总线，不支持读写并行；而AXI是多通道总线，总共分为五个通道，能够实现读写并行；
- AHB和AXI都是多主/从设备，且通过仲裁机制实现总线控制权的分配；而APB是单主设备多从设备，其主设备就是APB桥，不具有仲裁机制；
- 在数据操作方面，AHB和AXI支持突发传输，APB不支持；此外，AXI支持数据的非对齐操作，AHB不支持；

## qsys？nios II？sopc？

qsys是一个工具，这个工具是用来帮助搭建系统的

nios II是一款cpu，是一个处理器

sopc是一种技术，可编程偏上系统，是一种解决方案

## sopc

sopc：使用FPGA通用逻辑搭建CPU和外围设备电路

Altera：nios II软核CPU，能跑到接近100兆32个通用寄存器，类似于arm7，性能也较为接近

xlinix：microblaze 软核cpu

arm cortex-A9 cortex-A53能够跑到900多兆，powerPC硬核，mc8051提供相应软核

片上嵌入双核arm A9，处理器和FPGA融合，异构计算

2013之前altera sopc 基于nios II 软核处理器

软核处理器-->没有硬核处理器的电路，使用FPGA通用逻辑阵列搭建起来的

硬核处理器-->电脑处理器，之类的

软核CPU的应用场景：网络传输，lcd显示界面，频谱分析仪，必须以FPGA为主，又需要一些显示

如果使用stm32以及FPGA比较难做，功耗难以降下来

soc片上系统

赛灵思叫zynq

使用qsys搭建一个nios II系统

stm32有两种数据总线，APB-->外设总线，AHB-->数据总线



## avalon总线

有两种

qsys遵循avalon总线规范

- 第一种是avalon mm（memory map）
- 第二种是avalon st（数据 ） 总线