`timescale 1ns / 1ps

module Clock(CLK,reset,EN,TYPE,NEXT_CP_ini,SET,IN,AN,SEG,alert);
    input CLK;          //输入的时钟信号
    input reset;        //清零（按钮）
    input EN;           //是否开始
    input TYPE;         //显示及设置模式（开关）
    input NEXT_CP_ini;  //设置时下一个（按钮）
    input SET;          //是否为输入模式（开关）
    input [7:0]IN;      //输入的数字（开关）
    output [7:0]AN;     //输出的数码管使能端信号
    output [7:0]SEG;    //输出的数码管信号
    output [7:0]alert;  //灯，表示闹钟到了    

    //mode0：时钟 w-hhmmss
    //mode1：闹钟 -hh--mm-
    reg [7:0]hour,minute,second,weekday,hour_alarm,minute_alarm;

    reg [1:0]MODE0;//00->ss,01->mm,10->hh,11->w
    reg MODE1;//0->mm,1->hh
    
    wire [7:0]hour_now,minute_now,second_now,weekday_now,hour_alarm_now,minute_alarm_now;
    wire [7:0]hour_toset,minute_toset,second_toset,weekday_toset,hour_alarm_toset,minute_alarm_toset;

    wire CP_1S,CP_500MS;
    wire CO1,CO2,CO3,CO4;
    wire LD,NEXT_CP;

    button but1(CLK,reset,LD);
    button but2(CLK,NEXT_ini,NEXT_CP);

    Fdiv div1s(LD,32'd50000000,CLK,CP_1S);
    Fdiv div500ms(LD,32'd25000000,CLK,CP_500MS);

    Counter sec(LD,EN,CP_1S,8'd60,second_toset,second_now,CO1);
    Counter minu(LD,EN,CO1,8'd60,minute_toset,minute_now,CO2);
    Counter hou(LD,EN,CO2,8'd24,hour_toset,hour_now,CO3);
    Counter week(LD,EN,CO3,8'd7,weekday_toset,weekday_now,CO);

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
        end else begin
            if(TYPE)MODE1 = MODE1 + 1;
            else MODE0 = MODE0 + 1;
        end
    end
    
    assign ori =   TYPE ?
                (MODE0 == 0) ?  8'b00000011
                :(MODE0 == 1) ?  8'b00001100
                :(MODE0 == 2) ?  8'b00110000
                :8'b10000000
            :(MODE1)? 8'b00000110
                :8'b01100000;
                            


    wire [7:0]an;
    scan_data utt(LD,out,CLK,AN,SEG);


    assign AN = SET & CP_500MS ? an | ori: an;
    //如果在set状态，500ms闪烁一次，通过屎能信号来实现

    
    // always @(*) begin
    //     if (SET)begin
    //         hour = hour_toset;
    //         minute = minute_toset;
    //         second = second_toset;
    //         weekday = weekday_toset;
    //         hour_alarm = hour_alarm_toset;
    //         minute_alarm = minute_alarm_toset;
    //     end else begin
    //         hour = hour_now;
    //         minute = minute_now;
    //         second = second_now;
    //         weekday = weekday_now;
    //         hour_alarm = hour_alarm_now;
    //         minute_alarm = minute_alarm_now;
    //     end
    // end
endmodule