`include "header.v"

module dds(
	clk,
	rst,
	m_wr,
	m_addr,
	m_wrdata,
	dds_data,
	dds_flag
);

input clk;
input rst;
input m_wr;
input [7:0]m_addr;
input [15:0]m_wrdata;
output [11:0]dds_data;
output reg dds_flag;

reg dds_en;
reg [15:0]reg_fword_h;
reg [15:0]reg_fword_l;
reg [11:0]reg_pword;
wire [9:0]da_data;
dds_module dds_module(
	.clk(clk),
	.rst(rst),
	.en(dds_en),
	.fword({reg_fword_h,reg_fword_l}),
	.pword(reg_pword),
	.da_clk(),
	.da_data(da_data)
);

assign dds_data = {da_data, 2'd0};

always@(posedge clk or negedge rst)
	if(!rst)
		dds_en <= 1'd0;
	else if(m_wr && (m_addr == `DDS_EN))
		dds_en <= m_wrdata[0];
	else 
		dds_en <= dds_en;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			reg_fword_h <= 16'd859;
			reg_fword_l <= 16'd0;
		end
	else if(m_wr && (m_addr == `DDS_FWORD_L))
			reg_fword_l <= m_wrdata;
	else if(m_wr && (m_addr == `DDS_FWORD_H))
			reg_fword_h <= m_wrdata;
	else 
		begin
			reg_fword_h <= reg_fword_h;
			reg_fword_l <= reg_fword_l;
		end
		
always@(posedge clk or negedge rst)
	if(!rst)
		reg_pword <= 12'd0;
	else if(m_wr && m_addr == `DDS_PWORD)
		reg_pword <= m_wrdata[11:0];
	else 
		reg_pword <= reg_pword;

reg [31:0]dds_sample_cnt;
reg [15:0]dds_sample_cnt_max_h;
reg [15:0]dds_sample_cnt_max_l;
reg dds_sample_en;
		
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			dds_sample_cnt_max_h <= 16'd0;
			dds_sample_cnt_max_l <= 16'd49999;
		end
	else if(m_wr && (m_addr == `DDS_S_CNT_MAX_L))
		dds_sample_cnt_max_l <= m_wrdata;
	else if(m_wr && (m_addr == `DDS_S_CNT_MAX_H))
		dds_sample_cnt_max_h <= m_wrdata;
	else 
		begin
			dds_sample_cnt_max_h <= dds_sample_cnt_max_h;
		   dds_sample_cnt_max_l <= dds_sample_cnt_max_l;
		end
	
always@(posedge clk or negedge rst)
	if(!rst)
		dds_sample_en <= 1'd0;
	else if(m_wr && (m_addr == `DDS_SAMPLE_EN))
		dds_sample_en <= m_wrdata[0];
	else 
		dds_sample_en <= dds_sample_en;
		
always@(posedge clk or negedge rst)
	if(!rst)
		dds_sample_cnt <= 32'd0;
	else if(dds_sample_en)
		begin
			if(dds_sample_cnt == {dds_sample_cnt_max_h,dds_sample_cnt_max_l})
				dds_sample_cnt <= 32'd0;
			else 
				dds_sample_cnt <= dds_sample_cnt + 1'd1;
		end
	else 
		dds_sample_cnt <= 32'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		dds_flag <= 1'd0;
	else if(dds_sample_cnt == {{dds_sample_cnt_max_h,dds_sample_cnt_max_l}})
		dds_flag <= 1'd1;
	else 
		dds_flag <= 1'd0;

endmodule 

