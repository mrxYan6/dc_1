`timescale 1ns / 1ps
`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/digitcircuit/teamwork/project_1/project_1.srcs/sources_1/new/Clock.v"
module ma_simu();
    
    reg [7:0] bin;
    wire [7:0] ans;

    // decoder utt(bin,ans);
    Clock utt(CLK,reset,EN,TYPEe,NEXT_CP_ini,SET,MODIFY,IN,AN,SEG,alert,TMP);
    reg CLK,reset,EN,TYPEe,NEXT_CP_ini,SET,MODIFY;
    wire [7:0]IN;      //输入的数字（�?关）
    wire  TMP;
    wire  [7:0]AN;     //输出的数码管使能端信�?
    wire [7:0]SEG;    //输出的数码管信号
    wire  [7:0]alert;  //灯，表示闹钟到了


    initial begin
        $display("start");          
        $dumpfile("main_wave.vcd");         
        $dumpvars(0, ma_simu);
        bin = 0;
        CLK = 0;
        reset = 1;
        EN = 1;
        TYPEe = 0;
        NEXT_CP_ini = 0;
        SET = 0;
        MODIFY = 0;
        #6000 $finish;                   
    end

    always @(*)begin
        #5 CLK <= !CLK;
    end
endmodule
