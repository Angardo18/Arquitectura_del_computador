module demux1_to_4(out0,out1,out2,out3,in,s1,s0);

    output out0,out1,out2,out3;
    reg out0,out1,out2,out3;
    input in;
    input s1,s0;

    always@(s1 or s0 or in)
        case({s1,s0})
            2'b00: begin out0 = in; out1 =1'bz; out2=1'bz;out3=1'bz; end
            2'b01: begin out0 = 1'bz; out1=in; out2=1'bz;out3=1'bz; end
            2'b10: begin out0 = 1'bz; out1=1'bz; out2=in;out3=1'bz; end
            2'b11: begin out0 = 1'bz; out1=1'bz; out2=1'bz;out3=in; end

            2'bx0,2'bx1,2'bxz,2'bxx,2'b0x,2'b1x,2'bzx:
                begin
                  out0 = 1'bx; out1=1'bx; out2=1'bx;out3=1'bx;
                end
            2'bz0,2'bz1,2'bzz,2'b0z,2'b1z:
                begin
                    out0 = 1'bz; out1=1'bz; out2=1'bz;out3=1'bz;
                end
        endcase
endmodule


module tb();
    
    wire [3:0] out;
    reg [1:0] s;
    reg in;

    demux1_to_4 demux(out[0],out[1],out[2],out[3],in,s[1],s[0]);

    initial begin
        $display(" in|  s | out");
        $display("---|----|-----");
        $monitor(" %b | %b | %b ",in,s, out);
        in = 1'd1; s = 2'd0;
        #10 s= 2'd1;
        #10 s= 2'd2;
        #10 s= 2'd3;
        #10 in = 1'd0; s = 2'd0;
        #10 s= 2'd1;
        #10 s= 2'd2;
        #10 s= 2'd3;
        #10 s= 2'bx0;
        #10 s= 2'b0x;
        #10 s= 2'bz0;
        #10 $finish;

    end




endmodule