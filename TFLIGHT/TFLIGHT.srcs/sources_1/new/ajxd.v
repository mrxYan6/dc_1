`timescale 1ns / 1ps

module button(input clk,input X,output Y);
    reg [2:0]ST;
    reg A;
    assign Y = A;
    initial A = 0;
    initial ST = 3'b0;
    // reg[31:0]f;
    // initial f = 32'd3;
    wire CP;
    Fdiv dvd(,32'd1000000,clk,CP);
    always @(posedge CP)
    begin
        case(ST)
            3'b000:ST <= (X ? 3'b001 : 3'b000);//000
            3'b001: //001
            begin
                ST <= (X ? 3'b011 : 3'b010);
                if(X) A <= 1;
            end
            3'b010 : ST <= (X ? 3'b001 : 3'b000);//010
            3'b011 : ST <= (X ? 3'b011 : 3'b100);//111
            3'b100 ://110
            begin
                ST <= (X ? 3'b101 : 3'b000);
                if(!X)A<=0;
            end
            3'b101 : ST <= (X ? 3'b011 : 3'b100);//101
            default:ST <= ST;
        endcase
    end
endmodule

// module button1
//     #(parameter CNT_MAX=20'd999_999)
//     (CP,IN,OUT);
//     input CP,IN;
//     output reg OUT;
//     reg [19:0] cnt_20ms;
//     initial cnt_20ms=0;
//     always @(posedge CP)
//     begin
//         if(IN==1'd1)
//             cnt_20ms<=20'd0;
//         else if(cnt_20ms==CNT_MAX)
//             cnt_20ms<=CNT_MAX;
//         else
//             cnt_20ms<=cnt_20ms+20'd1;
//     end
    
//     always@ (posedge CP)
//     begin
//         if(cnt_20ms==CNT_MAX-20'd1)
//             OUT<=1'd1;
//         else
//             OUT<=1'd0;
//     end
    
// endmodule
