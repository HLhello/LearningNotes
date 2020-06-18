
module sync_ptr #(
					parameter PTR_WITH = 0
)
(
		//input clk_in,
		//input rst_in,
		input [PTR_WITH:0] ptr_in,

		input clk_out,
		input rst_out,
		output [PTR_WITH:0] ptr_out
);

reg [PTR_WITH:0] __ptr_out ;
reg [PTR_WITH:0] _ptr_out ;
assign ptr_out = _ptr_out ;

always @(posedge clk_out or posedge rst_out) 
begin
	if (rst_out) 
		__ptr_out <= {PTR_WITH{1'b0}} ;
	else
		__ptr_out <= ptr_in ;
end

always @(posedge clk_out or posedge rst_out) 
begin
	if (rst_out) 
		_ptr_out <= {PTR_WITH{1'b0}} ;
	else
		_ptr_out <= __ptr_out ;
end
endmodule 