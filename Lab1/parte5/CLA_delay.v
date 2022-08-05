`include "fullAdder.v"
module CLA_4bitsDelay(input [3:0]a,b,output [3:0] out, output cOut);
    wire [3:0] p;
    wire [3:0] g;
    output [3:1] c;
    //---------------- GENERATE Y PROPAGATE ------------------------
    // G0 y P0
    and #3 (c[1],a[0],b[0]);
    xor #5 (p[0],a[0],b[0]);
    
    and #3 (g[1],a[1],b[1]);
    xor #5 (p[1],a[1],b[1]);
    
    and #3 (g[2],a[2],b[2]); // generar el carry
    xor #5 (p[2],a[2],b[2]); // propagar el carry de entrada
    
    and #3 (g[3],a[3],b[3]);
    xor #5 (p[3],a[3],b[3]);
    //----------------- ACARREOS --------------------------
    wire[8:0] w;
    //C1 = G0
    // ya se crea con el generate de los bits 0, ya que no hay carry in

    //C2 = G1 + P1G0 = G1 + W0

    and #3 (w[0],p[1],c[1]);
    or  #3 (c[2],g[1],w[0]);
    
    //C3 = G2 + P2C1 = G2 + P2(G1 + P1G0)
    //   = G2 + P2G1 + P2P1G0
    //   = G2 + P2G1 + P2W0
    //   = G2 + P2G1 + W1
    //   = G2 + W2 + W1
    //   = G2 + W3
    and #3 (w[1],p[2],w[0]);
    and #3 (w[2],p[2],g[1]);
    or  #3 (w[3],w[2],w[1]);
    or  #3 (c[3],g[2],w[3]);
    
    // C4 = G3 + P3C3
    /*    = G3 + P3(G2 + W2 + W1)
          = G3 + P3G2 + P3W1 + P3W2
          = G3 + W6   +   W5 + W4
          = G3 + w6   + W8
          = G3 + w7
    */
    and #3 (w[4],p[3],w[2]);
    and #3 (w[5],p[3],w[1]);
    and #3 (w[6],p[3],g[2]);

    or  #3 (w[8],w[5],w[4]);
    or  #3 (w[7],w[6],w[8]);
    or  #3 (cOut,g[3],w[7]);

    //------ RESULTADO -------
    xor #5 (out[0],p[0],1'b0); // S0
    xor #5 (out[1],p[1],c[1]);
    xor #5 (out[2],p[2],c[2]);
    xor #5 (out[3],p[3],c[3]);


endmodule

/*
module CLA_4bitsDelay(input [3:0]a,b,output [3:0] out, output cOut);

    wire [2:0] c;
    wire c1out,c2out,c3out,c4out;
    lookAheadGenerator gen1(a,b,c,cOut);

    fullAdder_Delay add1(a[0],b[0],1'b0,out[0],c1out);
    fullAdder_Delay add2(a[1],b[1],c[0],out[1],c2out);
    fullAdder_Delay add3(a[2],b[2],c[1],out[2],c3out);
    fullAdder_Delay add4(a[3],b[3],c[2],out[3],c4out);

endmodule
*/
module testbench();
    
reg [3:0] a,b;
wire [3:0] out;
wire C;

CLA_4bitsDelay sumador(a,b,out,c);

initial 
  $monitor("%b + %b = %b cOut= %d time=%t",a,b,out,c,$time);

initial begin
    a=4'd0;b=4'd0;
    #100 a=4'd15; b=4'd1;

end

endmodule