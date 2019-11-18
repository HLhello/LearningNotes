`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/14 15:30:37
// Design Name: 
// Module Name: test_vbram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_vbram(
    clk,
    rst,
    wea,
    din,
    dout
    );
input clk;
input rst;
input wea;
input [15:0]din;
output [15:0]dout;
reg [3:0]addr;

always@(posedge clk or negedge rst)
    if(!rst)
        addr <= 4'd0;
    else if(wea)
        addr <= addr + 1'b1;

Single_port_ram u0 (
  .clka(clk),       // input wire clka
  .wea(wea),       // input wire [0 : 0] wea
  .addra(addr),   // input wire [3 : 0] addra
  .dina(din),    // input wire [15 : 0] dina
  .douta(dout)  // output wire [15 : 0] douta
);

endmodule
