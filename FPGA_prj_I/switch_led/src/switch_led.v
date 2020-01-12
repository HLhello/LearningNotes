module switch_led(
	clk,
	rst,
	switch,
	led
);

input clk;
input rst;
input [3:0]switch;

output reg [7:0]led;

always@(posedge clk or negedge rst)
	if(!rst)
		led <= 8'b1111_1111;
	else if(switch[0])
		led <= 8'b1111_1111;
	else begin
		case(switch[3:1])
			3'b000 : led<=8'b1111_1110;
			3'b001 : led<=8'b1111_1100;
			3'b010 : led<=8'b1111_1000;
			3'b011 : led<=8'b1111_0000;
			3'b100 : led<=8'b1110_0000;
			3'b101 : led<=8'b1100_0000;
			3'b110 : led<=8'b1000_0000;
			3'b111 : led<=8'b0000_0000;
			default : ;
		endcase
	end

endmodule

