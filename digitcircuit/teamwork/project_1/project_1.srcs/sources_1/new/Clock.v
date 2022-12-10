`timescale 1ns / 1ps

module Clock(clk,reset,EN,SW,SET,AN,seg);
    input clk;
    input reset;
    input [1:0]SW;
    input SET;
    output [7:0]AN;
    output [7:0]seg;
    
    wire [7:0]hour,minute,second;
    wire [3,0]_,weekday;

    wire CP_1S;
    wire CO1,CO2,CO3,CO4;
    Counter sec(LD,EN,CP_1S,8'd60,D,Q,CO1);
    Counter minu(LD,EN,CO1,8'd60,D,Q,CO2);
    Counter hou(LD,EN,CO2,8'd24,D,Q,CO3);
    Counter week(LD,EN,CO3,8'd7,D,{_,weekday},CO)



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
