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
    
    wire [7:0]data_main,data_sub;
    wire [15:0]data_out;
    wire clk_1s;
    
    Fdiv div (CLR,CLK,clk_1s);
	Light light (clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,data_main,data_sub);
	decoder bin_bcd (data_main,data_out[15:8]);
	decoder bin_bcd (data_sub,data_out[7:0]);
	scan_data show (reset,data_out,clk,AN,Seg);
endmodule

module Light(clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,data_main,data_sub);
    input clk_1s,CLR,start,stopa,stopb,pause;   //输入的变量，与书本一致
    output reg[2:0] MainLight,SubLight;         //输出的主次红绿灯状态，高位到低位依次表示红黄绿
	output reg [7:0] data_main,data_sub;
    reg [7:0] clock;

    initial begin
        Data <= 16'b1010101010101010;
        clock <= 8'd70;
        MainLight <= 0;
        SubLight <= 0;
    end

    always@(posedge CLR  or posedge stopa or posedge stopb or posedge pause)begin
        if(CLR)begin    //reset
            {data_main,data_sub} <= 16'b1010101010101010;
            clock <= 8'd70;
            MainLight <= 3'b100;//清零的时候都亮红灯
            SubLight <= 3'b100;
        end else if(stopa)begin //主干道寄了
            {data_main,data_sub} <= 16'hffff;
            clock <= 8'd70;
            MainLight <= 3'b100;
            SubLight <= 3'b001;
        end else if(stopb)begin //次干道寄了
            {data_main,data_sub} <= 16'hffff;
            clock <= 8'd70;
            MainLight <= 3'b001;
            SubLight <= 3'b100;
        end else if(pause)begin
            {data_main,data_sub} <= {data_main,data_sub};
            clock <= clock;
        end else if(start)begin
            if(clock == 70)begin        //主干道绿
                clock <= clock - 1;
                MainLight <= 3'b001;    
                SubLight <= 3'b100;
                data_main <= 8'd35;
                data_sub <= 8'd40;
            end if (clock == 35)begin   //主干道黄灯
                clock <= clock - 1;
                MainLight <= 3'b010;
                SubLight <= 3'b100;
                data_main <= 8'd5;
                data_sub <= data_sub - 1;
            end else if(clock == 30)begin
                clock <= clock - 1;
                MainLight <= 3'b100;
                SubLight <= 3'b001;
                data_main <= 8'd30;
                data_sub <= 8'd25;
            end else if(clock == 5)begin
                clock <= clock - 1;
                MainLight <= 3'b100;
                SubLight <= 3'b010;
                data_main <= data_main -1;
                data_sub <= 8'd5;
            end else if(clock == 1)begin
                clock <= 70;
                data_main <= data_main - 1;
                data_sub <= data_sub - 1;
            end else 
            begin
                clock <= clock - 1;
                data_main <= data_main - 1;
                data_sub <= data_sub - 1;
            end
        end
    end



endmodule