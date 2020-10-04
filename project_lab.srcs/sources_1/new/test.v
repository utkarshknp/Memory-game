`timescale 1ns / 1ps


module test(input [3:0]in,output reg [7:0]out, input clk, input p,input restart, input onoff);
reg [3:0]rannum[0:2];
reg [3:0]innum[0:2];
reg [5:0] counter = 5'b00000;
wire clkout1;
wire clkout2;
reg [3:0]state;
wire [3:0]lfsin;
reg [4:0] sum;




initial
    begin
        state=4'b0000;
        out=8'b00000000;
        sum=0;
    end

clk1 clkgen1( clk, clkout1);
clk2 clkgen2( clk, clkout2);


always@(posedge clkout1)
    begin
        counter=counter+5'b00001;
    end

//reg [3:0] count = counter[3:0];
lfsr l1(clkout1,counter[3:0],lfsin);


always@(posedge clkout2)
  begin

     if(restart==1)
           begin
            state=4'b0000;
            sum=0;
           end
     else
      begin     
     
         if(state==4'b0000)
            begin
                if(onoff==1)
                    begin
                    out[7:4]=lfsin;
                    rannum[0]=lfsin;
                    state=4'b0001;
                    end

            end
        
        else if(state==4'b0001)
            begin
                 out[7:4]=lfsin;
                 rannum[1]=lfsin;
                 state=4'b0010;
            end
        
        else if(state==4'b0010)
            begin
                out[7:4]=lfsin;
                rannum[2]=lfsin;
                state=4'b0011;
            end
                        
        else if(state==4'b0011)
            begin
                 out=8'b11111111;
                 state=4'b0100;
            end
    
        else if(state==4'b0100)
            begin
                out=8'b00000000;
                if(p==1) 
                    begin
                        innum[0]=in;
                        state=4'b0101;     
                    end
                 else
                       begin
                        state=4'b0100;     
                       end
                       
            end
        else if(state==4'b0101)
            begin
                if(p==1) 
                    begin
                        innum[1]=in;
                        state=4'b0110;     
                    end
                 else
                       begin
                        state=4'b0101;     
                 end

            end
        else if(state==4'b0110)
            begin

                if(p==1) 
                    begin
                        innum[2]=in;
                        state=4'b0111;     
                    end
                 else
                       begin
                        state=4'b0110;     
                 end

            end
        else if(state==4'b0111)
            begin
                  sum=rannum[0]+rannum[1]+rannum[2]-innum[0]-innum[1]-innum[2];
                  state=4'b1000;
            end
        else if(state==4'b1000)
            begin
                    if(sum==0)
                        begin                  
                            if(rannum[0]==innum[0] && rannum[1]==innum[1] && rannum[2]==innum[2])
                                out=8'b11111111;                       
                            else
                                out=8'b10101010;
                        end        
                    else
                        out=8'b00000000; 
                    state=4'b1000;  
            end
      end
  end

endmodule
