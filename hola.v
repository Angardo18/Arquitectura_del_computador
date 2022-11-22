module  prog_cout (input CLK ,input enable ,input [4:0] num_up ,output reg  [4:0] out_num);
   initial 
   out_num = 5'd0;
  always @ (posedge CLK) begin
    if (enable)
        out_num = num_up + out_num;

    else //(enable == 1'b1) 
        out_num = out_num + 1'b1;
end
endmodule



module tb();

    reg [4:0] comman;
    reg en, clk;
    wire [4:0] count ;



    prog_cout s1(clk,en,comman, count);


    initial begin
    comman = 5'd25; 
    en = 1'b0;   
    //count= 5'd0;
        $display(" clk  |  enable  |  num up  |  out num ");
        $monitor("%b  %b  %d %d  ",clk,en, comman,count);
        
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
       
        
 
        #1 en = 1'b1;
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 en = 1'b0;  

        
        #1 clk = 1'b0; 
        #1 clk = 1'b1;    
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;  
    end
endmodule
