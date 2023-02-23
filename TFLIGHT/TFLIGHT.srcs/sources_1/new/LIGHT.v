`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/23 18:28:29
// Design Name: 
// Module Name: LIGHT
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


module TOP(CLK,CLR,start,stopa,stopb,pause,MainLight,SubLight,AN,Seg);
    input CLK,CLR,start,stopa,stopb,pause;  //输入的变量，与书本一致
    output [2:0] MainLight,SubLight;         //输出的主次红绿灯状态，高位到低位依次表示红黄绿
    output [3:0] AN;
    output [7:0] Seg;
    
    wire [15:0] Data, Data_out;
    wire clk_1s;
    
    Fdiv div (CLR,CLK,clk_1s);
	Light light (clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,Data);
	decoder bin_bcd (Data,Data_out);
	scan_data show (reset,Data_out,clk,AN,Seg);
endmodule

module Light(clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,Data);
    
endmodule