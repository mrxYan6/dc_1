`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/16 13:42:39
// Design Name: 
// Module Name: simulation_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simulation_decoder();
    
    reg [7:0] bin;
    wire [7:0] ans;

    decoder utt(bin,ans);

    initial begin
        bin = 0;
    end

    always @(*)begin
        #20
        bin <= bin + 1;
    end
endmodule