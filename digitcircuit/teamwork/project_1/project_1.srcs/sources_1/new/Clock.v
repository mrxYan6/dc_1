`timescale 1ns / 1ps

module Clock(CLK,reset,EN,TYPE,SET,AN,SEG);
    input CLK;
    input reset;
    input EN;
    input [1:0]TYPE;
    input SET;
    output [7:0]AN;
    output [7:0]SEG;
    
    reg [7:0]hour,minute,second;
    reg [7:0]weekday;
    reg [7:0]hour_alarm,minute_alarm,second_alarm;

    wire [7:0]hour_now,minute_now,second_now;
    wire [7:0]hour_toset,minute_toset,second_toset;

    wire [7:0]weekday_now;
    wire [7:0]weekday_toset;

    wire [7:0]hour_alarm_now,minute_alarm_now;
    wire [7:0]hour_alarm_toset,minute_alarm_toset;

    wire CP_1S;
    wire CO1,CO2,CO3,CO4;
    wire LD;

    Fdiv div1s(LD,32'd50000000,CLK,CP_1S);
    
    button but(CLK,reset,LD);

    Counter sec(SET,EN,CP_1S,8'd60,second_toset,second_now,CO1);
    Counter minu(SET,EN,CO1,8'd60,minute_toset,minute_now,CO2);
    Counter hour(SET,EN,CO2,8'd24,hour_toset,hour_now,CO3);
    Counter week(SET,EN,CO3,8'd7,weekday_toset,weekday_now,CO);
    
    reg [31:0]out;
    always @(*) begin
        case (TYPE)
            0 : out = {hour,4'd10,minute,4'd10,second};
            1 : out = {24'd0,weekday};
            2 : out = {4'd10,hour_alarm,4'd10,4'd10,minute_alarm,4'd10};
        endcase
    end

    scan_data utt(LD,out,CLK,AN,SEG);

    always @(*) begin
        if(SET)begin
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
