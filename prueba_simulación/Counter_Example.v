//----------Contador de 8 bits------------------------
module counter(input clock1, output reg [31:0] count);
//reg clock;

    initial
        count = 32'd0;
    
    always@(posedge clock1)
        count = count + 32'd4;
          
endmodule

module dLatch(input clk, in, output reg out);

    always@(posedge clk) begin
      out = in;
    end
endmodule


module testbench();

    always
        #10
        clk = ~clk;

    initial
        clk = 0;
    
    reg clk,in;
    wire out;
    output [31:0] salida;


    initial begin

        $monitor("salida = %d",salida);
        $monitor("in = %d out = %d",in,out);

    end

    initial
        #100
        $finish;
    
    initial begin
        #10
        in = 1'd1;
        #5 in = 1'd0;
        #2 in = 1'd1;
        #0 in = 1'd0;
        
    end

    counter c1(clk,salida);
    dLatch  d1(clk,in,out);


endmodule