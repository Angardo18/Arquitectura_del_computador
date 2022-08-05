
module casex_use();

    reg [3:0] encoding;
    integer state;

    always@(encoding)
    
        casex (encoding)
            4'b1xxx: state =3;
            4'bx1xx: state =2;
            4'bxx1x: state =1;
            4'bxxx1: state =0;
            default: state =0;
        endcase

    initial begin
        $display("encoding | state");
        $monitor("  %b   |%d",encoding, state);
        #1 encoding = 4'b0000;
        #1 encoding = 4'b1000;
        #1 encoding = 4'b1001;
        #1 encoding = 4'b0001;
        #1 encoding = 4'b0011;
        #1 encoding = 4'b0111;
        #1 $finish;
    end
endmodule