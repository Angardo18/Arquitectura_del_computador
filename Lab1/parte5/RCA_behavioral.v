module fullAdder(input a,b, cIn, output out,cOut);

    assign out = a^b^cIn;
    assign cOut = (a&b)|(a&cIn)|(b&cIn);

endmodule

module RCA_4bits(input[3:0]a,b, output [3:0] out, output cOut);

wire c1,c2,c3;

fullAdder add1(a[0],b[0],1'b0,out[0],c1);
fullAdder add2(a[1],b[1],c1,out[1],c2);
fullAdder add3(a[2],b[2],c2,out[2],c3);
fullAdder add4(a[3],b[3],c3,out[3],cOut);

    
endmodule

module testbench();


reg [3:0] a,b;
wire [3:0] out;
wire C;

RCA_4bits sumador(a,b,out,c);

initial 
  $monitor("%d + %d = %d",a,b,out);

initial begin
    a = 4'd0; b=4'd0;
    #1 b=4'd1;
    #1 b=4'd2;
    #1 b=4'd3;
    #1 b=4'd4;
    #1 b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd1; b=4'd1;
    #1 b=4'd2;
    #1 b=4'd3;
    #1 b=4'd4;
    #1 b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd2; b=4'd2;
    #1 b=4'd3;
    #1 b=4'd4;
    #1 b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd3; b=4'd3;
    #1 b=4'd4;
    #1 b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd4; b=4'd4;
    #1 b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd5; b=4'd5;
    #1 b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd6; b=4'd6;
    #1 b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 a = 4'd7; b=4'd7;
    #1 b=4'd8;
    #1 b=4'd9;
    #1 b=4'd10;
    #1 b=4'd11;
    #1 b=4'd12;
    #1 b=4'd13;
    #1 b=4'd14;
    #1 b=4'd15;
    #1 $finish;
end

endmodule