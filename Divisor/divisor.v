`include "shift.v"

module test();

wire [31:0] q;
wire [30:0] R;


reg clk;
reg [31:0] a,b;
reg r;
divisor div(a,b,clk,r,q,R);
//shiftRegister_32b1 RegRemainder(value,1'b0,load,clk,r,out);
//invert invt(p,pinv);

    always
        #5 clk = ~clk;

    initial begin
        clk = 0;
        r =0;
        b=57821254;
        a=5468;        
        #1 r=1;
        #1 r=0;
        
        $monitor("%d/%d=%d %d",b,a,q,R);


        #500 $finish;
    end
  
    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0,test);
    end

endmodule

module divisor(input [31:0] dsor, dend, input clk, r, output[31:0] quotient, output[30:0] remainder);

    //------------------- COUNTER --------------
    wire [5:0]count;
    wire [5:0]d;
    //wire countClk;

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
    //-------------------------------------------
    //---------- condiciones iniciales-----------
    wire passClk;
    nand (passClk,count[5],count[0]); //cuando llegue a 33
    
    //el clk del shift del resto solo hace funciona hasta un 32, luego
    // ya no sigue funcionando.
    //wire remainderClk;
    //wire nCount5;
    //not (nCount5,count[5]);
    //and (remainderClk,clk,nCount5);

    wire loadInitial;
    //cuando el contador sea cero va a cargar los 
    // estados iniciales de los registros.
    nor (loadInitial,count[0],count[1],count[2]
         ,count[3],count[4],count[5]);

    // ----------- SHIFT REGISTERS --------------
    
    // invertir el orden de los datos
    wire [31:0] dendInv;
    invert invert1(dend,dendInv);

    wire[31:0] quotientInv;
    invert invert2(quotientInv,quotient);

    wire[31:0] remainderInv;
    wire notUsed;
    invert invert3(remainderInv,{remainder,notUsed});

    wire[31:0] restaInv;
    invert invert4(resta,restaInv);


    //carga del divisor con los bits invertidos 
    shiftRegister_32b RegQuotient({shiftIn,dendInv[31:1]}, shiftIn, loadInitial, countClk,r,quotientInv);
    shiftRegister_32b1 RegRemainder({in,restaInv[31:1]},in,shiftIn,countClk,r,remainderInv);
    
    wire in;
    mux mm1(dendInv[0],quotientInv[0],loadInitial,in);
    
    //el shift in del shifit register del cociente, sera el inverso del ultimo
    // bit de la salida, asi si el resultado es negativo se ingresa un 0, y si 
    // es positivo se ingresa un uno
    wire shiftIn;
    not (shiftIn,resta[31]);

    
    //----------- Resta -------------------------
    wire [31:0] resta; //ver si 1 es para resta
    sumador_resta restar({remainder,notUsed},dsor,1'b1, resta);

endmodule


module sumador_resta(input [31:0] a, b, input op, output [31:0] salida);

       wire [31:0] nb;
       wire [31:0] bin; //entrada b al sumador

       not (nb[0],b[0]);
       not (nb[1],b[1]);
       not (nb[2],b[2]);
       not (nb[3],b[3]);
       not (nb[4],b[4]);
       not (nb[5],b[5]);
       not (nb[6],b[6]);
       not (nb[7],b[7]);
       not (nb[8],b[8]);
       not (nb[9],b[9]);
       not (nb[10],b[10]);
       not (nb[11],b[11]);
       not (nb[12],b[12]);
       not (nb[13],b[13]);
       not (nb[14],b[14]);
       not (nb[15],b[15]);
       not (nb[16],b[16]);
       not (nb[17],b[17]);
       not (nb[18],b[18]);
       not (nb[19],b[19]);
       not (nb[20],b[20]);
       not (nb[21],b[21]);
       not (nb[22],b[22]);
       not (nb[23],b[23]);
       not (nb[24],b[24]);
       not (nb[25],b[25]);
       not (nb[26],b[26]);
       not (nb[27],b[27]);
       not (nb[28],b[28]);
       not (nb[29],b[29]);
       not (nb[30],b[30]);
       not (nb[31],b[31]);

       mux m1(nb[0],b[0],op,bin[0]);
       mux m2(nb[1],b[1],op,bin[1]);
       mux m3(nb[2],b[2],op,bin[2]);
       mux m4(nb[3],b[3],op,bin[3]);
       mux m5(nb[4],b[4],op,bin[4]);
       mux m6(nb[5],b[5],op,bin[5]);
       mux m7(nb[6],b[6],op,bin[6]);
       mux m8(nb[7],b[7],op,bin[7]);
       mux m9(nb[8],b[8],op,bin[8]);
       mux m10(nb[9],b[9],op,bin[9]);
       mux m11(nb[10],b[10],op,bin[10]);
       mux m12(nb[11],b[11],op,bin[11]);
       mux m13(nb[12],b[12],op,bin[12]);
       mux m14(nb[13],b[13],op,bin[13]);
       mux m15(nb[14],b[14],op,bin[14]);
       mux m16(nb[15],b[15],op,bin[15]);
       mux m17(nb[16],b[16],op,bin[16]);
       mux m18(nb[17],b[17],op,bin[17]);
       mux m19(nb[18],b[18],op,bin[18]);
       mux m20(nb[19],b[19],op,bin[19]);
       mux m21(nb[20],b[20],op,bin[20]);
       mux m22(nb[21],b[21],op,bin[21]);
       mux m23(nb[22],b[22],op,bin[22]);
       mux m24(nb[23],b[23],op,bin[23]);
       mux m25(nb[24],b[24],op,bin[24]);
       mux m26(nb[25],b[25],op,bin[25]);
       mux m27(nb[26],b[26],op,bin[26]);
       mux m28(nb[27],b[27],op,bin[27]);
       mux m29(nb[28],b[28],op,bin[28]);
       mux m30(nb[29],b[29],op,bin[29]);
       mux m31(nb[30],b[30],op,bin[30]);
       mux m32(nb[31],b[31],op,bin[31]);

       wire cout;
       Ripple32bit add( salida,cout,a,bin,op);
endmodule

module Full_adder(output s, output cout, input a, input b, input cin);
    wire C1,C2,C3;
    
    xor  (C1,a,b);
    xor  (s,C1,cin);
    and  (C3,a,b);     
    and  (C2,C1,cin); 
    or  (cout,C2,C3); 
    
endmodule

module Ripple32bit(output [31:0]s, output c, input [31:0]a, input [31:0] b, input cIn);

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
    Full_adder fa15(.a(a[15]), .b(b[15]), .cin(carry[14]), .s(s[15]), .cout(carry[15]));   
    Full_adder fa16(.a(a[16]), .b(b[16]), .cin(carry[15]), .s(s[16]), .cout(carry[16]));
    Full_adder fa17(.a(a[17]), .b(b[17]), .cin(carry[16]), .s(s[17]), .cout(carry[17]));    
    Full_adder fa18(.a(a[18]), .b(b[18]), .cin(carry[17]), .s(s[18]), .cout(carry[18]));
    Full_adder fa19(.a(a[19]), .b(b[19]), .cin(carry[18]), .s(s[19]), .cout(carry[19]));    
    Full_adder fa20(.a(a[20]), .b(b[20]), .cin(carry[19]), .s(s[20]), .cout(carry[20]));
    Full_adder fa21(.a(a[21]), .b(b[21]), .cin(carry[20]), .s(s[21]), .cout(carry[21]));    
    Full_adder fa22(.a(a[22]), .b(b[22]), .cin(carry[21]), .s(s[22]), .cout(carry[22]));
    Full_adder fa23(.a(a[23]), .b(b[23]), .cin(carry[22]), .s(s[23]), .cout(carry[23]));    
    Full_adder fa24(.a(a[24]), .b(b[24]), .cin(carry[23]), .s(s[24]), .cout(carry[24]));
    Full_adder fa25(.a(a[25]), .b(b[25]), .cin(carry[24]), .s(s[25]), .cout(carry[25]));    
    Full_adder fa26(.a(a[26]), .b(b[26]), .cin(carry[25]), .s(s[26]), .cout(carry[26]));
    Full_adder fa27(.a(a[27]), .b(b[27]), .cin(carry[26]), .s(s[27]), .cout(carry[27]));   
    Full_adder fa28(.a(a[28]), .b(b[28]), .cin(carry[27]), .s(s[28]), .cout(carry[28]));
    Full_adder fa29(.a(a[29]), .b(b[29]), .cin(carry[28]), .s(s[29]), .cout(carry[29])); 
    Full_adder fa30(.a(a[30]), .b(b[30]), .cin(carry[29]), .s(s[30]), .cout(carry[30]));
    Full_adder fa31(.a(a[31]),  .b(b[31]), .cin(carry[30]), .s(s[31]), .cout(c));

endmodule