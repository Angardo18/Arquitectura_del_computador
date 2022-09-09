module shiftRegister_16b(input [15:0] value1, input in, load, clk,re,output [15:0] Q);
    wire [15:0]d1;
    wire q0;
    /*wire clk;
    or (clk,clock,load);
    *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux m1(value1[15],in,load,d1[15]);
    mux m2(value1[14],Q[15],load,d1[14]);
    mux m3(value1[13],Q[14],load,d1[13]);
    mux m4(value1[12],Q[13],load,d1[12]);
    mux m5(value1[11],Q[12],load,d1[11]);
    mux m6(value1[10],Q[11],load,d1[10]);
    mux m7(value1[9],Q[10],load,d1[9]);
    mux m8(value1[8],Q[9],load,d1[8]);
    mux m9(value1[7],Q[8],load,d1[7]);
    mux m10(value1[6],Q[7],load,d1[6]);
    mux m11(value1[5],Q[6],load,d1[5]);
    mux m12(value1[4],Q[5],load,d1[4]);
    mux m13(value1[3],Q[4],load,d1[3]);
    mux m14(value1[2],Q[3],load,d1[2]);
    mux m15(value1[1],Q[2],load,d1[1]);
    mux m16(value1[0],Q[1],load,d1[0]);
    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop ff1(d1[15],clk,re,Q[15]);
    dFlipFlop ff2(d1[14],clk,re,Q[14]);
    dFlipFlop ff3(d1[13],clk,re,Q[13]);
    dFlipFlop ff4(d1[12],clk,re,Q[12]);
    dFlipFlop ff5(d1[11],clk,re,Q[11]);
    dFlipFlop ff6(d1[10],clk,re,Q[10]);
    dFlipFlop ff7(d1[9],clk,re,Q[9]);
    dFlipFlop ff8(d1[8],clk,re,Q[8]);
    dFlipFlop ff9(d1[7],clk,re,Q[7]);
    dFlipFlop ff10(d1[6],clk,re,Q[6]);
    dFlipFlop ff11(d1[5],clk,re,Q[5]);
    dFlipFlop ff12(d1[4],clk,re,Q[4]);
    dFlipFlop ff13(d1[3],clk,re,Q[3]);
    dFlipFlop ff14(d1[2],clk,re,Q[2]);
    dFlipFlop ff15(d1[1],clk,re,Q[1]);
    dFlipFlop ff16(d1[0],clk,re,Q[0]);
endmodule
module shiftRegister_16b1(input [15:0] value, input in, load1, clk,res,output [15:0] Q1);
    wire [15:0]d;
    wire q0;
    ///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux n1(value[15],in,load1,d[15]);
    mux n2(value[14],Q1[15],load1,d[14]);
    mux n3(value[13],Q1[14],load1,d[13]);
    mux n4(value[12],Q1[13],load1,d[12]);
    mux n5(value[11],Q1[12],load1,d[11]);
    mux n6(value[10],Q1[11],load1,d[10]);
    mux n7(value[9],Q1[10],load1,d[9]);
    mux n8(value[8],Q1[9],load1,d[8]);
    mux n9(value[7],Q1[8],load1,d[7]);
    mux n10(value[6],Q1[7],load1,d[6]);
    mux n11(value[5],Q1[6],load1,d[5]);
    mux n12(value[4],Q1[5],load1,d[4]);
    mux n13(value[3],Q1[4],load1,d[3]);
    mux n14(value[2],Q1[3],load1,d[2]);
    mux n15(value[1],Q1[2],load1,d[1]);
    mux n16(value[0],Q1[1],load1,d[0]);
    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop fff1(d[15],clk,res,Q1[15]);
    dFlipFlop fff2(d[14],clk,res,Q1[14]);
    dFlipFlop fff3(d[13],clk,res,Q1[13]);
    dFlipFlop fff4(d[12],clk,res,Q1[12]);
    dFlipFlop fff5(d[11],clk,res,Q1[11]);
    dFlipFlop fff6(d[10],clk,res,Q1[10]);
    dFlipFlop fff7(d[9],clk,res,Q1[9]);
    dFlipFlop fff8(d[8],clk,res,Q1[8]);
    dFlipFlop fff9(d[7],clk,res,Q1[7]);
    dFlipFlop fff10(d[6],clk,res,Q1[6]);
    dFlipFlop fff11(d[5],clk,res,Q1[5]);
    dFlipFlop fff12(d[4],clk,res,Q1[4]);
    dFlipFlop fff13(d[3],clk,res,Q1[3]);
    dFlipFlop fff14(d[2],clk,res,Q1[2]);
    dFlipFlop fff15(d[1],clk,res,Q1[1]);
    dFlipFlop fff16(d[0],clk,res,Q1[0]);
endmodule
module mux(input d1,d0,s, output out);

       wire [3:0] w;
       not (w[0],s);

       and (w[1],d0,w[0]);
       and (w[2],d1,s);

       or (out,w[1],w[2]);
endmodule

module dFlipFlop(input d, clock,reset,output reg out);
         always@(negedge clock, posedge reset) begin
            if(reset) out <= 0;
            else out <= d;
         end
endmodule
/*
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

endmodule        */

