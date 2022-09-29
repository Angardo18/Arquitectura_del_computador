module FPadder32b(input [31:0] a,b, input clk, output reg[31:0] sum);
    //si es 1 hay que restar y si es 0 sumar
    wire sumarRestar;

    reg[31]

    xor (sumarRestar,a[31],b[31]);



    always@(posedge clk) begin
      

    end
    

endmodule