/**/
//1-paragraph method to describe FSM
//Describe state transition, state output, input condition in 1 always block
module fsm(rst,clk,i1,i2,o1,o2,err);
    input rst,clk;
    input i1,i2;
    output o1,o2,err;
    reg o1,o2,err;
    reg [2:0] NS; //NextState
    parameter [2:0] //one hot with zero idle
    IDLE = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    ERROR = 3'b100;
    
//1 always block to describe state transition, state output, input condition
    always @ (posedge clk or negedge rst)
      begin
         if (!rst)
             begin
                 NS <= IDLE;
                 {o1,o2,err} <= 3'b000;
             end
         else
             begin
                 NS <= 3'bx;
                 {o1,o2,err} <= 3'b000;
             case (NS)
             IDLE: begin
                       if (~i1) begin{o1,o2,err}<=3'b000;NS <= IDLE; end
                       if (i1 && i2) begin{o1,o2,err}<=3'b100;NS <= S1;end
                       if (i1 && ~i2) begin{o1,o2,err}<=3'b111;NS <= ERROR;end
                   end
     
               S1: begin
                       if (~i2) begin{o1,o2,err}<=3'b100;NS <= S1; end
                       if (i2 && i1) begin{o1,o2,err}<=3'b010;NS <= S2; end
                       if (i2 && (~i1)) begin{o1,o2,err}<=3'b111;NS <= ERROR;end
                    end
     
               S2: begin
                       if (i2) begin{o1,o2,err}<=3'b010;NS <= S2; end
                       if (~i2 && i1) begin{o1,o2,err}<=3'b000;NS <= IDLE; end
                       if (~i2 && (~i1))begin{o1,o2,err}<=3'b111;NS <= ERROR;end
                   end
               
                     ERROR: begin
                               if (i1) begin{o1,o2,err}<=3'b111;NS <= ERROR;end
                               if (~i1) begin{o1,o2,err}<=3'b000;NS <= IDLE; end
                             end
               endcase
         end end
endmodule
/*
module fsm(
    clk,
    rst,
    i1,
    i2,
    o1,
    o2,
    err
);

input clk;
input rst;
input i1;
input i2;
output reg o1;
output reg o2;
output reg err;

localparam  IDLE = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              ER = 3'b100;

reg [2:0]state;

always@(posedge clk or negedge rst)
    if(!rst)
        begin
            state <= IDLE;
            {o1,o2,err} <= 3'b000;
        end
    else 
        begin 
            state <= 3'bx;
            {o1,o2,err} <= 3'b000;
            case(state)
                IDLE: begin 
                        if(!i1)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                        if(i1 & i2)begin state <= S1; {o1,o2,err} <= 3'b100; end 
                        if(i1 & !i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  S1: begin 
                        if(!i2)begin state <= S1; {o1,o2,err} <= 3'b100; end                           
                        if(i1 & i2)begin state <= S2; {o1,o2,err} <= 3'b010; end
                        if(!i1 & i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  S2: begin 
                        if(i2)begin state <= S2; {o1,o2,err} <= 3'b010; end
                        if(i1 & !i2)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                        if(!i1 & !i2)begin state <= ER; {o1,o2,err} <= 3'b111; end
                    end
                  ER: begin 
                        if(i1)begin state <= ER; {o1,o2,err} <= 3'b111; end
                        if(!i1)begin state <= IDLE; {o1,o2,err} <= 3'b000; end
                    end
            endcase 
        end

endmodule
*/


/*
//2-paragraph method to describe FSM
//Describe sequential state transition in 1 sequential always block
//State transition conditions in the other combinational always block
//Package state output by task. Then register the output
module fsm ( rst,clk,i1,i2,o1,o2,err);
    input rst,clk;
    input i1,i2;
    output o1,o2,err;
    reg o1,o2,err;
    reg [2:0] NS,CS;
    parameter [2:0] //one hot with zero idle
     IDLE = 3'b000,
     S1 = 3'b001,
     S2 = 3'b010,
     ERROR = 3'b100;

    //sequential state transition
    always @ (posedge clk or negedge rst)
         if (!rst) 
             CS <= IDLE; 
         else 
             CS <=NS; 
 
    //combinational condition judgment
    always @ (CS or i1 or i2)
       begin
           NS = 3'bx;
           ERROR_out;
           case (CS)
           IDLE: begin
                   IDLE_out;
                   if (~i1) NS = IDLE;
                   if (i1 && i2) NS = S1;
                   if (i1 && ~i2) NS = ERROR;
                 end
                 
           S1: begin
                   S1_out;
                   if (~i2) NS = S1;
                   if (i2 && i1) NS = S2;
                   if (i2 && (~i1)) NS = ERROR;
               end
               
           S2: begin
                   S2_out;
                   if (i2) NS = S2;
                   if (~i2 && i1) NS = IDLE;
                   if (~i2 && (~i1)) NS = ERROR;
               end
               
           ERROR: begin
                     ERROR_out;
                     if (i1) NS = ERROR;
                     if (~i1) NS = IDLE;
                  end
            endcase
       end   
       
    //output task
        task IDLE_out;
           {o1,o2,err} = 3'b000;
        endtask
        
        task S1_out;
           {o1,o2,err} = 3'b100;
        endtask
        
        task S2_out;
           {o1,o2,err} = 3'b010;
        endtask
        
        task ERROR_out;
           {o1,o2,err} = 3'b111;
        endtask
        
endmodule
*//*
module fsm(
    clk,
    rst,
    i1,
    i2,
    o1,
    o2,
    err
);

input clk;
input rst;
input i1;
input i2;
output reg  o1;
output reg  o2;
output reg  err;

localparam  IDLE = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              ER = 3'b100;

reg [2:0]next_state;
reg [2:0]current_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;

always@(rst or current_state or i1 or i2)
    begin 
        next_state = 3'bx;
        {o1,o2,err} = 3'b111;
        case(current_state)
            IDLE: begin
                    {o1,o2,err} = 3'b000;
                    if(~i1) next_state = IDLE;
                    if(i1 & i2) next_state = S1;
                    if(i1 & !i2) next_state = ER;
                  end
              S1: begin 
                    {o1,o2,err} = 3'b100;
                    if(!i2) next_state = S1; 
                    if(i1 & i2) next_state = S2; 
                    if(!i1 & i2) next_state = ER; 
                  end
              S2: begin 
                    {o1,o2,err} = 3'b010;
                    if(i2) next_state = S2; 
                    if(i1 & !i2) next_state = IDLE; 
                    if(!i1 & !i2) next_state = ER; 
                  end
              ER: begin 
                    {o1,o2,err} = 3'b111;
                    if(i1) next_state = ER;
                    if(!i1) next_state = IDLE;
                  end
        endcase
    end
        
endmodule 
*/

