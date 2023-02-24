`timescale 1ns / 1ps

module Counter(RST,LD,EN,CP,LMT,D,Q,CO);
    input RST,LD,EN,CP;
    output reg [7:0]Q;
    input [7:0]D;
    input [7:0]LMT;
    output reg CO;    

    initial begin Q <= 8'd0;CO <= 0;end

    always @(negedge RST or posedge CP or posedge LD) begin
        if(!RST)begin
            Q <= 0;
            CO <= 0;
        end else if(LD)begin
            if(D <= LMT)begin
                Q <= D;
                CO <= 0;
            end else begin
                Q <= Q;
                CO <= CO;
            end
        end else if(!EN)begin            
            Q <= Q;
            CO <= CO;
        end else begin
            if(Q == LMT)begin
                Q <= 8'd0;
                CO <= 1;
            end else begin 
                Q <= Q + 8'd1;
                CO <= 0;
            end
        end
    end
endmodule