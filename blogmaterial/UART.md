历史背景

​	UART —— 全称 Universal Asynchronous Receiver/Transmitter，译为通用异步收发器。

​	串口的出现是在1980年前后，数据传输率是115kbps～230kbps。串口出现的初期是为了实现连接计算机外设的目的，初期串口一般用来连接鼠标和外置Modem以及老式摄像头和写字板等设备。串口也可以应用于两台计算机（或设备）之间的互联及数据传输。由于串口（COM）不支持热插拔及传输速率较低，目前部分新主板和大部分便携电脑已开始取消该接口。目前串口多用于工控和测量设备以及部分通信设备中。在几乎所有的MCU中都会有UART接口。--from 百度百科

基本概念

​	通用异步收发传输器，通常称作UART，是一种异步收发传输器。是异步通信协议。特性：两根线，全双工，异步通信，速度较慢。也就是一根发送数据，一根接收数据，并且电平逻辑是时间的函数。发送和接收一个bit都有固定的宽度，也就是只有等于这个时间宽度时才认为是1bit。为了约定时间宽度，就诞生了比特率的概念：表示1s信号可以传输N bit的数据，单位bps=bit per second。比如，9600bps = 1s发送或接收9600 bit数据，那么1bit数据时间宽度也就是1/9600 s。 



​    常见比特率——9600bps 19200bps 38400bps 57600bps 115200bps



什么是RS232

RS232是物理层的电气接口要求。是一种接口标准。uart可以使用rs232物理层来通信。总的来说，对于一项通信任务，通信协议可以使用UART协议，而UART协议可以通过COM端口来实现硬件连线，此协议下的传输方式可以选用RS232或者RS485等。



在通信和计算机科学中，Serial communication是一个通用概念，泛指所有的串行的通信协议，如RS232、USB、I2C、SPI、1-Wire、Ethernet等。这里的串行（serial），是相对并行通信（parallel communication）来说的，如下图：
