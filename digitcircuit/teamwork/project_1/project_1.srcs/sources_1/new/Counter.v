`timescale 1ns / 1ps

module Counter(LD,EN,CP,LMT,D,Q,CO);
    input LD,EN,CP;
    output reg [7:0]Q;
    input [7:0]D;
    input [7:0]LMT;
    output reg CO;    

    initial begin Q <= 4'b0000;end

    always @(posedge CP or posedge LD) begin
        if(LD)begin
            Q <= D;
            CO <= 0;
        end else begin
            if(EN)begin            
                if(Q + 1'b1 == LMT )begin
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