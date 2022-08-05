//****** Example 1: Ripple Carry counter Top Block

module ripple_carry_counter(q, clk, reset);
    output [3:0] q; input clk, reset;
    T_FF tffo(q[0], clk, reset);
    T_FF tff1(q[1], q[0], reset); 
    T_FF tff2(q[2], q[1], reset); 
    T_FF tff3(q[3], q[2], reset); 
endmodule

//****** Example 2: Flip-flop T_FF
module T_FF (q, clk, reset); 
    output q;
    input clk, reset;
    wire d;
    D_FF dffO(q, d, clk, reset); 
    not n1(d,q); //not is a verilog-provided primitive 
endmodule

// Example 3 Flip_flop D_FF

module D_FF(q,d,clk,reset);

output q;
input d,clk,reset;

reg q;

always@(posedge reset or negedge clk)
    if(reset)
        q= 1'b0;
    else
        q = d;

endmodule

// example 4 Stimulus Block

module Stimulus;
    reg clk;
    reg reset;
    wire [3:0] q;

    ripple_carry_counter r1(q,clk,reset);

    initial
        clk = 1'b0;

    always
        #5 clk = ~clk;

    initial begin

        reset = 1'b1;
        #15 reset = 1'b0;
        #180 reset = 1'b1;
        #10 reset = 1'b0;
        #20 $finish;
    end

    initial
        $monitor($time, " Output q = %d", q);

endmodule 

