`timescale 1ns / 1ps

module Clock(CLK,reset,EN,TYPE,NEXT_CP_ini,SET,AN,SEG,alert);
    input CLK;          //输入的时钟信号
    input reset;        //清零（按钮）
    input EN;           //是否开始
    input [1:0]TYPE;    //显示及设置模式（开关）
    input SET;          //是否为输入模式（开关）
    output [7:0]AN;     //输出的数码管使能端信号
    output [7:0]SEG;    //输出的数码管信号
    input NEXT_CP_ini;  //设置时下一个（按钮）
    output [7:0]alert;  //灯，表示闹钟到了    

    reg [7:0]hour,minute,second,weekday,hour_alarm,minute_alarm;

    reg [1:0]MODE,PREV;

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
    decoder u1(second,s);
    decoder u1(hour_alarm,ha);
    decoder u1(minute_alarm,ma);
    decoder u1(weekday,w);

    reg [31:0]out;
    always @(*) begin
        case (TYPE)
            1 : out = {28'hfffffff,w[3:0]};
            2 : out = {4'hf,ha,4'hf,4'hf,ma,4'hf};
            default : out = {h,4'hf,m,4'hf,s};
        endcase
    end
    

    reg [7:0]EN_TUBE,ori;

    always @(posedge SET or posedge NEXT_CP)begin
        if(SET)begin
            MODE <= 0;
        end else begin
        end
    end
    

    always @(*) begin
        if (SET)
        begin
            case(TYPE)
                1 : ori = 8'h1;
                2 : case(MODE)
                        0:ori = 8'b01100000;
                        1:ori = 8'b00000110;
                    endcase
                default : 
                case(MODE)
                    0:ori = 8'b11000000;
                    1:ori = 8'b00011000;
                    2:ori = 8'b00000011;
                endcase
            endcase
        end else begin
            ori = 8'd0;
        end
    end

    always @(*) begin
        if (SET) begin
            EN_TUBE = ori & CP_500MS;
        end else begin
            EN_TUBE = ori;
        end
    end

    scan_data utt(LD,out,CLK,AN,SEG);

    always @(*) begin
        if (SET)begin
            hour = hour_toset;
            minute = minute_toset;
            second = second_toset;
            weekday = weekday_toset;
            hour_alarm = hour_alarm_toset;
            minute_alarm = minute_alarm_toset;
        end else begin
            hour = hour_now;
            minute = minute_now;
            second = second_now;
            weekday = weekday_now;
            hour_alarm = hour_alarm_now;
            minute_alarm = minute_alarm_now;
        end
    end
endmodule