`timescale 1ns / 1ps
module digitClock(clk,reset,SW,SET,AN,seg);
    input clk;
    input reset;
    input [1:0]SW;
    input SET;
    output [7:0]AN;
    output [7:0]seg;
    reg [31:0]date;
    reg[31:0]tim;
    reg[31:0]week;

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







