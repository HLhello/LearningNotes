module mem #(		parameter DATA_SIZE  = 0 ,
					parameter ADDR_SIZE = 0 ,
					parameter SHOW_AHAEAD = "ON",
					parameter MEM_TYPE = "BLOCK"
					)
(
		input clk_wr  ,
		input wr_en   ,
		input [ADDR_SIZE-1:0] wr_addr ,
		input [DATA_SIZE-1:0] wr_data ,

		input clk_rd  ,
		input rd_en   ,
		input [ADDR_SIZE-1:0]  rd_addr ,
		output [DATA_SIZE-1:0] rd_data
);
localparam MEM_DEPTH = 1 << ADDR_SIZE ;

generate
	if (MEM_TYPE == "BLOCK")
	begin
			wire [DATA_SIZE-1:0] __rd_data ;
			Block_Ram U_Block_Ram (
			.clka(clk_wr),    // input wire clka
			.ena(1'b1),      // input wire ena
			.wea(wr_en),      // input wire [0 : 0] wea
			.addra(wr_addr),  // input wire [2 : 0] addra
			.dina(wr_data),    // input wire [7 : 0] dina
			.clkb(clk_rd),    // input wire clkb
			.enb(1'b1),      // input wire enb
			.addrb(rd_addr),  // input wire [2 : 0] addrb
			.doutb(__rd_data)  // output wire [7 : 0] doutb
			);

			if (SHOW_AHAEAD == "ON")
				assign rd_data = __rd_data;
			else 
			begin
				reg [DATA_SIZE-1:0] _rd_data ;
				always @(posedge clk_rd)
				begin
					if (rd_en)
						_rd_data <= __rd_data;
				end
				assign rd_data = _rd_data ;
			end
	end
	else 
	begin
			reg [DATA_SIZE-1:0] mema [MEM_DEPTH-1:0] ;

			if (SHOW_AHAEAD == "ON")
			begin
				assign rd_data = mema[rd_addr];
			end 
			else 
			begin
				reg [DATA_SIZE-1:0] _rd_data ;
				assign rd_data = _rd_data;
				always @(posedge clk_rd)
				begin
					if (rd_en)
						_rd_data <= mema[rd_addr];
				end
			end 

			always @(posedge clk_wr)
			begin
				if (wr_en)
					mema[wr_addr] <= wr_data ;
			end
	end
endgenerate
endmodule 