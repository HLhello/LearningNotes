module mod3(
    clk,
    rst,
    din,
    dout
);

input clk;
input rst;
input din;
output reg dout;

localparam  last_rem0 = 3'b001,
            last_rem1 = 3'b010,
            last_rem2 = 3'b100;


reg [2:0] current_state;
reg [2:0] next_state;

always@(posedge clk or negedge rst)
    if(!rst)
        current_state <= 3'd0;
    else
        current_state <= next_state;
        
always@(*) begin
    next_state = last_rem0;
    case(current_state)
        last_rem0: begin
            if(din)
                next_state = last_rem1;
            else 
                next_state = last_rem0;
        end
        last_rem1: begin
            if(din)
                next_state = last_rem0;
            else 
                next_state = last_rem2;        
        end
        last_rem2: begin
            if(din)
                next_state = last_rem2;
            else 
                next_state = last_rem1;
        end
        
        default next_state = last_rem0;
    endcase 
end

always@(posedge clk or negedge rst)
    if(!rst)
        dout <= 1'b0;
    else begin
        case(next_state)
            last_rem0: begin
                if(din)
                    dout <= 1'b0;
                else 
                    dout <= 1'b1;
            end
            last_rem1: begin
                if(din)
                    dout <= 1'b1;
                else 
                    dout <= 1'b0;
            end
            last_rem2: begin
                if(din)
                    dout <= 1'b0;
                else 
                    dout <= 1'b0;
            end            
            
            default dout <= 1'b0;
        endcase 
    end

endmodule 
