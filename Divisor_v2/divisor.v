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

    wire loadInitial;
    //cuando el contador sea cero va a cargar los 
    // estados iniciales de los registros.
    nor (loadInitial,count[0],count[1],count[2]
         ,count[3],count[4],count[5]);
    
    // ----------- SHIFT REGISTERS --------------
    wire[31:0] remainderFlex;
    //carga del divisor con los bits invertidos 
    shiftRegister_32b RegQuotient({dend[30:0],shiftIn}, shiftIn, loadInitial, countClk,r,quotient);
    shiftRegister_32b1 RegRemainder({resta[30:0],in},in,shiftIn,countClk,r,remainderFlex);
    wire in;
    mux mm1(dend[31],quotient[31],loadInitial,in);
    //el shift in del shifit register del cociente, sera el inverso del ultimo
    // bit de la resta, asi si el resultado es negativo se ingresa un 0, y si 
    // es positivo se ingresa un uno
    wire shiftIn;
    not (shiftIn,resta[31]);
    //------registro para el resto---------------
    wire clkReg,passClk2;
    // el registro cambia cuando es positiva la resta
    and (notCount32,count[5],count[1]);
    and (clkReg,countClk,shiftIn);

    register_32b registerQ(resta,clkReg,r,remainder);
    //----------- Resta -------------------------
    wire [31:0] resta; //ver si 1 es para resta
    resta32bits restar(remainderFlex,dsor,1'b1, resta);

endmodule




