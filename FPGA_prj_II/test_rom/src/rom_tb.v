`timescale 1ns/1ns

module rom_tb();
    reg [11:0]cnt;
    reg clk; 
    wire [11:0]rom_q;
    
   rom rom (
        .address(cnt),
        .clock(clk),
        .q(rom_q)
    );
    
    initial clk = 1;
    always #10 clk = ~clk;
    
	initial begin 
		cnt = 0;
		#200;
		forever begin 
			cnt = cnt + 1'b1;
			#20;
		end
	end
endmodule 
