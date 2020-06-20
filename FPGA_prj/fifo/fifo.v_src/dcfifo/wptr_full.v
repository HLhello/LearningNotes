module wptr_full #(	parameter PTR_WITH  = 0 
				  )
(
		input clk_wr,
		input rst_wr,
		input wr_en ,

		output [PTR_WITH-1:0] wr_addr ,
		output [PTR_WITH:0] wr_gray,
		input  [PTR_WITH:0] rd_gray_sync_wr,
		output wr_full
);
reg [PTR_WITH:0] _wr_bin ;//生成二进制的写地?
reg [PTR_WITH:0] _wr_gray ;//生成格雷码的写地?

wire [PTR_WITH:0] _wr_bin_next ;//生成二进制的写地?
wire [PTR_WITH:0] _wr_gray_next ;//生成格雷码的写地?

wire __wr_full ;
reg _wr_full ;

assign wr_addr = _wr_bin[PTR_WITH-1:0];
assign wr_gray = _wr_gray ;
assign wr_full = _wr_full;
//写地?永远指向下一个有效数据存储的地址
//****************************************
//生成二进制的写地?
//****************************************
always @(posedge clk_wr or posedge rst_wr) 
begin
	if (rst_wr) 
		_wr_bin <= {PTR_WITH{1'b0}} ; 
	else 
		_wr_bin <= _wr_bin_next ;
end
//****************************************
//生成格雷码的写地?
//****************************************
always @(posedge clk_wr or posedge rst_wr) 
begin
	if (rst_wr) 
		_wr_gray <= {PTR_WITH{1'b0}} ; 
	else 
		_wr_gray <= _wr_gray_next ;
end
assign _wr_bin_next   = _wr_bin + (~wr_full & wr_en) ;
assign _wr_gray_next  = (_wr_bin_next>>1) ^ _wr_bin_next ;
//****************************************
//直接使用读写地址的格雷码进行比较?
//当写地址格雷码和读地?格雷码的?高位不同时，说明写地?与读地址不在同一个轮询周?
//当写地址格雷码和读地?格雷码的次高位不同时，说明写地址和读地址在不同轮询周期的比较靠近的位?
//当写地址格雷码和读地?格雷码的其他位相同时，说明写地址与读地址在同?个位?
//****************************************
assign __wr_full = ( rd_gray_sync_wr == {~_wr_gray_next[PTR_WITH],~_wr_gray_next[PTR_WITH-1],_wr_gray_next[PTR_WITH-2:0]} ) ;

always @(posedge clk_wr or posedge rst_wr) 
begin
	if (rst_wr) 
		_wr_full <= 1'b0 ; 
	else 
		_wr_full <= __wr_full ;
end

endmodule 