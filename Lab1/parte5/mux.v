module mux2chanel(input d1,d0,s,output y);

wire a1; //d1 and s
wire a2;//d0 and not s
wire ns; //not s
wire o1; //or (d0 and ~s, s1 and s) 


not not1(ns,s);

and A1(a1,d0,ns);
and A2(a2,d1,s);

or or1(y,a1,a2);
endmodule

module mux4chanel(input d3,d2,d1,d0,s1,s0, output y);

wire
 y1,y2;

mux2chanel m1(d3,d2,s0,y1);
mux2chanel m2(d1,d0,s0,y2);
mux2chanel m3(y1,y2,s1,y);

endmodule


module testbench();

   reg [3:0] d;
    reg [1:0] s;
    wire y;

    mux4chanel m(d[3],d[2],d[1],d[0],s[1],s[0],y);
    initial begin

        $display("| D     |   S  | Y |");
        $display("-----------------------------------");
        $monitor("|  %d%d%d%d |  %d%d  | %d |"
                ,d[3],d[2],d[1],d[0],s[1],s[0],y);
    end


    initial begin
        d = 4'd0;s= 2'd0;
        #1 d=4'd1;
        #1 d=4'd2;
        #1 d=4'd3;
        #1 d=4'd4;
        #1 d=4'd5;
        #1 d=4'd6;
        #1 d=4'd7;
        #1 d=4'd8;
        #1 d=4'd9;
        #1 d=4'd10;
        #1 d=4'd11;
        #1 d=4'd12;
        #1 d=4'd13;
        #1 d=4'd14;
        #1 d=4'd15;
        #1 d = 4'd0;s= 2'd1;
        #1 d=4'd1;
        #1 d=4'd2;
        #1 d=4'd3;
        #1 d=4'd4;
        #1 d=4'd5;
        #1 d=4'd6;
        #1 d=4'd7;
        #1 d=4'd8;
        #1 d=4'd9;
        #1 d=4'd10;
        #1 d=4'd11;
        #1 d=4'd12;
        #1 d=4'd13;
        #1 d=4'd14;
        #1 d=4'd15;
        #1 d = 4'd0;s= 2'd2;
        #1 d=4'd1;
        #1 d=4'd2;
        #1 d=4'd3;
        #1 d=4'd4;
        #1 d=4'd5;
        #1 d=4'd6;
        #1 d=4'd7;
        #1 d=4'd8;
        #1 d=4'd8;
        #1 d=4'd9;
        #1 d=4'd10;
        #1 d=4'd11;
        #1 d=4'd12;
        #1 d=4'd13;
        #1 d=4'd14;
        #1 d=4'd15;
        #1 d = 4'd0;s= 2'd3;
        #1 d=4'd1;
        #1 d=4'd2;
        #1 d=4'd3;
        #1 d=4'd4;
        #1 d=4'd5;
        #1 d=4'd6;
        #1 d=4'd7;
        #1 d=4'd8;
        #1 d=4'd8;
        #1 d=4'd9;
        #1 d=4'd10;
        #1 d=4'd11;
        #1 d=4'd12;
        #1 d=4'd13;
        #1 d=4'd14;
        #1 d=4'd15;
        #1 $finish;
    end




endmodule