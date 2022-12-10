`timescale 1ns / 1ps


module Coounter(LD_,CT_,U_D,CP,D,Q,MM,RCO_,number);
    input LD_,CT_,U_D,CP;
    input [3:0] D;
    input number;
    //output reg MM=0;
    //output RCO_;
    output reg [3:0] Q;
    
    //assign RCO_=CP+CT_+~MM;
    always @(posedge CP or negedge LD_)
    begin
        if(!LD_)
            Q<=D;
        else if(CT_)
            Q<=Q;
        else
            if(U_D==0)begin
                if(Q<=number-2)begin
                Q<=Q+1'b1;end
                else if(Q==number-1)begin
                Q<=0;end
                end
            else begin
                if(Q<=number)
                    if(Q>=1)begin
                    Q<=Q-1'b1;end
                    else if(Q==0)begin
                    Q<=number-1;end
            end
    end
endmodule
