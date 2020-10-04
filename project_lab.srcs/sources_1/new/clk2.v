`timescale 1ns / 1ps

module clk2(input clkin, output clkout);

reg [29:0] count;
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
    if(count==200000000)
         begin
            clkout=~clkout;
            count=0;
         end
end
endmodule
