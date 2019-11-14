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
reg wea_r;
wire [3:0]addr;
reg [3:0]raddr;
reg [3:0]waddr;
reg r_en;
assign addr = wea? waddr : raddr;

always@(posedge clk)
    wea_r <= wea;
    
always@(posedge clk or negedge rst)
    if(!rst)
        waddr <= 4'b0;
    else if(~wea && waddr==4'd15)
        waddr <= 4'b0;
    else if(wea)
        waddr <= waddr + 1'b1;
        
always@(posedge clk or negedge rst)
    if(!rst)
        r_en <= 1'd0;
    else if(wea)
        r_en <= 1'b0; 
    else if(!wea && wea_r)
        r_en <= 1'b1;

always@(posedge clk or negedge rst)
    if(!rst)
        raddr <= 4'b0;
    else if(r_en)
        raddr <= raddr + 1'b1;

Single_port_ram u0 (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [3 : 0] addra
  .dina(din),    // input wire [15 : 0] dina
  .douta(dout)  // output wire [15 : 0] douta
);

endmodule
