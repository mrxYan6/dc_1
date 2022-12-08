`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/01 10:46:38
// Design Name: 
// Module Name: ajxd
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


module Fdiv(input reset,input[31:0] mult,input clk_1M,output reg clk_1K);
    reg [31:0]counter;
    initial begin counter = 32'd0;end
    initial begin clk_1K = 0;end
    always @(posedge clk_1M or posedge reset) begin
        if(!reset)
            begin
                counter <= 32'd0;
                clk_1K <= 1'b0;
            end
        else if(counter == mult)
            begin
                clk_1K <= ~clk_1K;
                counter <= 32'd0;
            end
        else begin
            counter <= counter + 1'b1;
        end
    end
endmodule
 
module ajxd();
endmodule

module scan_data(reset,data,clk,AN,seg);
    output [7:0]AN;
    output [7:0]seg;
    input reset;
    input clk;
    input [31:0]data;
    wire clk_5ms;
    reg [2:0]select;
    Fdiv utt(reset,32'd50000,clk,clk_5ms);

    always @(posedge clk_5ms or posedge reset) begin
        if(!reset)begin
            select <= 3'd0;
        end
        else begin
            select <= select + 3'd1;
        end
    end

    reg [3:0]data_in;
    show(data_in,select,AN,seg);
    always @(*) begin
        case (select)
            7: data_in = data[31:28];
            6: data_in = data[27:24];
            5: data_in = data[23:20];
            4: data_in = data[19:16];
            3: data_in = data[15:12];
            2: data_in = data[11:8];
            1: data_in = data[7:4];
            0: data_in = data[3:0];
        endcase
    end
endmodule


module show(data,seletct,AN,seg);
    input [3:0]data;
    input [2:0]seletct;
    output reg [7:0]AN;
    output reg [7:0]seg;

    always @(*) begin
        case(seletct) 
            0:AN = 8'b11111110;
            1:AN = 8'b11111101;
            2:AN = 8'b11111011;
            3:AN = 8'b11110111;
            4:AN = 8'b11101111;
            5:AN = 8'b11011111;
            6:AN = 8'b10111111;
            7:AN = 8'b01111111;

            default: AN = 8'Hff;
        endcase
    end

    always @(*) begin
        case  (data)
            0:seg = 8'b00000011;
			1:seg = 8'b10011111;
			2:seg = 8'b00100101;
			3:seg = 8'b00001101;
			4:seg = 8'b10011001;
			5:seg = 8'b01001001;
			6:seg = 8'b01000001;
			7:seg = 8'b00011111;
			8:seg = 8'b00000001;
			9:seg = 8'b00001001;
            10:seg = 8'b11111101;
            // 11:seg = 8'b11000001;
            // 12:seg = 8'b01100011; 
            // 13:seg = 8'b10000101;
            // 14:seg = 8'b01100001;
            // 15:seg = 8'b01110001;

            default:seg = 8'Hff;
        endcase
    end
endmodule

module digitClock(clk,reset,SW,SET,AN,seg);
    input clk;
    input reset;
    input [1:0]SW;
    input SET;
    output [7:0]AN;
    output [7:0]seg;
    reg [31:0]date;
    reg[31:0]tim;
    reg[31:0]week;

    wire [31:0]out;
    scan_data utt(reset,out,clk,AN,seg);

    always @(*) begin

    end

    always @(*) begin
        case (SW)
            0:date = tim;
            1:date = date;
            2:date = week;
        endcase
    end

endmodule


module main(//译码器
    input [3:0] cba,
    input [2:0] _en,//使能端
    output reg [9:0] Y
);
always @(*) begin
    if(!_en[2]||_en[1]||_en[0])//输入无效部分
        Y=10'b1111_1111_11;
    else
        case(cba)
            4'b0000:Y=8'b0000_0011;
            4'b0001:Y=10'b1111_1111_01;
            4'b0010:Y=10'b1111_1110_11;
            4'b0011:Y=10'b1111_1101_11;
            4'b0100:Y=10'b1111_1011_11;
            4'b0101:Y=10'b1111_0111_11;
            4'b0110:Y=10'b1110_1111_11;
            4'b0111:Y=10'b1101_1111_11;
            4'b1000:Y=10'b1011_1111_11;
            4'b1001:Y=10'b0111_1111_11;
            
        endcase
end    
endmodule

module LS191(LD_,CT_,U_D,CP,D,Q,MM,RCO_);//计数器
    input LD_,CT_,U_D,CP;
    input [3:0] D;
    output reg MM=0;
    output RCO_;
    output reg [3:0] Q;
    
    assign RCO_=CP+CT_+~MM;
    always @(posedge CP or negedge LD_)
    begin
        if(!LD_)
            Q<=D;
        else if(CT_)
            Q<=Q;
        else
            if(U_D==0)begin
                if(Q<=14)begin
                Q<=Q+1'b1;MM=0;end
                else if(Q==15)begin
                Q<=0;MM=1;end
                end
            else begin
                if(Q>=1)begin
                Q<=Q-1'b1;MM=0;end
                else if(Q==0)begin
                Q<=15;MM=1;end
            end
    end
endmodule



