`timescale 1ns / 1ps


// module Coounter(LD_,EN_,U_D,CP,D,Q,MM,RCO_,number);
//     input LD_,EN_,U_D,CP;
//     input [3:0] D;
//     input number;
//     //output reg MM=0;
//     //output RCO_;
//     output reg [3:0] Q;
    
//     //assign RCO_=CP+EN_+~MM;
//     always @(posedge CP or negedge LD_)
//     begin
//         if(!LD_)
//             Q<=D;
//         else if(EN_)
//             Q<=Q;
//         else
//             if(U_D==0)begin
//                 if(Q<=number-2)begin
//                 Q<=Q+1'b1;end
//                 else if(Q==number-1)begin
//                 Q<=0;end
//                 end
//             else begin
//                 if(Q<=number)
//                     if(Q>=1)begin
//                     Q<=Q-1'b1;end
//                     else if(Q==0)begin
//                     Q<=number-1;end
//             end
//     end
// endmodule

module Coounter(LD_,EN_,CP,LMT,D,Q,RCO_,MX);
    input LD_,EN_,CP;
    output reg [0:3]Q;
    input [0:3]D;
    input [0:3]LMT;
    output reg RCO_;    
    output reg MX;

    initial begin Q <= 4'b0000;end

    always @(posedge CP or negedge LD_) begin
        if(!LD_)begin
            Q <= D;
        end else begin
            if(EN_ == 0)begin            
                Q <= Q + 4'b0001;
            end else begin 
                Q <= Q;
            end
        end
    end

    always @(*) begin
        if (Q + 1'b1 == LMT)
            MX = 1;
        else 
            MX = 0;
    end

    always @(*) begin
        RCO_ = CP | EN_ | ~MX;
    end

endmodule