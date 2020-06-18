module ASYNC_RST_SYNC(
	input  src_rst_n,
	input  dest_clk ,
	input  dest_clk_en,
	output dest_rst_n
	);
reg sync_reg_1 ;
reg sync_reg_2 ;
assign dest_rst_n = sync_reg_2 ;
always@(posedge dest_clk or negedge src_rst_n)
begin
	if (src_rst_n == 1'b0)
		sync_reg_1 <= 1'b0 ;
	else if (dest_clk_en)
		sync_reg_1 <= 1'b1 ;
	else 
		sync_reg_1 <= sync_reg_1 ;
end 

always@(posedge dest_clk or negedge src_rst_n)
begin
	if (src_rst_n == 1'b0)
		sync_reg_2 <= 1'b0 ;
	else if (dest_clk_en)
		sync_reg_2 <= sync_reg_1 ;
	else 
		sync_reg_2 <= sync_reg_2 ;
end 
endmodule