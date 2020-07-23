## AMBA概述（总线接口协议）

AMBA总线阵营的强大超乎多数人的想象。AMBA总线是一个在SoC领域使用的事实上的标准。SoC的总线有很多标准，例如Silicore的Wishbone总线、IBM的CoreConnect总线（包括PLB、OPB、DCR）、Altera的Avalon总线、OCP-IP的OCP总线等等。ARM公司的AMBA总线也是其中一种。AMBA（Advanced Microcontroller Bus Architecture）高级微处理器总线架构

- AMBA总线标准定义了高性能嵌入式微控制器的通信标准	
- AMBA是有效连接IP核的“**数字胶**”，并且是ARM复用策略的重要组件
- AMBA不是芯片与外设之间的接口，而是ARM内核与芯片上其他元件进行通信的接口
- AMBA可以将**RISC处理器（精简指令集处理器）**集成在其他IP芯核和外设中

1. AMBA总线V1.0——1995年发布
   - AMBA总线V1.0于1995年正式发布，用于SoC内部各个模块间的互联，支持多个主设备，支持芯片级别测试。
   - 在AMBA V1.0中定义了两条总线，ASB(Advanced System Bus)和APB(Advanced Peripheral Bus)。V1.0还定义了一个连接存储器的外部接口，这个外部接口可以用做测试。
   -  ASB总线是一个快速总线接口，使用独立的地址数据总线，支持流水传送方式，支持多个主设备与从设备，采用集中译码和仲裁方式。ASB总线的主要作用是连接CPU，DMA引擎，内部存储器和一些快速外部设备。
   - APB总线连接一些慢速设备，APB是ASB的Secondary Bus，ASB与APB的组成结构从今天的技术上看，AMBA V1.0总线十分简陋，设计这样的总线标准甚至可以作为几个研究生的毕业论文。
   - AMBA总线的最大优点是开放的架构，和因此带来的免费。开放的总线标准使AMBA总线迅速普及，而且更易吸收整个半导体界的成果。 
2. AMBA总线V2.0——1999年发布
   - 1999年AMBA总线更新到V2.0，增加了一个新的总线AHB(Advanced High-Performance Bus)。AHB总线取代了ASB在系统中的位置，使ASB进一步下移，增加了Split传送方式进一步提高了存储器读的效率，总线宽度最高可达128位。 
3. AMBA总线V3.0——2001年发布
   - ARM发布了AMBA V3.0总线规范，引入ATB(Advacned Trace Bus)和AXI(Advanced eXtensible Interface)总线。AXI总线的引入，使AMBA总线迈向新的台阶，性能已经可以与IBM的CoreConnect抗衡。
   - AXI是一条现代总线。
     1. AXI总线分离了一个总线周期的地址阶段和数据阶段，更便于实现在现代总线中常用的Pipelining和Split技术。
     2. AXI总线进一步分离了总线通路，将AHB的单通路分解为Read Data，Read Address，Write Data，Write Address和Write Response共5个独立通路，进一步加速了对存储器的读写访问。 
     3. AXI总线接口逻辑设计较为复杂，与AHB总线相比多使用50%的资源。AXI的一次总线周期至少需要传送64字节的数据，而AHB总线是16字节，这也导致AXI总线的传送延时高于AHB总线。
     4. AXI总线的目标不是用于替换AHB总线，在一个SoC中，AXI总线和AHB依然并存，只是AXI总线更接近ARM内核，AHB总线更贴近外部设备。 AMBA总线阵营规范了嵌入式领域的平台总线，日益壮大。
4. AMBA总线V4.0——2010年发布
   - 2010年3月8日，ARM正式推出AMBA V4.0总线，引入了QoS机制，进一步增强了多层结构，将AXI总线细分为AXI4，AXI-Lite和AXI-Stream。 这一切并不是AMBA V4.0最重要的更新。如同Nehalem内核最重要的变化并不是流水线，而是QPI互联结构，在AMBA4总线中最值得注意的是片间互联总线CoreLink CCI(Cache Cohenrent Interconnect)架构。 CoreLink CCI架构使得多个SMP系统之间实现Cache共享一致性成为可能，Cortex A15也借此超越了用于嵌入式领域的PowerPC和其他多核MIPS。在整个处理器总线阵营中只有IBM的CoreConnect和Intel的QPI可以与之抗衡。
   - CoreLink的横空出世，使Cortex A15具备了和Intel的高端处理器Nehalem和Sandy Bridge抗衡的能力。在服务器领域，Cortex A15内核与Nehalem内核间的较量就是CoreLink和QPI之间的角逐。 
   - AMBA总线标准提供的AXI，AHB，ASB，APB和ATB总线，不仅使用在ARM处理器系统中，MIPS和PowerPC处理器也开始使用AMBA总线。TI和Freescale的DSP也在使用AMBA总线。AMBA总线已经无孔不入，在整个嵌入式领域，没有可以向其挑战的对手。 
   - 面对ARM内核，Intel并不畏惧，面对AMBA总线阵营，Intel只剩下无奈。可以预计在相当长的一段时间里，Intel无法推出一条能和AMBA总线抗衡的SoC平台总线。Intel只能暂时向AMBA总线示弱。

AMBA总线构成下面几个总线，这些内容加起来就定义出一套为了**高性能SoC**而设计的**片上通信的标准**  （包括AHB、APB、AXI、ASB）

- **APB** (Advanced Peripheral Bus) **高级外围总线**
  - APB主要用在**低速且低功率的外围**，可针对外围设备作功率消耗及复杂接口的最佳化；APB在AHB和低带宽的外围设备之间提供了通信的桥梁，所以APB是AHB或ASB的二级拓展总线 ；
- **ASB** (Advanced System Bus) **高级系统总线**
  - 用的很少
- **AHB** (Advanced High-performance Bus) **高级高性能总线**
  - AHB主要是针对**高效率、高频宽及快速系统模块**所设计的总线，它可以连接如微处理器、芯片上或芯片外的内存模块和DMA等高效率模块；
- **AXI** (Advanced eXtensible Interface) **高级可拓展接口**
  - AXI：高速度、高带宽，管道化互联，单向通道，**只需要首地址，读写并行**，支持乱序，支持非对齐操作，有效支持初始延迟较高的外设，连线非常多；



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