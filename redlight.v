module  prog_cout (input CLK ,output reg  [2:0] light);
reg [4:0] num = 5'b0;
   initial 
   light = 3'd0;


  always @ (posedge CLK) begin
    num = num + 1;
    if (num <= 10)begin 
        light = 3'b001;
    end 
    else if (num >= 10 && num <= 13)begin
        light = 3'b010;
    end 
    else if (num >= 13 && num <= 23)begin
        light = 3'b100;
    end
    else 
    num = 0;
end
endmodule



module tb();

    reg  clk;
    wire [2:0] count ;



    prog_cout s1(clk, count);


    initial begin
    
     
    //count= 5'd0;
        $display(" clk  |  enable   |  out num ");
        $monitor("%b  %b    ",clk ,count);
        
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;    
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;  
          #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;    
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;  
          #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;    
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;  
          #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;    
        #1 clk = 1'b0; 
        #1 clk = 1'b1; 
        #1 clk = 1'b0; 
        #1 clk = 1'b1;  
    end
endmodule