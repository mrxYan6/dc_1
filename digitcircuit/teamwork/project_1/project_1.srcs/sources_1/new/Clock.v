`timescale 1ns / 1ps
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/digitcircuit/teamwork/project_1/project_1.srcs/sources_1/new/Translator.v"
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/digitcircuit/teamwork/project_1/project_1.srcs/sources_1/new/Counter.v"
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/digitcircuit/teamwork/project_1/project_1.srcs/sources_1/new/Tube.v"
module Clock(CLK,reset,EN,TYPEe,NEXT_CP_ini,SET,MODIFY,IN,AN,SEG,alert,TMP);
    input CLK;          //输入的时钟信�??
    input reset;        //清零（按钮）
    input EN;           //是否�??�??
    input TYPEe;         //显示及设置模式（�??关）
    input NEXT_CP_ini;  //设置时下�??个（按钮�??
    input SET;          //是否为输入模式（�??关）
    input MODIFY;       //输入模式时确定输�??
    input [7:0]IN;      //输入的数字（�??关）
    output TMP;
    output [7:0]AN;     //输出的数码管使能端信�??
    output [7:0]SEG;    //输出的数码管信号
    output [7:0]alert;  //灯，表示闹钟到了

    //mode0：时�?? w-hhmmss
    //mode1：闹�?? -hh--mm-
    reg [7:0]hour,minute,second,weekday,hour_alarm,minute_alarm;

    reg [1:0]MODE0;     //00->ss,01->mm,10->hh,11->w
    reg MODE1;          //0->mm,1->hh
    
    wire [7:0]hour_now,minute_now,second_now,weekday_now,hour_alarm_now,minute_alarm_now;
    // wire [7:0]hour_toset,minute_toset,second_toset,weekday_toset,hour_alarm_toset,minute_alarm_toset;
    

    wire CP_1S,CP_500MS,CP_100MS;
    wire CO1,CO2,CO3,CO4;
    wire rst,NEXT_CP,SURE,TYPE;
    reg [3:0]LD;
    reg  [1:0]LD2;
    
    assign TMP=rst;
    assign NEXT_CP = NEXT_CP_ini;
    assign SURE = MODIFY;
    assign TYPE = TYPEe;
    assign rst = reset;

    Fdiv div1s(rst,32'd50000000,CLK,CP_1S);
    Fdiv div500ms(rst,32'd25000000,CLK,CP_500MS);
    Fdiv div100ms(rst,32'd12500000,CLK,CP_100MS);

    
    // button but1(CP_100MS,reset,rst);
    // button but2(CP_100MS,NEXT_ini,NEXT_CP);
    // button but3(CP_100MS,MODIFY,SURE);
    // button but4(CP_100MS,TYPEe,TYPE);

    Counter sec(rst,LD[0],EN,CP_1S,8'd60,8'd0,second_now,CO1);
    Counter minu(rst,LD[1],EN,CO1,8'd60,IN,minute_now,CO2);
    Counter hou(rst,LD[2],EN,CO2,8'd24,IN,hour_now,CO3);
    Counter week(rst,LD[3],EN,CO3,8'd7,IN,weekday_now, );

    //不进�??
    Counter h_a(rst,LD2[1],EN, ,8'd24,IN,hour_alarm_now, );
    Counter m_a(rst,LD2[0],EN, ,8'd60,IN,minute_alarm_now, );


    // Counter sec1(LD,EN,CP_1S,8'd60,second_now,8'b0,CO1);
    // Counter minu1(LD,EN,CO1,8'd60,minute_now,minute_toset,CO2);
    // Counter hou1(LD,EN,CO2,8'd24,hour_now,hour_toset,CO3);
    // Counter week1(LD,EN,CO3,8'd7,weekday_now,weekday_toset,CO);

    wire [7:0] h,m,s,ha,ma,w;
    
    decoder u1(hour_now,h);
    decoder u2(minute_now,m);
    decoder u3(second_now,s);
    decoder u4(hour_alarm_now,ha);
    decoder u5(minute_alarm_now,ma);
    decoder u6(weekday_now,w);

    wire [31:0]out;
    assign out = TYPE?{w[3:0],4'hf,h,m,s}:{4'hf,ha,4'hf,4'hf,ma,4'hf};

    wire [7:0] ori;

    always @(posedge SET or posedge NEXT_CP)begin
        if(!SET)begin
            MODE0 <= 0;
            MODE1 <= 0;
        end else if(MODIFY) begin
            if(!TYPE)begin 
                MODE0 <= MODE0;
                MODE1 <= MODE1 + 1;
            end
            else begin 
                MODE0 <= MODE0 + 1;
                MODE1 <= MODE1;
            end
        end else begin
            MODE0 <= MODE0;
            MODE1 <= MODE1;
        end
    end
    
    //产生置数信号
    always @(*)begin
        if(SET)begin
            if(!TYPE)begin
                LD2[MODE1] = !MODIFY;
            end else begin
                LD[MODE0] = !MODIFY;
            end
        end else begin
            LD = 4'd0;
            LD2 = 2'd0;
        end
    end

    //辅助产生位�?�信�??
    assign ori =   TYPE ?
                (MODE0 == 0) ?   8'b00000011
                :(MODE0 == 1) ?  8'b00001100
                :(MODE0 == 2) ?  8'b00110000
                :8'b10000000
            :(MODE1)? 8'b00000110
                :8'b01100000;


    wire [7:0]an;
    scan_data utt(rst,out,CLK,AN,SEG);


    assign AN = SET & CP_500MS ? an | ori: an;
    //如果在set状�?�，500ms闪烁�??次，通过屎能信号来实�??

    
endmodule