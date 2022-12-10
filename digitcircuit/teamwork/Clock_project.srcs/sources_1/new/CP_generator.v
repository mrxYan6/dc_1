`timescale 1ns / 1ps
//100MHz
module CP_generator(output wire CP);
reg T;initial T=0;
assign CP=T;
always
begin
    #10;T=~T;
end
endmodule
