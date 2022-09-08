module test();
    reg d;
    reg clk;
    reg r;
    wire[4:0] q;

    //dFlipFlop da(d,clk,r,q);
    conta t(clk,r,q);
    always
        #5 clk = ~clk;

    initial begin
        clk=1;
        d=1;
        #2 r=1;
        #1 r=0;
        #40 $finish;
    end

    initial
        $monitor("r=%d d=%d q=%d clk=%d ",r,d,q,clk);
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
module conta (input clk, r,output[4:0] count);

    //------------ CONTADOR DE PULSOS -----------------------
    wire [4:0] d;
    not (d[0],count[0]);
    not (d[1],count[1]);
    not (d[2],count[2]);
    not (d[3],count[3]);
    not (d[4],count[4]);

    dFlipFlop ft1(d[0],clk,r,count[0]);
    dFlipFlop ft2(d[1],count[0],r,count[1]);
    dFlipFlop ft3(d[2],count[1],r,count[2]);
    dFlipFlop ft4(d[3],count[2],r,count[3]);
    dFlipFlop ft5(d[4],count[3],r,count[4]);

endmodule

module mux(input d1,d0,s, output out);

       wire [3:0] w;
       not (w[0],s);

       and (w[1],d0,w[0]);
       and (w[2],d1,s);

       or (out,w[1],w[2]);
endmodule


/*
module dFlipFlop(input d, clk, output out);

    wire[4:0] n;

    //-------- LATCH SR 1 -----
    nand (n[0],n[3],n[1]);
    nand (n[1],clk,n[0]);
    //------- LATCH SR 2 -------
    nand (n[2],n[1],clk,n[3]);
    nand (n[3],d,n[2]);
    //------- LATCH SR 3 -------
    nand (out,n[1],n[4]);
    nand (n[4],n[2],out);

endmodule
*/
module shift(input [3:0] value, input in, load, clk,r, output [3:0] Q);
    wire [3:0]d;
    /*wire clk;
    or (clk,clock,load);
    *///--------- MULTIPLEXORES PARA LA CARGA DE DATO ------
    mux m1(value[3],in,load,d[3]);
    mux m2(value[2],Q[3],load,d[2]);
    mux m3(value[1],Q[2],load,d[1]);
    mux m4(value[0],Q[1],load,d[0]);
    //--------- FLIP FLOPS D -----------------------------
    dFlipFlop ff1(d[3]  ,clk,r,Q[3]);
    dFlipFlop ff2(d[2],clk,r,Q[2]);
    dFlipFlop ff3(d[1],clk,r,Q[1]);
    dFlipFlop ff4(d[0],clk,r,Q[0]);
endmodule


/*module test();
    reg clk;
    reg [3:0] value;
    reg in, l;

    wire [3:0] Q;

    shift sh(value,in,l,clk,Q);

    initial begin
        clk =0;
        in = 0;
        l=0;
        value = 0;      
        $display("Clk | value | l | in |  Q  |");  
        $display("----------------------------");  
        $monitor("  %b | %b  | %b | %b | %b |",clk,value,l,in,Q);
    end

    always
        #5 clk = ~clk;

    initial begin
        //se carga 8
        #1 value = 4'b1100; l=1;
        #7 l=0;
        #45 $finish;
    end

endmodule*/

