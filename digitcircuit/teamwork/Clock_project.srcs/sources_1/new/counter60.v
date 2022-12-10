`timescale 1ns / 1ps
//0~59¼ÆÊýÆ÷
module counter60(
    input CP,EN,LD,
    input [5:0]D,
    output reg[5:0]Q,
    output reg CO
    );
initial Q=0;
initial CO=0;
always @(posedge CP or posedge LD)
begin
    if(LD)
    begin
        Q<=D;
        CO<=0; 
    end
    else if(!EN)Q<=Q;
    else
    begin
        if(Q==6'b111011)
        begin
            Q<=6'b0;
            CO<=1;
        end
        else 
        begin
            Q<=Q+1'b1;
            CO<=0;
        end
    end
end
endmodule
