`timescale 1ns / 1ps

module Clock(CLK,reset,EN,TYPE,NEXT_CP_ini,SET,MODIFY,IN,AN,SEG,alert);
    input CLK;          //输入的时钟信号
    input reset;        //清零（按钮）
    input EN;           //是否开始
    input TYPE;         //显示及设置模式（开关）
    input NEXT_CP_ini;  //设置时下一个（按钮）
    input SET;          //是否为输入模式（开关）
    input MODIFY;       //输入模式时确定输入
    input [7:0]IN;      //输入的数字（开关）
    output [7:0]AN;     //输出的数码管使能端信号
    output [7:0]SEG;    //输出的数码管信号
    output [7:0]alert;  //灯，表示闹钟到了

    //mode0：时钟 w-hhmmss
    //mode1：闹钟 -hh--mm-
    reg [7:0]hour,minute,second,weekday,hour_alarm,minute_alarm;

    reg [1:0]MODE0;     //00->ss,01->mm,10->hh,11->w
    reg MODE1;          //0->mm,1->hh
    
    wire [7:0]hour_now,minute_now,second_now,weekday_now,hour_alarm_now,minute_alarm_now;
    // wire [7:0]hour_toset,minute_toset,second_toset,weekday_toset,hour_alarm_toset,minute_alarm_toset;

    wire CP_1S,CP_500MS;
    wire CO1,CO2,CO3,CO4;
    wire rst,NEXT_CP,SURE;
    reg [3:0]LD;
    reg  [1:0]LD2;
    button but1(CLK,reset,rst);
    button but2(CLK,NEXT_ini,NEXT_CP);
    button but3(CLK,MODIFY,SURE);

    Fdiv div1s(rst,32'd50000000,CLK,CP_1S);
    Fdiv div500ms(rst,32'd25000000,CLK,CP_500MS);

    Counter sec(rst,LD[0],EN,CP_1S,8'd60,8'd0,second_now,CO1);
    Counter minu(rst,LD[1],EN,CO1,8'd60,IN,minute_now,CO2);
    Counter hou(rst,LD[2],EN,CO2,8'd24,IN,hour_now,CO3);
    Counter week(rst,LD[3],EN,CO3,8'd7,IN,weekday_now, );

    //不进位
    Counter h_a(rst,LD2[1],EN, ,8'd24,IN,hour_alarm_now, );
    Counter m_a(rst,LD2[0],EN, ,8'd60,IN,minute_alarm_now, );



    always @(*)begin
        hour = hour_now;
        minute = minute_now;
        second = second_now;
        weekday = weekday_now;
        hour_alarm = hour_alarm_now;
        minute_alarm = minute_alarm_now;
    end

    // Counter sec1(LD,EN,CP_1S,8'd60,second_now,8'b0,CO1);
    // Counter minu1(LD,EN,CO1,8'd60,minute_now,minute_toset,CO2);
    // Counter hou1(LD,EN,CO2,8'd24,hour_now,hour_toset,CO3);
    // Counter week1(LD,EN,CO3,8'd7,weekday_now,weekday_toset,CO);

    wire [7:0] h,m,s,ha,ma,w;
    
    decoder u1(hour,h);
    decoder u2(minute,m);
    decoder u3(second,s);
    decoder u4(hour_alarm,ha);
    decoder u5(minute_alarm,ma);
    decoder u6(weekday,w);

    wire [31:0]out;
    assign out = TYPE?{w[3:0],4'hf,h,m,s}:{4'hf,ha,4'hf,4'hf,ma,4'hf};

    wire [7:0] EN_TUBE;
    wire [7:0] ori;

    always @(posedge SET or posedge NEXT_CP)begin
        if(SET)begin
            MODE0 <= 0;
            MODE1 <= 0;
        end else if(!MODIFY) begin
            if(TYPE)MODE1 <= MODE1 + 1;
            else MODE0 <= MODE0 + 1;
        end else begin
            MODE0 <= MODE0;
            MODE1 <= MODE1;
        end
    end
    
    //产生置数信号
    always @(*)begin
        if(SET)begin
            if(TYPE)begin
                LD2[MODE1] = MODIFY;
            end else begin
                LD[MODE0] = MODIFY;
            end
        end else begin
            LD = 4'd0;
            LD2 = 2'd0;
        end
    end

    //辅助产生位选信号
    assign ori =   TYPE ?
                (MODE0 == 0) ?  8'b00000011
                :(MODE0 == 1) ?  8'b00001100
                :(MODE0 == 2) ?  8'b00110000
                :8'b10000000
            :(MODE1)? 8'b00000110
                :8'b01100000;


    wire [7:0]an;
    scan_data utt(rst,out,CLK,AN,SEG);


    assign AN = SET & CP_500MS ? an | ori: an;
    //如果在set状态，500ms闪烁一次，通过屎能信号来实现

    
endmodule