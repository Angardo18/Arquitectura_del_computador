
module test();

    reg [31:0] div,den;
    reg clk;
    wire [31:0] q,r;


    divisor32b divsr(div,den,clk,q,r);

    always
        #5 clk = ~clk;

    initial begin
        clk = 0;
        den =13;
        div = 3;
        $monitor("%d%d = %d %d",den,div,q,r);
        #900 $finish;
    end

    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0,test);
    end

endmodule




module divisor32b(input[31:0] divisor, dividend, input clk, output reg [31:0] quotient, remainder);

    reg [5:0] count;
    reg [32:0] sub;
    reg [31:0] remainderTemp;
    reg [31:0] quotientTemp;
    reg [31:0] divisorTemp;
    reg aux;
    //assign sub = {1'b0,remainderTemp[31:0]} - {1'b0,divisorTemp};

    initial
        count  = 0;

    always@(posedge clk) begin
        //incrementa el contador
        count = count +1;        
        if(count==1) begin 
            remainderTemp=6'd0;
            quotientTemp = dividend;
            divisorTemp = divisor;
        end

        else if(count==6'd34) begin
            count = 0;
            quotient = quotientTemp;
            remainder = remainderTemp[32:1];
        end


        sub  = {1'b0,remainderTemp} - {1'b0,divisorTemp};
        //si la resta da positivo entonces se asigna
        aux = 
        if(~sub[32]) remainderTemp[31:0] = sub[31:0];
        remainderTemp = remainderTemp<<1 | {32'b0,quotientTemp[31]} ;
        //remainderTemp[0] = quotientTemp[31];
        
        quotientTemp = quotientTemp <<1 | {31'd0,~sub[32]};
        //if( sub>=0 ) quotientTemp = quotientTemp<<1  | 32'd1;
        //else quotientTemp = quotientTemp<<1|32'd0;

    end
endmodule