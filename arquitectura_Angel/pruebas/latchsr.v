
module sr_latch_gated(Q, Qn, G, S, R);
   output Q;
   output Qn;
   input  G;   
   input  S;
   input  R;

   wire   S1;
   wire   R1;
   
   and(S1, G, S);
   and(R1, G, R);   
   nor(Qn, S1, Q);
   nor(Q, R1, Qn);
endmodule

module test();

    reg r,s,g;
    wire o,on;
    sr_latch_gated sa(o,oN,g,s,r);

    initial begin
        r =0;
        s =0;
        g=1;
        $monitor("s:%d r:%d  o:%d",r,s,o);
        #1 s=1;
        #1 r=0;s=0;
        #1 s=1;r=0;
        #1 s=0;r=1;

    end

endmodule