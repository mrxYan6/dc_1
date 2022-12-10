`timescale 1ns / 1ps

module decoder(D,BCD);
    input wire [7:0]D;
    output reg [7:0]BCD;
    reg [3:0]high;
    reg [3:0]low;
    
    always@(*)begin
        high = D / 10;
        low = D % 10;
        BCD = {high,low};
    end
endmodule