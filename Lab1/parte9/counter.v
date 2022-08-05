/*module counter(input clk, reset, output reg [7:0] out);

    always@(posedge clk or posedge reset) begin

        if (reset)
            out = 5;
        else
            if(out <67)
                out = out+1;

    end
endmodule



module tb();

    wire [7:0] count;
    reg clk;
    reg reset;
   
    counter cont(clk,reset,count);

    initial begin
        $monitor($time," contador=%d clk=%b", count,clk);
        reset = 1'b1;
        clk = 1'b1;
        #7 reset = 1'b0;
        #1250 $finish;
    end

    always
        #5 clk = ~clk;

    


endmodule*/

module counter();
    reg clk;
    reg [7:0] count;

    initial begin
        $monitor("clk=%b count=%d %t",clk,count,$time);
        count = 4'd5;
        clk = 1'b0;
    end 



    initial begin
        forever begin
            if(count > 66) disable block;
            #5 clk = ~clk; 
        end
    end


    always@(posedge clk) begin
       
        begin:block
            if(count > 66) disable block;
            count = count +1;
        end
    end

    initial begin
        forever begin
            
            #5 clk = ~clk; 
        end
    end        
endmodule