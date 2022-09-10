module mux(input d1,d0,s, output out);

       wire [3:0] w;
       not (w[0],s);

       and (w[1],d0,w[0]);
       and (w[2],d1,s);

       or (out,w[1],w[2]);
endmodule