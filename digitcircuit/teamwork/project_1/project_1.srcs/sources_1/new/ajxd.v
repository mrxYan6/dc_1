`timescale 1ns / 1ps
module button(clk_100,key,key_p);
  input key,clk_100;
  output reg key_p;
  reg[2:0] ST;
  parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
  always @( posedge clk_100)
  begin

    case(ST)
      S0:
        key_p<=key?1'b0:1'b0;
      S1:
        key_p<=key?1'b1:1'b0;
      S2:
        key_p<=key?1'b0:1'b0;
      S3:
        key_p<=key?1'b1:1'b1;
      S4:
        key_p<=key?1'b1:1'b0;
      S5:
        key_p<=key?1'b1:1'b0;
    endcase
    case(ST)
      S0:
        ST<=key?S1:S0;
      S1:
        ST<=key?S3:S2;
      S2:
        ST<=key?S1:S0;
      S3:
        ST<=key?S3:S4;
      S4:
        ST<=key?S5:S0;
      S5:
        ST<=key?S3:S4;
    endcase
  end
endmodule

// module button(input clk,input X,output Y);
// //    reg [2:0]ST;
// //    reg A;
//     assign Y = X;
//     // initial A = 0;
//     // initial ST = 3'b0;
//     // reg[31:0]f;
//     // initial f = 32'd3;
//     // wire CP;
//     // Fdiv dvd(,32'd1000000,clk,CP);
//     // always @(posedge CP)
//     // begin
//     //     case(ST)
//     //         3'b000:begin
//     //             ST<=(X?3'b001:3'b000);//000
//     //             A <= 0;
//     //         end
//     //         3'b001: //001
//     //         begin
//     //             ST<=(X?3'b011:3'b010);
//     //             A <= X;
//     //         end
//     //         3'b010:begin
//     //             ST<=(X?3'b001:3'b000);//010
//     //             A <= 0;
//     //         end
//     //         3'b011:begin
//     //             ST<=(X?3'b011:3'b100);//111
//     //             A <= 1;
//     //         end
//     //         3'b100://110
//     //         begin
//     //             ST<=(X?3'b101:3'b000);
//     //             A <= X;
//     //         end
//     //         3'b101:begin
//     //             ST<=(X?3'b011:3'b100);//101
//     //             A <= 1;
//     //         end
//     //         default:begin
//     //             ST<=ST;
//     //             A <= 0;
//     //         end
//     //     endcase
//     // end
// endmodule

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
