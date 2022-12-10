`timescale 1ns / 1ps
//0~23¼ÆÊýÆ÷
module counter24(
    input CP,EN,LD,
    input [4:0]D,
    output reg[4:0]Q
    );
initial Q=0;
always @(posedge CP or posedge LD)
begin
    if(LD)Q<=D;
    else if(!EN)Q<=Q;
    else
    begin
        if(Q==5'b10111)Q<=5'b0;
        else Q<=Q+1'b1;
    end
end
endmodule
