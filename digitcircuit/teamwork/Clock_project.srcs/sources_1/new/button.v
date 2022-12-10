`timescale 1ns / 1ps
//°´Å¥Ïû¶¶
module button(input clk,input X,output Y);
    reg [2:0]ST;
    reg A;assign Y=A;
    initial A=0;
    initial ST=3'b0;
    //reg[31:0]f;
    reg[31:0]f;initial f=32'd3;
    wire CP;
    Divider dvd(clk,f,CP);
    always @(posedge CP)
    begin
        case(ST)
            3'b000:ST<=(X?3'b001:3'b000);//000
            3'b001://001
            begin
                ST<=(X?3'b011:3'b010);
                if(X)A<=1'b1;
            end
            3'b010:ST<=(X?3'b001:3'b000);//010
            3'b011:ST<=(X?3'b011:3'b100);//111
            3'b100://110
            begin
                ST<=(X?3'b101:3'b000);
                if(!X)A<=1'b0;
            end
            3'b101:ST<=(X?3'b011:3'b100);//101
            default:ST<=ST;
        endcase
    end
endmodule