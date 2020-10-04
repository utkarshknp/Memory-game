`timescale 1ns / 1ps


module clk1(input clkin, output clkout);

reg [27:0] count;
reg clkout;

initial
begin
count=0;
end

initial
clkout=1'b1;

always@(posedge clkin)
begin
    count=count+1;
    if(count==100000000)
         begin
            clkout=~clkout;
            count=0;
         end
end
endmodule