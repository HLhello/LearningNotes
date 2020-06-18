//两段式状态机
//-----------------------  
module   simple_fsm(
input   wire     sys_clk      ,   //系统时钟50Mhz
input   wire     sys_rst_n    ,   //全局复位
input   wire     pi_money     ,   //投币方式可以为：不投币（0）、投1元（1）
     
output  reg     po_cola          //po_cola为1时出可乐，po_cola为0时不出可乐   
);

//只有三种状态，使用独热码
parameter IDLE =3'b001;
parameter ONE  =3'b010;
parameter TWO  =3'b100;

reg      [2:0]   state;              

//第一段状态机，描述当前状态state如何根据输入跳转到下一状态
always@(posedge sys_clk ornegedge sys_rst_n)
if(sys_rst_n ==1'b0)
      state<= IDLE;
elsecase(state)
          IDLE  : if(pi_money ==1'b1)//判断输入情况
                   state<= ONE;
                else
                   state<= IDLE;
                               
           ONE   :if(pi_money ==1'b1)
                   state<= TWO;                    
                else
                   state<= ONE;
                               
           TWO    : if(pi_money ==1'b1)
                   state<= IDLE;
                 else 
                   state<= TWO;
                               
           default:   state <= IDLE;
      endcase

//第二段状态机，描述当前状态state和输入pi_money如何影响po_cola输出
always@(posedge sys_clk ornegedge sys_rst_n) 
if(sys_rst_n == 1'b0)   
      po_cola<=1'b0;
else    if((state == TWO)&&(pi_money ==1'b1))     
      po_cola<=1'b1;
else
      po_cola<=1'b0;
          
endmodule
//-----------------------