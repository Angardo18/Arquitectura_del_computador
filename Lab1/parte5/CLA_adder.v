`include "fullAdder.v"

module CLA_4bits(input [3:0]a,b,output [3:0] out, output cOut);
    wire [3:0] p;
    wire [3:0] g;
    output [3:1] c;
    //---------------- GENERATE Y PROPAGATE ------------------------
    // G0 y P0
    and  (c[1],a[0],b[0]);
    xor  (p[0],a[0],b[0]);
    
    and  (g[1],a[1],b[1]);
    xor  (p[1],a[1],b[1]);
    
    and  (g[2],a[2],b[2]); // generar el carry
    xor  (p[2],a[2],b[2]); // propagar el carry de entrada
    
    and  (g[3],a[3],b[3]);
    xor  (p[3],a[3],b[3]);
    //----------------- ACARREOS --------------------------
    wire[7:0] w;
    //C1 = G0
    // ya se crea con el generate de los bits 0, ya que no hay carry in

    //C2 = G1 + P1G0 = G1 + W0

    and  (w[0],p[1],c[1]);
    or   (c[2],g[1],w[0]);
    
    //C3 = G2 + P2C1 = G2 + P2(G1 + P1G0)
    //   = G2 + P2G1 + P2P1G0
    //   = G2 + P2G1 + P2W0
    //   = G2 + P2G1 + W1
    //   = G2 + W2 + W1
    //   = G2 + W3
    and  (w[1],p[2],w[0]);
    and  (w[2],p[2],g[1]);
    or   (w[3],w[2],w[1]);
    or   (c[3],g[2],w[3]);
    
    // C4 = G3 + P3C3
    /*    = G3 + P3(G2 + W3)
          = G3 + P3G2 + P3W3
          = G3 + W5 + W4
          = G3 + W6
    */
    and  (w[4],p[3],w[3]);
    and  (w[5],p[3],g[2]);

    or   (w[6],w[5],w[4]);
    or   (cOut,g[3],w[6]);

    //------ RESULTADO -------
    xor  (out[0],p[0],1'b0); // S0
    xor  (out[1],p[1],c[1]);
    xor  (out[2],p[2],c[2]);
    xor  (out[3],p[3],c[3]);


endmodule

/*
module CLA_4bits(input [3:0]a,b,output [3:0] out, output cOut);

    wire c1,c2,c3;
    wire c1out,c2out,c3out,c4out;
    lookAheadGenerator gen1(a,b,c1,c2,c3,cOut);

    fullAdder add1(a[0],b[0],1'b0,out[0],c1out);
    fullAdder add2(a[1],b[1],c1,out[1],c2out);
    fullAdder add3(a[2],b[2],c2,out[2],c3out);
    fullAdder add4(a[3],b[3],c3,out[3],c4out);

endmodule
*/
module testbench();


reg [3:0] a,b;
wire [3:0] out;
wire c;

CLA_4bits sumador(a,b,out,c);

initial 
  $monitor("%d + %d = %d  %d",a,b,out,c);

initial begin
  a = 4'd0; b=4'd1;
  #1 a = 4'd0; b=4'd2;
  #1 a = 4'd1; b=4'd3;
  #1 a = 4'd5; b=4'd3;
  #1 a = 4'd5; b=4'd10;
  #1 a = 4'd15; b=4'd1;
  #1 $finish;
end

endmodule