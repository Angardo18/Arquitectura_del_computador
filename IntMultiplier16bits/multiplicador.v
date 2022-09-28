`include "shift.v"

module test();

    reg clk;
    reg r;
    reg [15:0] a,b;
    wire [5:0] hola;
    wire [31:0] result;

    multiplier mult(a,b,clk,r,result,hola);    

    initial begin
        clk = 0;
        a=16'd10;
        b=16'd12;
        $display("a     |  b  |   result");
        $display("------------------------");
//        $monitor($time,"%d | %d | %d",a,b,result[31:16], result[15:0]);
        $monitor($time,"%d | %d | %d | %b",a,b,result,hola);
    end

    always
        #5 clk = ~clk;

    initial begin
        r=1;
        #1 r=0;
        #2000 $finish;
    end
    initial begin
        $dumpfile("mult.vcd");
        $dumpvars(0,test);
    end

endmodule


module multiplier(input [15:0] a,b,input clk,r,output [31:0] result, output [5:0] count);

/*Para indicar cuando se termina de realizar la multiplicacion*/
//------------ CONTADOR DE PULSOS -----------------------
//wire [5:0]count;
wire [5:0]d;
wire countClk;

and (countClk,clk,passClk);


not (d[0],count[0]);
not (d[1],count[1]);
not (d[2],count[2]);
not (d[3],count[3]);
not (d[4],count[4]);
not (d[5],count[5]);

dFlipFlop ft1(d[0],countClk,r,count[0]);
dFlipFlop ft2(d[1],count[0],r,count[1]);
dFlipFlop ft3(d[2],count[1],r,count[2]);
dFlipFlop ft4(d[3],count[2],r,count[3]);
dFlipFlop ft5(d[4],count[3],r,count[4]);
dFlipFlop ft6(d[5],count[4],r,count[5]);
//----------------------------------------------------------
//----------------- REGISTROS ------------------------------
//solo cuando todos sean 0 loadL será 1.
wire loadL;
nor (loadL,count[0],count[1],count[2]
         ,count[3],count[4],count[5]);  

// DECODE clk
wire passClk;
wire shiftClk;
wire [2:0] w;
nand (passClk,count[4],count[0]);

/*
and (w[0],w[1],result[0]);

not (w[1],count[0]);

or  (w[2],w[0],w[1]);

and (shiftClk,w[2],passClk,clk);

*/

wire shiftIn;
and (shiftIn,result[0],cOut);

wire dInL;
mux mx1(suma[0],result[16],result[0],dInL);

//si result[0] es 0 no se carga la suma
shiftRegister_16b resH({shiftIn,suma[15:1]},shiftIn,result[0],countClk,r,result[31:16]);
shiftRegister_16b resL(b,dInL,loadL,countClk,r,result[15:0]);
//----------------- SUMADODOR --------------------------------
wire cOut;
wire [15:0] suma;
Ripple16bit sumador(suma,cOut,result[31:16],a,1'b0);
endmodule

module Ripple16bit(output [15:0]s, output c, input [15:0]a, input [15:0] b, input cIn);

    wire [31:0] carry;
    Full_adder fa0(.a(a[0]), .b(b[0]), .cin(cIn), .s(s[0]), .cout(carry[0]));
    Full_adder fa1(.a(a[1]), .b(b[1]), .cin(carry[0]), .s(s[1]), .cout(carry[1]));    
    Full_adder fa2(.a(a[2]), .b(b[2]), .cin(carry[1]), .s(s[2]), .cout(carry[2]));  
    Full_adder fa3(.a(a[3]), .b(b[3]), .cin(carry[2]), .s(s[3]), .cout(carry[3]));
    Full_adder fa4(.a(a[4]), .b(b[4]), .cin(carry[3]), .s(s[4]), .cout(carry[4]));
    Full_adder fa5(.a(a[5]), .b(b[5]), .cin(carry[4]), .s(s[5]), .cout(carry[5]));
    Full_adder fa6(.a(a[6]), .b(b[6]), .cin(carry[5]), .s(s[6]), .cout(carry[6]));
    Full_adder fa7(.a(a[7]), .b(b[7]), .cin(carry[6]), .s(s[7]), .cout(carry[7]));
    Full_adder fa8(.a(a[8]), .b(b[8]), .cin(carry[7]), .s(s[8]), .cout(carry[8]));
    Full_adder fa9(.a(a[9]), .b(b[9]), .cin(carry[8]), .s(s[9]), .cout(carry[9]));
    Full_adder fa10(.a(a[10]), .b(b[10]), .cin(carry[9]), .s(s[10]), .cout(carry[10]));
    Full_adder fa11(.a(a[11]), .b(b[11]), .cin(carry[10]), .s(s[11]), .cout(carry[11]));   
    Full_adder fa12(.a(a[12]), .b(b[12]), .cin(carry[11]), .s(s[12]), .cout(carry[12]));
    Full_adder fa13(.a(a[13]), .b(b[13]), .cin(carry[12]), .s(s[13]), .cout(carry[13]));   
    Full_adder fa14(.a(a[14]), .b(b[14]), .cin(carry[13]), .s(s[14]), .cout(carry[14]));
    Full_adder fa15(.a(a[15]), .b(b[15]), .cin(carry[14]), .s(s[15]), .cout(c));   

endmodule

module Full_adder(output s, output cout, input a, input b, input cin);
    wire C1,C2,C3;
    
    xor  (C1,a,b);
    xor  (s,C1,cin);
    and  (C3,a,b);     
    and  (C2,C1,cin); 
    or  (cout,C2,C3); 
    
endmodule

