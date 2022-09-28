`include "buffer.v"
`include "aritmethic.v"
`include "memory.v"
//`include "mux.v"
module test();

wire [31:0] q;
wire [31:0] R;
wire [31:0] rem,quo;
wire [5:0] c;
reg clk;
reg [31:0] a,b;
reg r;
reg[31:0] i,j;
divisor div(a,b,clk,r,q,R);
//shiftRegister_32b1 RegRemainder(value,1'b0,load,clk,r,out);
//invert invt(p,pinv);

    always
        #2 clk = ~clk;

    initial begin
        clk = 0;
        r =0;
        b=136;
        a=4;
        //b=32'b00000001000010000000000011111111;
        //a=32'b0000000000000001000000001000010;        
        #1 r=1;
        #1 r=0;
        

        $monitor("%d/%d=%d %d",b,a,q,R);

        #2000 $finish;
    end
    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0,test);
    end

endmodule

module divisor(input [31:0] dsor, dend, input clk,reset ,output[31:0]quotient,remainder);

    //------------------- COUNTER --------------
    wire [5:0]count;
    wire [5:0]d;

    wire resetCount;
    or (resetCount,reset,r);

    not (d[0],count[0]);
    not (d[1],count[1]);
    not (d[2],count[2]);
    not (d[3],count[3]);
    not (d[4],count[4]);
    not (d[5],count[5]);

    dFlipFlop ft1(d[0],clk,resetCount,count[0]);
    dFlipFlop ft2(d[1],count[0],resetCount,count[1]);
    dFlipFlop ft3(d[2],count[1],resetCount,count[2]);
    dFlipFlop ft4(d[3],count[2],resetCount,count[3]);
    dFlipFlop ft5(d[4],count[3],resetCount,count[4]);
    dFlipFlop ft6(d[5],count[4],resetCount,count[5]);
    //-------------------------------------------
    //---------- condiciones iniciales-----------
    wire passClk;
    nand (passClk,count[5],count[0]); //cuando llegue a 33
    and  (r,count[5],count[0]);
    wire loadInitial;
    //cuando el contador sea cero va a cargar los 
    // estados iniciales de los registros.
    nor (loadInitial,count[0],count[1],count[2]
         ,count[3],count[4],count[5]);

    // ----------- SHIFT REGISTERS --------------
    wire[31:0]quotientTemp;
    //carga del divisor con los bits invertidos 
    shiftRegister_32b RegQuotient({dend[30:0],shiftIn}, shiftIn, loadInitial, clk,r,quotientTemp);
    shiftRegister_32b1 RegRemainder({resta[30:0],in},in,shiftIn,clk,r,remTemp);
    wire in;
    mux mm1(dend[31],quotientTemp[31],loadInitial,in);
    //el shift in del shifit register del cociente, sera el acarreo de la salida
    // asi si el resultado es negativo se ingresa un 0, y si 
    // es positivo se ingresa un uno
    wire shiftIn;
    //not (shiftIn,resta[31]);
    //------registro para el resto---------------

    wire [31:0] remTemp;
    wire outClk;
    nand (outClk,count[5],count[0]);//mientras sean o la salida será 1
    register_32b1 regQuotient(quotientTemp,outClk,1'b0,quotient);
    register_32b2 regRemainder({lastBit,remTemp[31:1]},outClk,1'b0,remainder);
    //se guarda el ultimo bit que sale al hacer shift del resto
    wire lastBit;
    mux mm2(resta[31],remTemp[31],shiftIn,lastBit);
    //----------- Resta -------------------------
    wire [31:0] resta; //ver si 1 es para resta
    //wire cout; //verificar si el resultado es positivo o negativo.
    resta32bits restar(remTemp,dsor,1'b1, resta,shiftIn);

endmodule




