module divisor32b(input[31:0] divisor, dividend, input clk, output [31:0] quotient, remainder);

    reg [5:0] count;
    reg [32:0] sub;
    reg [32:0] remainderTemp;
    reg [31:0] quotientTemp;
    

    assign sub = remainderTemp - divisor;

    always@(posedge clk) begin
        //incrementa el contador
        count <= count +1;

        if(sub[32]) begin

            

        end





    end





endmodule