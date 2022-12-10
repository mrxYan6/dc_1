`timescale 1ns / 1ps

module decoder(D,BCD);
    input [5:0] D;
    //input CE;//进位信号
    //output CO;//进位
    output reg [7:0] BCD;

    integer i=0;
    reg [3:0] uni,tens;
    always @(*)begin
        uni=4'd0;
        tens=4'd0;
        for(i=5;i>=0;i--)begin
            if(uni>=4'd5) uni<=uni+4'd3;
            if(tens>=4'd5) tens<=tens+4'd3;
            tens={tens[2:0],uni[3]};
            uni={uni[2:0],D[i]};
        end
    end
    assign BCD<={tens,uni};
endmodule