`timescale 1ns / 1ps

module ajxd
    #(parameter CNT_MAX=20'd999_999)
    (CP,rst,key,flag);
    input CP,rst,key;
    output reg flag;
    reg [19:0] cnt_20ms;
    initial cnt_20ms=0;
    always @(posedge CP)
    begin
        if(key==1'd1)
            cnt_20ms<=20'd0;
        else if(cnt_20ms==CNT_MAX)
            cnt_20ms<=CNT_MAX;
        else
            cnt_20ms<=cnt_20ms+20'd1;
    end
    
    always@ (posedge CP)
    begin
        if(rst==1'd0)
            flag<=1'd1;
        else if(cnt_20ms==CNT_MAX-20'd1)
            flag<=1'd1;
        else
            flag<=1'd0;
    end
    
endmodule
