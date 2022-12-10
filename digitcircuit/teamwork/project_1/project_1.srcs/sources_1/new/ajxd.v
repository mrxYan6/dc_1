`timescale 1ns / 1ps

module button
    #(parameter CNT_MAX=20'd999_999)
    (CP,IN,OUT);
    input CP,IN;
    output reg OUT;
    reg [19:0] cnt_20ms;
    initial cnt_20ms=0;
    always @(posedge CP)
    begin
        if(IN==1'd1)
            cnt_20ms<=20'd0;
        else if(cnt_20ms==CNT_MAX)
            cnt_20ms<=CNT_MAX;
        else
            cnt_20ms<=cnt_20ms+20'd1;
    end
    
    always@ (posedge CP)
    begin
        if(cnt_20ms==CNT_MAX-20'd1)
            OUT<=1'd1;
        else
            OUT<=1'd0;
    end
    
endmodule
