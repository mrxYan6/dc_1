`timescale 1ns / 1ps

module Clock(CLK,reset,EN,TYPE,NEXT_CP_ini,SET,AN,SEG);
    input CLK;
    input reset;
    input EN;
    input [1:0]TYPE;
    input SET;
    output [7:0]AN;
    output [7:0]SEG;
    input NEXT_CP_ini;

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

    Counter sec(SET,EN,CP_1S,8'd60,second_toset,second_now,CO1);
    Counter minu(SET,EN,CO1,8'd60,minute_toset,minute_now,CO2);
    Counter hou(SET,EN,CO2,8'd24,hour_toset,hour_now,CO3);
    Counter week(SET,EN,CO3,8'd7,weekday_toset,weekday_now,CO);

    reg [31:0]out;
    always @(*) begin
        case (TYPE)
            1 : out = {28'hfffffff,weekday[3:0]};
            2 : out = {4'hf,hour_alarm,4'hf,4'hf,minute_alarm,4'hf};
            default : out = {hour,4'hf,minute,4'hf,second};
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
                2 : begin
                        case(MODE)begin
                        0:ori = 8'b01100000;
                        1:ori = 8'b00000110;
                        end
                end
                default : 
                case(MODE)begin
                    0:ori = 8'b11000000;
                    1:ori = 8'b00011000;
                    2:ori = 8'b00000011;
                end
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

    scan_data utt(LD,out,CLK,AN,EN_TUBE,SEG);

    always @(*) begin
        if (SET)begin
            hour = hour_toset;
            minute = minute_toset;
            second = second_toset;
            weekday = weekday_toset;
            hour_alarm = hour_alarm_toset;
            minute_alarm = minute_alarm_toset;
            second_alarm = second_alarm_toset;
        end else begin
            hour = hour_now;
            minute = minute_now;
            second = second_now;
            weekday = weekday_now;
            hour_alarm = hour_alarm_now;
            minute_alarm = minute_alarm_now;
            second_alarm = second_alarm_now;
        end
    end
endmodule