/*
//3-paragraph method to describe FSM
//Describe sequential state transition in the 1st sequential always block
//State transition conditions in the 2nd combinational always block
//Describe the FSM out in the 3rd sequential always block
module fsm ( nrst,clk,i1,i2,o1,o2,err);
     input nrst,clk;
     input i1,i2;
     output o1,o2,err;
     reg o1,o2,err;
     reg [2:0] NS,CS;
     parameter [2:0] //one hot with zero idle
     IDLE = 3'b000,
     S1 = 3'b001,
     S2 = 3'b010,
     ERROR = 3'b100;
     
    //1st always block, sequential state transition
    always @ (posedge clk or negedge nrst)
         if (!nrst) 
           CS <= IDLE; 
         else 
           CS <=NS; 
           
    //2nd always block, combinational condition judgment
    always @ (nrst or CS or i1 or i2)
         begin
             NS = 3'bx;
             case (CS)
               IDLE: begin
                       if (~i1) NS = IDLE;
                       if (i1 && i2) NS = S1;
                       if (i1 && ~i2) NS = ERROR;
                     end
         
             S1: begin
                     if (~i2) NS = S1;
                     if (i2 && i1) NS = S2;
                     if (i2 && (~i1)) NS = ERROR;
                 end
                 
             S2: begin
                     if (i2) NS = S2;
                     if (~i2 && i1) NS = IDLE;
                     if (~i2 && (~i1)) NS = ERROR;
                 end
                 
             ERROR: begin
                         if (i1) NS = ERROR;
                         if (~i1) NS = IDLE;
                    end
             endcase
     end
     
    //3rd always block, the sequential FSM output
    always @ (posedge clk or negedge nrst)
      begin
         if (!nrst)
            {o1,o2,err} <= 3'b000;
         else
           begin
               {o1,o2,err} <= 3'b000;
             case (NS)
                 IDLE: {o1,o2,err}<=3'b000;
                 S1: {o1,o2,err}<=3'b100;
                 S2: {o1,o2,err}<=3'b010;
                 ERROR: {o1,o2,err}<=3'b111;
             endcase
           end
      end
endmodule
*//*
module fsm(
    clk,
    rst,
    i1,
    i2,
    o1,
    o2,
    err
);

input clk;
input rst;
input i1;
input i2;
output reg  o1;
output reg  o2;
output reg  err;

localparam  IDLE = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              ER = 3'b100;

reg [2:0]next_state;
reg [2:0]current_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;
        
always@(rst or current_state or i1 or i2)
    begin 
        next_state = 3'bx;
        case(current_state)
            IDLE: begin 
                    if(~i1) next_state = IDLE;
                    if(i1 & i2) next_state = S1;
                    if(i1 & !i2) next_state = ER;
                  end
              S1: begin 
                    if(!i2) next_state = S1; 
                    if(i1 & i2) next_state = S2; 
                    if(!i1 & i2) next_state = ER; 
                  end
              S2: begin 
                    if(i2) next_state = S2; 
                    if(i1 & !i2) next_state = IDLE; 
                    if(!i1 & !i2) next_state = ER; 
                  end
              ER: begin 
                    if(i1) next_state = ER;
                    if(!i1) next_state = IDLE;
                  end
        endcase
    end   
    
always@(posedge clk or negedge rst)
    if(!rst)
        {o1,o2,err} <= 3'b000;
    else 
        begin
            {o1,o2,err} <= 3'b111;
            case(next_state)
                IDLE: {o1,o2,err} <= 3'b000;
                  S1: {o1,o2,err} <= 3'b100;
                  S2: {o1,o2,err} <= 3'b010;
                  ER: {o1,o2,err} <= 3'b111;
            endcase 
        end
        
endmodule 
*/




























