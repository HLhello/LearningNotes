module uart_tx(
	clk,
	rst,
	bps_start,
	bps_hf,
	rx_intr,	
	rx_data,
	uart_tx,
);

input clk;
input rst;

output bps_start;
input bps_hf;
input rx_intr;
//8bits转换成1bit
input [7:0] rx_data;
output uart_tx;

reg rx_intr0,rx_intr1,rx_intr2;
wire neg_rx_intr;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			rx_intr0 <= 1'b0;
			rx_intr1 <= 1'b0;
			rx_intr2 <= 1'b0;
		end
	else 
		begin
			rx_intr0 <= rx_intr;
			rx_intr1 <= rx_intr0;
			rx_intr2 <= rx_intr1;
		end
assign neg_rx_intr = ~rx_intr1 & rx_intr2;

reg [7:0] tx_data;
reg bps_start_r;
reg tx_en;
reg [3:0] num;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			bps_start_r <= 1'bz;
			tx_data <= 8'd0;
			tx_en <= 1'b0;
		end
	else if(neg_rx_intr)
		begin
			bps_start_r <= 1'b1;
			tx_data <= rx_data;
			tx_en <= 1'b1;
		end
	else if(num == 4'd10)
		begin
			bps_start_r <= 1'b0;
			tx_en <= 1'b0;
		end
assign bps_start = bps_start_r;

reg uart_tx_r;
always@(posedge clk or negedge rst)
	if(!rst)
		begin 
			num <= 4'd0;
			uart_tx_r <= 1'b1;
		end
	else if(tx_en)
		begin
			if(bps_hf)
				begin
					num <= num +1'b1;
					case(num)
						4'd0: uart_tx_r <= 1'b0;
						4'd1: uart_tx_r <= tx_data[0];
						4'd2: uart_tx_r <= tx_data[1];
						4'd3: uart_tx_r <= tx_data[2];
						4'd4: uart_tx_r <= tx_data[3];
						4'd5: uart_tx_r <= tx_data[4];
						4'd6: uart_tx_r <= tx_data[5];
						4'd7: uart_tx_r <= tx_data[6];
						4'd8: uart_tx_r <= tx_data[7];
						4'd9: uart_tx_r <= 1'b1;
						default: ;
					endcase
				end
			else if(num ==4'd10)
				num <= 4'd0;
		end
		
assign uart_tx = uart_tx_r;

endmodule 