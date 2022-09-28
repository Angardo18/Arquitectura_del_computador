module shiftRegister_16b(input [15:0] value, input in, load, clk,r,output [15:0] Q);
    wire [15:0]d;
    wire q0;
    /*wire clk;
    or (clk,clock,load);
    *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux m1(value[15],in,load,d[15]);
    mux m2(value[14],Q[15],load,d[14]);
    mux m3(value[13],Q[14],load,d[13]);
    mux m4(value[12],Q[13],load,d[12]);
    mux m5(value[11],Q[12],load,d[11]);
    mux m6(value[10],Q[11],load,d[10]);
    mux m7(value[9],Q[10],load,d[9]);
    mux m8(value[8],Q[9],load,d[8]);
    mux m9(value[7],Q[8],load,d[7]);
    mux m10(value[6],Q[7],load,d[6]);
    mux m11(value[5],Q[6],load,d[5]);
    mux m12(value[4],Q[5],load,d[4]);
    mux m13(value[3],Q[4],load,d[3]);
    mux m14(value[2],Q[3],load,d[2]);
    mux m15(value[1],Q[2],load,d[1]);
    mux m16(value[0],Q[1],load,d[0]);
    //mux m17(value[0],q0,load,Q[0]);
    //mux m17()
    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop ff1(d[15],clk,r,Q[15]);
    dFlipFlop ff2(d[14],clk,r,Q[14]);
    dFlipFlop ff3(d[13],clk,r,Q[13]);
    dFlipFlop ff4(d[12],clk,r,Q[12]);
    dFlipFlop ff5(d[11],clk,r,Q[11]);
    dFlipFlop ff6(d[10],clk,r,Q[10]);
    dFlipFlop ff7(d[9],clk,r,Q[9]);
    dFlipFlop ff8(d[8],clk,r,Q[8]);
    dFlipFlop ff9(d[7],clk,r,Q[7]);
    dFlipFlop ff10(d[6],clk,r,Q[6]);
    dFlipFlop ff11(d[5],clk,r,Q[5]);
    dFlipFlop ff12(d[4],clk,r,Q[4]);
    dFlipFlop ff13(d[3],clk,r,Q[3]);
    dFlipFlop ff14(d[2],clk,r,Q[2]);
    dFlipFlop ff15(d[1],clk,r,Q[1]);
    dFlipFlop ff16(d[0],clk,r,Q[0]);
endmodule

module mux(input d1,d0,s, output out);

       wire [3:0] w;
       not (w[0],s);

       and (w[1],d0,w[0]);
       and (w[2],d1,s);

       or (out,w[1],w[2]);
endmodule


module dFlipFlop(input d, clock,reset,output out);

    wire[4:0] n;
    not (r,reset);
    not (clk,clock);
    //-------- LATCH SR 1 -----
    nand (n[0],n[3],n[1]);
    nand (n[1],clk,n[0],r);
    //------- LATCH SR 2 -------
    nand (n[2],n[1],clk,n[3]);
    nand (n[3],d,n[2],r);
    //------- LATCH SR 3 -------
    nand (out,n[1],n[4]);
    nand (n[4],n[2],out,r);

endmodule

/*module dFlipFlop(input d, clk,r,output out);

    wire[4:0] n;

    //-------- LATCH SR 1 -----
    nand (n[0],n[3],n[1]);
    nand (n[1],clk,n[0],r);
    //------- LATCH SR 2 -------
    nand (n[2],n[1],clk,n[3]);
    nand (n[3],d,n[2],r);
    //------- LATCH SR 3 -------
    nand (out,n[1],n[4]);
    nand (n[4],n[2],out,r);

endmodule
*/



// module shift(input [3:0] value, input in, load, clk, output [3:0] Q);
//     wire [3:0]d;
//     /*wire clk;
//     or (clk,clock,load);
//     *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
//     mux m1(value[3],in,load,d[3]);
//     mux m2(value[2],Q[3],load,d[2]);
//     mux m3(value[1],Q[2],load,d[1]);
//     mux m4(value[0],Q[1],load,d[0]);
//     //--------- FLIP FLOPS D -----------------------------
//     dFlipFlop ff1(d[3]  ,clk,Q[3]);
//     dFlipFlop ff2(d[2],clk,Q[2]);
//     dFlipFlop ff3(d[1],clk,Q[1]);
//     dFlipFlop ff4(d[0],clk,Q[0]);
// endmodule


