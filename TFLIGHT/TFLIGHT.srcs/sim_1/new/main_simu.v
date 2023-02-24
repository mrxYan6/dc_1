`timescale 1ns / 1ps
`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/TFLIGHT/TFLIGHT.srcs/sources_1/new/LIGHT.v"

module ma_si();
    
    reg [7:0] bin;
    wire [7:0] ans;

    TOP utt(CLK,CLR,start,stopa,stopb,pause,MainLight,SubLight,AN,Seg);
    reg CLK,CLR,start,stopa,stopb,pause;      //输入的变量，与书本一�?
    wire [2:0] MainLight,SubLight;            //输出的主次红绿灯状�?�，高位到低位依次表示红黄绿
    wire [3:0] AN;                            //数码管位�?
    wire [7:0] Seg;                           //数码管段�?
    
    always@(*)begin
        #10 CLK <= ~CLK;
    end

    initial begin
        $display("start");                  
        $dumpfile("ma_si.vcd");              
        $dumpvars(0, ma_si);
        CLK=0;
        CLR=1;
        start=1;
        stopa=0;
        stopb=0;
        pause=0;
        #60000
        $finish;                      // 6000个单位时间后结束模拟
    end

    
endmodule
