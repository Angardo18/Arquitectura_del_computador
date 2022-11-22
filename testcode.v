module  prog_cout (input CLK ,input ac_dc ,output reg  [7:0] out_num);
   initial 

   out_num = 8'd0;
  always @ (posedge CLK) begin
    if (ac_dc)
        out_num = 2 + out_num;

    else //(enable == 1'b1) 
        out_num = 3 + out_num;
end
endmodule



module tb();

    reg en, clk;
    wire [7:0] count ;



    prog_cout s1(clk,en, count);


    initial begin
    
    en = 1'b0;   
    //count= 5'd0;
        $display(" clk  |  enable   |  out num ");
        $monitor("%b  %b  %d  ",clk,en, count);
        
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
