`timescale 1ns / 1ps
//·ÖÆµÆ÷
module Divider(
    input clk,
    input [31:0]F,
    output Y
);
reg A;initial A=0;
assign Y=A;
//wire CP;
//CP_generator cpg(CP);
reg[31:0] cnt;
initial cnt=9'b000000000;
always @(posedge clk)
begin
    if(cnt==F)
    begin
        A=~A;
        cnt<=32'b000000000;
    end
    else cnt<=cnt+1'b1;
end
endmodule