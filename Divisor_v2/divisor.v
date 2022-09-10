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


        #500 $finish;
    end
  
    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0,test);
    end

endmodule

module divisor(input [31:0] dsor, dend, input clk, r, output[31:0] quotient, output[31:0] remainder);

    //------------------- COUNTER --------------
    wire [5:0]count;
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
    //wire [31:0] dendInv;
    //invert invert1(dend,dendInv);

    //wire[31:0] quotientInv;
    //invert invert2(quotientInv,quotient);

    //wire[31:0] remainderInv;
    wire[31:0] remainderFlex;
    //wire notUsed;
    //invert invert3(remainderInv,remainderFlex);

    //wire[31:0] restaInv;
    //invert invert4(resta,restaInv);


    //carga del divisor con los bits invertidos 
    shiftRegister_32b RegQuotient({dend[30:0],shiftIn}, shiftIn, loadInitial, countClk,r,quotient);
    shiftRegister_32b1 RegRemainder({resta[30:0],in},in,shiftIn,countClk,r,remainderFlex);
    
    wire in;
    mux mm1(dend[31],quotient[31],loadInitial,in);
    
    //el shift in del shifit register del cociente, sera el inverso del ultimo
    // bit de la salida, asi si el resultado es negativo se ingresa un 0, y si 
    // es positivo se ingresa un uno
    wire shiftIn;
    not (shiftIn,resta[31]);
    //------registro para el resto---------------

    wire clkReg,passClk2;
    
    and (notCount32,count[5],count[1]);
    and (clkReg,countClk,shiftIn);


    dFlipFlop fb0(resta[0],clkReg,r,remainder[0]);
    dFlipFlop fb1(resta[1],clkReg,r,remainder[1]);
    dFlipFlop fb2(resta[2],clkReg,r,remainder[2]);
    dFlipFlop fb3(resta[3],clkReg,r,remainder[3]);
    dFlipFlop fb4(resta[4],clkReg,r,remainder[4]);
    dFlipFlop fb5(resta[5],clkReg,r,remainder[5]);
    dFlipFlop fb6(resta[6],clkReg,r,remainder[6]);
    dFlipFlop fb7(resta[7],clkReg,r,remainder[7]);
    dFlipFlop fb8(resta[8],clkReg,r,remainder[8]);
    dFlipFlop fb9(resta[9],clkReg,r,remainder[9]);
    dFlipFlop fb10(resta[10],clkReg,r,remainder[10]);
    dFlipFlop fb11(resta[11],clkReg,r,remainder[11]);
    dFlipFlop fb12(resta[12],clkReg,r,remainder[12]);
    dFlipFlop fb13(resta[13],clkReg,r,remainder[13]);
    dFlipFlop fb14(resta[14],clkReg,r,remainder[14]);
    dFlipFlop fb15(resta[15],clkReg,r,remainder[15]);
    dFlipFlop fb16(resta[16],clkReg,r,remainder[16]);
    dFlipFlop fb17(resta[17],clkReg,r,remainder[17]);
    dFlipFlop fb18(resta[18],clkReg,r,remainder[18]);
    dFlipFlop fb19(resta[19],clkReg,r,remainder[19]);
    dFlipFlop fb20(resta[20],clkReg,r,remainder[20]);
    dFlipFlop fb21(resta[21],clkReg,r,remainder[21]);
    dFlipFlop fb22(resta[22],clkReg,r,remainder[22]);
    dFlipFlop fb23(resta[23],clkReg,r,remainder[23]);
    dFlipFlop fb24(resta[24],clkReg,r,remainder[24]);
    dFlipFlop fb25(resta[25],clkReg,r,remainder[25]);
    dFlipFlop fb26(resta[26],clkReg,r,remainder[26]);
    dFlipFlop fb27(resta[27],clkReg,r,remainder[27]);
    dFlipFlop fb28(resta[28],clkReg,r,remainder[28]);
    dFlipFlop fb29(resta[29],clkReg,r,remainder[29]);
    dFlipFlop fb30(resta[30],clkReg,r,remainder[30]);
    dFlipFlop fb31(resta[31],clkReg,r,remainder[31]);
    //----------- Resta -------------------------
    wire [31:0] resta; //ver si 1 es para resta
    resta32bits restar(remainderFlex,dsor,1'b1, resta);

endmodule




