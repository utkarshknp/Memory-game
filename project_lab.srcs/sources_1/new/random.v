`timescale 1ns / 1ps


module random(wire clk,[3:0]counter);
reg [3:0] count;
always @(posedge clk)
begin
count=count+1'b1;
end

assign counter={count[0],count[2],count[1],count[3]};

endmodule
