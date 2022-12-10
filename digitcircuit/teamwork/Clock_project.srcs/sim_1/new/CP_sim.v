`timescale 1ns / 1ps
//CPÐÅºÅ·ÂÕæ
module CP_sim();
wire CP;
wire CP0;
CP_generator cpg(CP0);
reg [8:0]num;
initial num=9'b000001010;
Divider dvd(num,CP);
always 
begin
    #10;
end

endmodule