`timescale 1ns / 1ps
//ÊıÂë¹ÜÉ¨Ãè
module scan(
    input clk,rst_,
    input [31:0]data,
    output reg[7:0]AN,
    output reg[7:0]seg
    );
wire CP;
reg [31:0]T;initial T=32'd100000;
Divider dvd(clk,T,CP);
reg [3:0] data_x;
reg [2:0] bit_sel;
initial bit_sel=3'b0;
always @(negedge rst_ or posedge CP)
begin
    if(!rst_)
        bit_sel <=3'd0;
    else
        bit_sel <= bit_sel+1'b1;
end

always @(*)
begin
    case(bit_sel)
        3'b000: AN=8'b01111111;
        3'b001: AN=8'b10111111;
        3'b010: AN=8'b11011111;
        3'b011: AN=8'b11101111;
        3'b100: AN=8'b11110111;
        3'b101: AN=8'b11111011;
        3'b110: AN=8'b11111101;
        3'b111: AN=8'b11111110;
    endcase
end

always @(*)
begin
    case(bit_sel)
        3'b000: data_x = data[31:28];
        3'b001: data_x = data[27:24];
        3'b010: data_x = data[23:20];
        3'b011: data_x = data[19:16];
        3'b100: data_x = data[15:12];
        3'b101: data_x = data[11:8];
        3'b110: data_x = data[7:4];
        3'b111: data_x = data[3:0];
    endcase
end

always @(*)
begin
    case(data_x)
        4'd0:seg=8'b00000011;
	    4'd1:seg=8'b10011111;
		4'd2:seg=8'b00100101;
		4'd3:seg=8'b00001101;
		4'd4:seg=8'b10011001;
		4'd5:seg=8'b01001001;
		4'd6:seg=8'b01000001;
		4'd7:seg=8'b00011111;
		4'd8:seg=8'b00000001;
		4'd9:seg=8'b00001001;
        default:seg=8'b11111111;
    endcase
end
endmodule
