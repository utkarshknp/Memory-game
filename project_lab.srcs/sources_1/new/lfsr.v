`timescale 1ns / 1ps


module lfsr(input clk,input [3:0]inval,output [3:0]lfs);
reg [5:0]lfsreg;
reg a;
//reg [3:0]lf;
initial
begin
lfsreg={1'b1^inval[1],inval,1'b0};
end

always @(posedge clk)
begin
lfsreg={lfsreg[4]^lfsreg[2]^lfsreg[0],lfsreg[5:1]};
end

assign lfs={lfsreg[5],lfsreg[1],lfsreg[3],lfsreg[2]};

endmodule
