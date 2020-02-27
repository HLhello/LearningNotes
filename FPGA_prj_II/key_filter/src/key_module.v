module key_module(
	press,
	key
);

input press;
output reg key;

reg [15:0] shake_time;

initial key = 1'b1;

always@(posedge press) press_key;

task press_key;
	begin
		repeat(50)begin
			shake_time = {$random}%65536;
			#shake_time
			key = ~key;
		end
		key = 1'd0;
		#50_000_000;
		
		repeat(50)begin
			shake_time = {$random}%65536;
			#shake_time
			key = ~key;
		end
		key = 1'd0;	
		#50_000_000;
		
	end
endtask

endmodule
