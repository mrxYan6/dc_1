`timescale 1ns / 1ps
//∞¥≈•œ˚∂∂≤‚ ‘
module button_sim();
wire clk;
CP_generator cpg(clk);
reg X;wire Y;wire [2:0]ST;
button bt(clk,X,Y);
initial X=0;
always 
begin
    #100;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X;
    #10;X=~X; 
    #500;
end

endmodule
