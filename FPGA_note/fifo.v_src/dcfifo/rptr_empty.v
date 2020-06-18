

module rptr_empty #(	parameter PTR_WITH  = 0 
				  )
(
		input clk_rd,
		input rst_rd,
		input rd_en ,

		output [PTR_WITH-1:0] rd_addr ,
		output [PTR_WITH:0] rd_gray,
		input  [PTR_WITH:0] wr_gray_sync_rd,
		output rd_empty
);
reg [PTR_WITH:0] _rd_bin ;//生成二进制的读地?
reg [PTR_WITH:0] _rd_gray ;//生成格雷码的读地?

wire [PTR_WITH:0] _rd_bin_next ;//生成二进制的读地?
wire [PTR_WITH:0] _rd_gray_next ;//生成格雷码的读地?

wire __rd_empty ;
reg _rd_empty ;

assign rd_addr = _rd_bin[PTR_WITH-1:0];
assign rd_gray = _rd_gray ;
assign rd_empty = _rd_empty;

//若FIFO为首字置出类型，rd_en相当于读数据的确认信?,读地?指向的是当前输出数据?在的地址
//若FIFO为非首字置出类型,读地?指向的是下一个要读取的数?
//****************************************
//生成二进制的读地?,
//****************************************
always @(posedge clk_rd or posedge rst_rd) 
begin
	if (rst_rd) 
		_rd_bin <= {PTR_WITH{1'b0}} ; 
	else 
		_rd_bin <= _rd_bin_next ;
end
//****************************************
//生成格雷码的读地?
//****************************************
always @(posedge clk_rd or posedge rst_rd) 
begin
	if (rst_rd) 
		_rd_gray <= {PTR_WITH{1'b0}} ; 
	else 
		_rd_gray <= _rd_gray_next ;
end
assign _rd_bin_next   = _rd_bin + (~rd_empty & rd_en) ;
assign _rd_gray_next  = (_rd_bin_next>>1) ^ _rd_bin_next ;
//****************************************
//直接使用读写地址的格雷码进行比较?
//完全相同时，则为?
//****************************************
assign  __rd_empty =  (_rd_gray_next == wr_gray_sync_rd);
always @(posedge clk_rd or posedge rst_rd) 
begin
	if (rst_rd) 
		_rd_empty <= 1'b1; 
	else 
		_rd_empty <= __rd_empty ;
end
endmodule 