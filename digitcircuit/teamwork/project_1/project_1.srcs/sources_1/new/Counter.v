`timescale 1ns / 1ps

module Counter(RST,LD,EN,CP,LMT,D,Q,CO);
    input RST,LD,EN,CP;
    output reg [7:0]Q;
    input [7:0]D;
    input [7:0]LMT;
    output reg CO;    

    initial begin Q <= 4'b0000;end

    always @(posedge RST or posedge CP or posedge LD) begin
        if(!RST)begin
            Q <= 0;
            CO <= 0;
        end else if(LD)begin
            if(D < LMT)begin
                Q <= D;
                CO <= 0;
            end else begin
                Q <= Q;
                CO <= CO;
            end
        end else begin
            if(EN)begin            
                if(Q == LMT - 1'b1 )begin
                    Q <= 8'b0;
                    CO <= 1;
                end else begin 
                    Q <= Q + 1'b1;
                    CO <= 0;
                end
            end else begin
                Q <= Q;
                CO <= CO;
            end
        end
    end
endmodule