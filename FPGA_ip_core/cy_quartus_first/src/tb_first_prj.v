
`timescale 1 ns/ 1 ps

module tb_first_prj();

reg clk;
reg rst;
                                              
wire clk_HF;
                         
first_prj i1 (
	.clk(clk),
	.rst(rst),
	.clk_HF(clk_HF)
);

initial                                                
	begin                                                                        
		clk = 0;
		rst = 0;
		#100;
		rst = 1;
		#2000;
		$stop;                                                           
	end    
	
always #20 clk = ~clk;                                                      
                                                    
endmodule

