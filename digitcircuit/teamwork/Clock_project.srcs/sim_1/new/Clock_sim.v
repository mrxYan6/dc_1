`timescale 1ns / 1ps
//Êý×ÖÖÓ·ÂÕæ
module Clock_sim();
//wire[4:0]hour;
//wire [5:0]minute,second;
reg [4:0]h;
reg [5:0]m,s;
wire [3:0]A5,A4,A3,A2,A1,A0;
reg EN,LD;
Clock clk(EN,LD,h,m,s,A5,A4,A3,A2,A1,A0);
initial 
begin
    EN=1;LD=0;
    h=5'b0;
    m=6'b0;
    s=6'b0;
end
endmodule
