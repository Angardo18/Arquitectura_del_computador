`include "buffer.v"
`include "aritmethic.v"
`include "memory.v"
//`include "mux.v"
module test();

wire [31:0] q;
wire [31:0] R;


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
        b=108;
        a=31 ;        
        #1 r=1;
        #1 r=0;
        
        $monitor("%d/%d=%d %d",b,a,q,R);

        #700 a=108;
        #2000 $finish;
    end
  
    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0,test);
    end

endmodule

module divisor(input [31:0] dsor, dend, input clk,reset ,output[31:0] quotient, output[31:0] remainder);

    //------------------- COUNTER --------------
    wire [5:0]count;
    wire [5:0]d;
    wire countClk;
    wire resetCount;

    or (resetCount,reset,r);

    and (countClk,clk,passClk);

    not (d[0],count[0]);
    not (d[1],count[1]);
    not (d[2],count[2]);
    not (d[3],count[3]);
    not (d[4],count[4]);
    not (d[5],count[5]);

    dFlipFlop ft1(d[0],countClk,resetCount,count[0]);
    dFlipFlop ft2(d[1],count[0],resetCount,count[1]);
    dFlipFlop ft3(d[2],count[1],resetCount,count[2]);
    dFlipFlop ft4(d[3],count[2],resetCount,count[3]);
    dFlipFlop ft5(d[4],count[3],resetCount,count[4]);
    dFlipFlop ft6(d[5],count[4],resetCount,count[5]);
    //-------------------------------------------
    //---------- condiciones iniciales-----------
    wire passClk;
    nand (passClk,count[5],count[1]); //cuando llegue a 33
    and  (r,count[5],count[0]);
    wire loadInitial;
    //cuando el contador sea cero va a cargar los 
    // estados iniciales de los registros.
    nor (loadInitial,count[0],count[1],count[2]
         ,count[3],count[4],count[5]);

    // ----------- SHIFT REGISTERS --------------
    wire[31:0] remainderFlex,quotientTemp;
    //carga del divisor con los bits invertidos 
    shiftRegister_32b RegQuotient({dend[30:0],shiftIn}, shiftIn, loadInitial, countClk,r,quotientTemp);
    shiftRegister_32b1 RegRemainder({resta[30:0],in},in,shiftIn,countClk,r,remainderFlex);
    wire in;
    mux mm1(dend[31],quotientTemp[31],loadInitial,in);
    //el shift in del shifit register del cociente, sera el inverso del ultimo
    // bit de la resta, asi si el resultado es negativo se ingresa un 0, y si 
    // es positivo se ingresa un uno
    wire shiftIn;
    not (shiftIn,resta[31]);
    //------registro para el resto---------------
    wire clkReg,passClk2;
    // el registro cambia cuando es positiva la resta
    and (clkReg,countClk,shiftIn);
    wire [31:0] remTemp;
    register_32b registerQ(resta,clkReg,r,remTemp);

    wire outClk;
    nand (outClk,count[5],count[0]);//mientras sean o la salida será 1
    register_32b1 regQuotient(quotientTemp,outClk,1'b0,quotient);
    register_32b2 regRemainder(remTemp,outClk,1'b0,remainder);
    //----------- Resta -------------------------
    wire [31:0] resta; //ver si 1 es para resta
    resta32bits restar(remainderFlex,dsor,1'b1, resta);

endmodule




