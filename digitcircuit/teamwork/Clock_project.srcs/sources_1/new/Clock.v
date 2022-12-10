`timescale 1ns / 1ps
//数字钟模块
module Clock(
    input clk,
    input EN0,//EN=0:暂停
    input LD0,//异步置数
    input [4:0]h,
    input [5:0]m,
    input [5:0]s,
    output [7:0]AN,
    output [7:0]seg
    );
wire [4:0]hour;
wire [5:0]minute,second;
reg[3:0]A5,A4,A3,A2,A1,A0;
reg[31:0]num;initial num=32'b0;
always @(*)
begin
    A0=second%10;
    A1=second/10;
    A2=minute%10;
    A3=minute/10;
    A4=hour%10;
    A5=hour/10;
    num={8'b00000000,A5,A4,A3,A2,A1,A0};
end
scan sc(clk,1'b1,num,AN,seg);
reg[31:0] T;
initial T=32'd50000000;//一秒一下
//initial T=32'd2000000;//一秒25下
wire CP;
Divider dvd(clk,T,CP);
wire LD;
button bt(clk,LD0,LD);
//assign LD=LD0;
wire EN;assign EN=EN0&&!LD;
wire CO1,CO2;
counter60 c3(CP,EN,LD,s,second,CO1);
counter60 c2(CO1,EN,LD,m,minute,CO2);
counter24 c1(CO2,EN,LD,h,hour);
endmodule
