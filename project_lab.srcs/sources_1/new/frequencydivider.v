`timescale 1ns / 1ps


module frequencydivider(input clkin, output clkout  );

reg [9:0] count;
reg clkout;

initial
count=0;

initial
clkout=1'b0;

always@(posedge clkin)
begin
count=count+1'b1;
end

if(count==10'b1111111111)
clkout=~clkout;

endmodule
