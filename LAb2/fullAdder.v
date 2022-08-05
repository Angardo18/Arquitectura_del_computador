module fullAdder(input a,b,cIn,output out, cOut);

    wire x1; //xor entre a y b
    wire a1; //and entre cin y a^b
    wire a2; // and entre a y b
    xor xor1(x1,a,b);
    // suma de las 3 entradas
    xor xor2(out,x1,cIn);

    and and1(a1,x1,cIn);
    and and2(a2,a,b);
    or  or1(cOut,a1,a2);
endmodule

module fullAdder_Delay(input a,b,cIn,output out, cOut);

    wire x1; //xor entre a y b
    wire a1; //and entre cin y a^b
    wire a2; // and entre a y b
    xor #5 xor1(x1,a,b);
    // suma de las 3 entradas
    xor #5 xor2(out,x1,cIn);

    and #3 and1(a1,x1,cIn);
    and #3 and2(a2,a,b);
    or  #3 or1(cOut,a1,a2);
endmodule

/*
module testbench();

    reg a,b,c;
    wire res,cout;
    initial
        $monitor("a:%d  b:%d cIn:%d Out:%d C:%d",a,b,c,res,c);

    fullAdder f1(a,b,c,res,Cout);

    initial begin
    #1
    a=1; b=0;c=1;
    #1
    c=0;
    end

endmodule*/