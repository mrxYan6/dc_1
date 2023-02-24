`timescale 1ns / 1ps
// `include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/TFLIGHT/TFLIGHT.srcs/sources_1/new/Fdiv.v"
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/TFLIGHT/TFLIGHT.srcs/sources_1/new/Tube.v"
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/TFLIGHT/TFLIGHT.srcs/sources_1/new/Translator.v"
module TOP(CLK,CLR,start,stopa,stopb,pause,MainLight,SubLight,AN,Seg);
    input CLK,CLR,start,stopa,stopb,pause;      //输入的变量，与书本一�??
    output [2:0] MainLight,SubLight;            //输出的主次红绿灯状�?�，高位到低位依次表示红黄绿
    output [7:0] AN;                            //数码管位�??
    output [7:0] Seg;                           //数码管段�??
    wire [15:0] Data;

    // button b1(CLK,CLR,clr);

    //wire [7:0]data_main,data_sub;
    wire [15:0]data_out;
    wire clk_1s;
    
    Fdiv div (CLR,32'd12500000,CLK,clk_1s);
	Light light (clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,Data);
    decoder bin_bcd1(Data[15:8],data_out[15:8]);
    decoder bin_bcd2(Data[7:0],data_out[7:0]);
	scan_data show (1'b1,data_out,CLK,AN,Seg);
endmodule

module Light(clk_1s,CLR,start,stopa,stopb,pause,MainLight,SubLight,Data);
    input clk_1s,CLR,start,stopa,stopb,pause;   //输入的变量，与书本一�??
    output reg[2:0] MainLight,SubLight;         //输出的主次红绿灯状�?�，高位到低位依次表示红黄绿
	//output reg [7:0] data_main,data_sub;        
    reg [6:0] clock;
	output reg [15:0] Data;
    initial begin
        Data<=16'b1010101010101010;
        clock <= 8'd70;
        MainLight <= 0;
        SubLight <= 0;
    end

    reg [1:0]status;

    always@(posedge clk_1s or posedge CLR  or posedge stopa or posedge stopb or posedge pause)begin
        if(!CLR)begin                                //reset
            clock <= 8'd70;
            status <= 0;
        end else if(stopa)begin                     //主干道寄
            clock <= 8'd70;
            status <= 1;
        end else if(stopb)begin                     //次干道寄
            clock <= 8'd70;
            status <= 2;
        end else if(pause)begin                     //pause
            clock <= clock;
            status <= 3;
        end else if(start)begin
            status <= 3;
            if(clock == 1)begin
                clock <= 70;
            end else begin
                clock <= clock - 1;
            end
        end
    end

    always @(*) begin
        case (status)
            0:
            begin
                MainLight = 3'b100;
                SubLight = 3'b100;
                Data = 16'b1010101010101010;
            end
            1:
            begin
                MainLight = 3'b100;
                SubLight = 3'b001;
                Data = 16'hffff; 
            end
            2:
            begin
                MainLight = 3'b001;
                SubLight = 3'b100;
                Data = 16'hffff;
            end
            3:
            begin
                if(clock >= 30)begin
                    SubLight = 3'b100;
                    Data[7:0] = clock - 7'd30;
                    if(clock >= 35)begin
                        Data[15:8] = clock - 7'd35;
                        MainLight = 3'b001;
                    end else begin
                        Data[15:8] = clock - 7'd30;
                        MainLight = 3'b010;
                    end
                end else begin
                    MainLight = 3'b100;
                    Data[15:8] = clock;
                    if (clock >= 5)begin
                        SubLight = 3'b001;
                        Data[7:0] = clock - 5;
                    end else begin
                        SubLight = 3'b010;
                        Data[7:0] = clock;
                    end    
                end
            end
        endcase
    end 
endmodule