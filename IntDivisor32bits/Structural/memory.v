`include "mux.v"
/*
module testB();

    reg clk,load,r;
    reg [31:0] in,in2;
    wire [31:0] out,out2;

    mux mm1(in2[31],out[31],load,shiftIn);

    shiftRegister_32b1 a({in[30:0],1'b1},1'b0,load,clk,r,out);
    shiftRegister_32b a1({in2[30:0],shiftIn},shiftIn,load,clk,r,out2);
    always
        #5 clk = ~clk;

    initial begin
        clk=0;r=1;in=1;load=1;in2=2;in[30]=1;
        #1 r=0;
        #12 load=0;
        $monitor("%b %b",out2,out);
        #100  in = 3; load=1;
        #10 load=0;
        #100 $finish;

    end


endmodule
*/
module dFlipFlop(input d, clk, reset, output reg out);

    always@(negedge clk, posedge reset) begin
        if (reset) out <= 0;
        else out<= d;
    end

endmodule
module shiftRegister_32b(input [31:0] value, input in, load, clk,r,output [0:31] Q);
    wire [31:0]d;
    wire q0;
    /*wire clk;
    or (clk,clock,load);
    *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux m31 (value[31],Q[1],load,d[0]);
    mux m30 (value[30],Q[2],load,d[1]);
    mux m29 (value[29],Q[3],load,d[2]);
    mux m28 (value[28],Q[4],load,d[3]);
    mux m27 (value[27],Q[5],load,d[4]);
    mux m26 (value[26],Q[6],load,d[5]);
    mux m25 (value[25],Q[7],load,d[6]);
    mux m24 (value[24],Q[8],load,d[7]);
    mux m23 (value[23],Q[9],load,d[8]);
    mux m22 (value[22],Q[10],load,d[9]);
    mux m21 (value[21],Q[11],load,d[10]);
    mux m20 (value[20],Q[12],load,d[11]);
    mux m19 (value[19],Q[13],load,d[12]);
    mux m18 (value[18],Q[14],load,d[13]);
    mux m17 (value[17],Q[15],load,d[14]);
    mux m16 (value[16],Q[16],load,d[15]);
    mux m15 (value[15],Q[17],load,d[16]);
    mux m14 (value[14],Q[18],load,d[17]);
    mux m13 (value[13],Q[19],load,d[18]);
    mux m12 (value[12],Q[20],load,d[19]);
    mux m11 (value[11],Q[21],load,d[20]);
    mux m10 (value[10],Q[22],load,d[21]);
    mux m9 (value[9],Q[23],load,d[22]);
    mux m8 (value[8],Q[24],load,d[23]);
    mux m7 (value[7],Q[25],load,d[24]);
    mux m6 (value[6],Q[26],load,d[25]);
    mux m5 (value[5],Q[27],load,d[26]);
    mux m4 (value[4],Q[28],load,d[27]);
    mux m3 (value[3],Q[29],load,d[28]);
    mux m2 (value[2],Q[30],load,d[29]);
    mux m1 (value[1],Q[31],load,d[30]);
    mux m0 (value[0],in,load,d[31]);    

    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop ff31(d[0],clk,r,Q[0]);
    dFlipFlop ff30(d[1],clk,r,Q[1]);
    dFlipFlop ff29(d[2],clk,r,Q[2]);
    dFlipFlop ff28(d[3],clk,r,Q[3]);
    dFlipFlop ff27(d[4],clk,r,Q[4]);
    dFlipFlop ff26(d[5],clk,r,Q[5]);
    dFlipFlop ff25(d[6],clk,r,Q[6]);
    dFlipFlop ff24(d[7],clk,r,Q[7]);
    dFlipFlop ff23(d[8],clk,r,Q[8]);
    dFlipFlop ff22(d[9],clk,r,Q[9]);
    dFlipFlop ff21(d[10],clk,r,Q[10]);
    dFlipFlop ff20(d[11],clk,r,Q[11]);
    dFlipFlop ff19(d[12],clk,r,Q[12]);
    dFlipFlop ff18(d[13],clk,r,Q[13]);
    dFlipFlop ff17(d[14],clk,r,Q[14]);
    dFlipFlop ff16(d[15],clk,r,Q[15]);
    dFlipFlop ff15(d[16],clk,r,Q[16]);
    dFlipFlop ff14(d[17],clk,r,Q[17]);
    dFlipFlop ff13(d[18],clk,r,Q[18]);
    dFlipFlop ff12(d[19],clk,r,Q[19]);
    dFlipFlop ff11(d[20],clk,r,Q[20]);
    dFlipFlop ff10(d[21],clk,r,Q[21]);
    dFlipFlop ff9(d[22],clk,r,Q[22]);
    dFlipFlop ff8(d[23],clk,r,Q[23]);
    dFlipFlop ff7(d[24],clk,r,Q[24]);
    dFlipFlop ff6(d[25],clk,r,Q[25]);
    dFlipFlop ff5(d[26],clk,r,Q[26]);
    dFlipFlop ff4(d[27],clk,r,Q[27]);
    dFlipFlop ff3(d[28],clk,r,Q[28]);
    dFlipFlop ff2(d[29],clk,r,Q[29]);
    dFlipFlop ff1(d[30],clk,r,Q[30]);
    dFlipFlop ff0(d[31],clk,r,Q[31]);
endmodule
module shiftRegister_32b1(input [31:0] value, input in, load, clk,r,output [0:31] Q);
    wire [31:0]d;
    
    /*wire clk;
    or (clk,clock,load);
    *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux n31 (value[31],Q[1],load,d[0]);
    mux n30 (value[30],Q[2],load,d[1]);
    mux n29 (value[29],Q[3],load,d[2]);
    mux n28 (value[28],Q[4],load,d[3]);
    mux n27 (value[27],Q[5],load,d[4]);
    mux n26 (value[26],Q[6],load,d[5]);
    mux n25 (value[25],Q[7],load,d[6]);
    mux n24 (value[24],Q[8],load,d[7]);
    mux n23 (value[23],Q[9],load,d[8]);
    mux n22 (value[22],Q[10],load,d[9]);
    mux n21 (value[21],Q[11],load,d[10]);
    mux n20 (value[20],Q[12],load,d[11]);
    mux n19 (value[19],Q[13],load,d[12]);
    mux n18 (value[18],Q[14],load,d[13]);
    mux n17 (value[17],Q[15],load,d[14]);
    mux n16 (value[16],Q[16],load,d[15]);
    mux n15 (value[15],Q[17],load,d[16]);
    mux n14 (value[14],Q[18],load,d[17]);
    mux n13 (value[13],Q[19],load,d[18]);
    mux n12 (value[12],Q[20],load,d[19]);
    mux n11 (value[11],Q[21],load,d[20]);
    mux n10 (value[10],Q[22],load,d[21]);
    mux n9 (value[9],Q[23],load,d[22]);
    mux n8 (value[8],Q[24],load,d[23]);
    mux n7 (value[7],Q[25],load,d[24]);
    mux n6 (value[6],Q[26],load,d[25]);
    mux n5 (value[5],Q[27],load,d[26]);
    mux n4 (value[4],Q[28],load,d[27]);
    mux n3 (value[3],Q[29],load,d[28]);
    mux n2 (value[2],Q[30],load,d[29]);
    mux n1 (value[1],Q[31],load,d[30]);
    mux n0 (value[0],in,load,d[31]);
    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop ffd31(d[0],clk,r,Q[0]);
    dFlipFlop ffd30(d[1],clk,r,Q[1]);
    dFlipFlop ffd29(d[2],clk,r,Q[2]);
    dFlipFlop ffd28(d[3],clk,r,Q[3]);
    dFlipFlop ffd27(d[4],clk,r,Q[4]);
    dFlipFlop ffd26(d[5],clk,r,Q[5]);
    dFlipFlop ffd25(d[6],clk,r,Q[6]);
    dFlipFlop ffd24(d[7],clk,r,Q[7]);
    dFlipFlop ffd23(d[8],clk,r,Q[8]);
    dFlipFlop ffd22(d[9],clk,r,Q[9]);
    dFlipFlop ffd21(d[10],clk,r,Q[10]);
    dFlipFlop ffd20(d[11],clk,r,Q[11]);
    dFlipFlop ffd19(d[12],clk,r,Q[12]);
    dFlipFlop ffd18(d[13],clk,r,Q[13]);
    dFlipFlop ffd17(d[14],clk,r,Q[14]);
    dFlipFlop ffd16(d[15],clk,r,Q[15]);
    dFlipFlop ffd15(d[16],clk,r,Q[16]);
    dFlipFlop ffd14(d[17],clk,r,Q[17]);
    dFlipFlop ffd13(d[18],clk,r,Q[18]);
    dFlipFlop ffd12(d[19],clk,r,Q[19]);
    dFlipFlop ffd11(d[20],clk,r,Q[20]);
    dFlipFlop ffd10(d[21],clk,r,Q[21]);
    dFlipFlop ffd9(d[22],clk,r,Q[22]);
    dFlipFlop ffd8(d[23],clk,r,Q[23]);
    dFlipFlop ffd7(d[24],clk,r,Q[24]);
    dFlipFlop ffd6(d[25],clk,r,Q[25]);
    dFlipFlop ffd5(d[26],clk,r,Q[26]);
    dFlipFlop ffd4(d[27],clk,r,Q[27]);
    dFlipFlop ffd3(d[28],clk,r,Q[28]);
    dFlipFlop ffd2(d[29],clk,r,Q[29]);
    dFlipFlop ffd1(d[30],clk,r,Q[30]);
    dFlipFlop ffd0(d[31],clk,r,Q[31]);
endmodule
module register_32b(input [31:0] value, input clk,r,output [31:0] Q);
    
    dFlipFlop fb0(value[0],clk,r,Q[0]);
    dFlipFlop fb1(value[1],clk,r,Q[1]);
    dFlipFlop fb2(value[2],clk,r,Q[2]);
    dFlipFlop fb3(value[3],clk,r,Q[3]);
    dFlipFlop fb4(value[4],clk,r,Q[4]);
    dFlipFlop fb5(value[5],clk,r,Q[5]);
    dFlipFlop fb6(value[6],clk,r,Q[6]);
    dFlipFlop fb7(value[7],clk,r,Q[7]);
    dFlipFlop fb8(value[8],clk,r,Q[8]);
    dFlipFlop fb9(value[9],clk,r,Q[9]);
    dFlipFlop fb10(value[10],clk,r,Q[10]);
    dFlipFlop fb11(value[11],clk,r,Q[11]);
    dFlipFlop fb12(value[12],clk,r,Q[12]);
    dFlipFlop fb13(value[13],clk,r,Q[13]);
    dFlipFlop fb14(value[14],clk,r,Q[14]);
    dFlipFlop fb15(value[15],clk,r,Q[15]);
    dFlipFlop fb16(value[16],clk,r,Q[16]);
    dFlipFlop fb17(value[17],clk,r,Q[17]);
    dFlipFlop fb18(value[18],clk,r,Q[18]);
    dFlipFlop fb19(value[19],clk,r,Q[19]);
    dFlipFlop fb20(value[20],clk,r,Q[20]);
    dFlipFlop fb21(value[21],clk,r,Q[21]);
    dFlipFlop fb22(value[22],clk,r,Q[22]);
    dFlipFlop fb23(value[23],clk,r,Q[23]);
    dFlipFlop fb24(value[24],clk,r,Q[24]);
    dFlipFlop fb25(value[25],clk,r,Q[25]);
    dFlipFlop fb26(value[26],clk,r,Q[26]);
    dFlipFlop fb27(value[27],clk,r,Q[27]);
    dFlipFlop fb28(value[28],clk,r,Q[28]);
    dFlipFlop fb29(value[29],clk,r,Q[29]);
    dFlipFlop fb30(value[30],clk,r,Q[30]);
    dFlipFlop fb31(value[31],clk,r,Q[31]);
endmodule
module register_32b1(input [31:0] value, input clk,r,output [31:0] Q);
    dFlipFlop fr0(value[0],clk,r,Q[0]);
    dFlipFlop fr1(value[1],clk,r,Q[1]);
    dFlipFlop fr2(value[2],clk,r,Q[2]);
    dFlipFlop fr3(value[3],clk,r,Q[3]);
    dFlipFlop fr4(value[4],clk,r,Q[4]);
    dFlipFlop fr5(value[5],clk,r,Q[5]);
    dFlipFlop fr6(value[6],clk,r,Q[6]);
    dFlipFlop fr7(value[7],clk,r,Q[7]);
    dFlipFlop fr8(value[8],clk,r,Q[8]);
    dFlipFlop fr9(value[9],clk,r,Q[9]);
    dFlipFlop fr10(value[10],clk,r,Q[10]);
    dFlipFlop fr11(value[11],clk,r,Q[11]);
    dFlipFlop fr12(value[12],clk,r,Q[12]);
    dFlipFlop fr13(value[13],clk,r,Q[13]);
    dFlipFlop fr14(value[14],clk,r,Q[14]);
    dFlipFlop fr15(value[15],clk,r,Q[15]);
    dFlipFlop fr16(value[16],clk,r,Q[16]);
    dFlipFlop fr17(value[17],clk,r,Q[17]);
    dFlipFlop fr18(value[18],clk,r,Q[18]);
    dFlipFlop fr19(value[19],clk,r,Q[19]);
    dFlipFlop fr20(value[20],clk,r,Q[20]);
    dFlipFlop fr21(value[21],clk,r,Q[21]);
    dFlipFlop fr22(value[22],clk,r,Q[22]);
    dFlipFlop fr23(value[23],clk,r,Q[23]);
    dFlipFlop fr24(value[24],clk,r,Q[24]);
    dFlipFlop fr25(value[25],clk,r,Q[25]);
    dFlipFlop fr26(value[26],clk,r,Q[26]);
    dFlipFlop fr27(value[27],clk,r,Q[27]);
    dFlipFlop fr28(value[28],clk,r,Q[28]);
    dFlipFlop fr29(value[29],clk,r,Q[29]);
    dFlipFlop fr30(value[30],clk,r,Q[30]);
    dFlipFlop fr31(value[31],clk,r,Q[31]);
endmodule
module register_32b2(input [31:0] value, input clk,r,output [31:0] Q);
	dFlipFlop fra0(value[0],clk,r,Q[0]);
	dFlipFlop fra1(value[1],clk,r,Q[1]);
	dFlipFlop fra2(value[2],clk,r,Q[2]);
	dFlipFlop fra3(value[3],clk,r,Q[3]);
	dFlipFlop fra4(value[4],clk,r,Q[4]);
	dFlipFlop fra5(value[5],clk,r,Q[5]);
	dFlipFlop fra6(value[6],clk,r,Q[6]);
	dFlipFlop fra7(value[7],clk,r,Q[7]);
	dFlipFlop fra8(value[8],clk,r,Q[8]);
	dFlipFlop fra9(value[9],clk,r,Q[9]);
	dFlipFlop fra10(value[10],clk,r,Q[10]);
	dFlipFlop fra11(value[11],clk,r,Q[11]);
	dFlipFlop fra12(value[12],clk,r,Q[12]);
	dFlipFlop fra13(value[13],clk,r,Q[13]);
	dFlipFlop fra14(value[14],clk,r,Q[14]);
	dFlipFlop fra15(value[15],clk,r,Q[15]);
	dFlipFlop fra16(value[16],clk,r,Q[16]);
	dFlipFlop fra17(value[17],clk,r,Q[17]);
	dFlipFlop fra18(value[18],clk,r,Q[18]);
	dFlipFlop fra19(value[19],clk,r,Q[19]);
	dFlipFlop fra20(value[20],clk,r,Q[20]);
	dFlipFlop fra21(value[21],clk,r,Q[21]);
	dFlipFlop fra22(value[22],clk,r,Q[22]);
	dFlipFlop fra23(value[23],clk,r,Q[23]);
	dFlipFlop fra24(value[24],clk,r,Q[24]);
	dFlipFlop fra25(value[25],clk,r,Q[25]);
	dFlipFlop fra26(value[26],clk,r,Q[26]);
	dFlipFlop fra27(value[27],clk,r,Q[27]);
	dFlipFlop fra28(value[28],clk,r,Q[28]);
	dFlipFlop fra29(value[29],clk,r,Q[29]);
	dFlipFlop fra30(value[30],clk,r,Q[30]);
	dFlipFlop fra31(value[31],clk,r,Q[31]);
endmodule