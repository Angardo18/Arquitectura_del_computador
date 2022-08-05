module ALU(input [3:0]a,b,input [2:0] select, output reg [4:0] out);

    always@(a or b or select) //siempre que haya un cambio a b o select se realiza
        case(select)
        3'b000: out = a;
        3'b001: out = a+b;
        3'b010: out= a-b;
        3'b011: out = a/b;
        3'b100: out = a%b;
        3'b101: out = a <<1;
        3'b110: out = a>>1;
        3'b111: out = (a>b);
        endcase
endmodule

module tb();

    reg[3:0] a,b;
    reg[2:0] s;

    wire [4:0] out;
     
    ALU alu(a,b,s,out);

    initial begin
        $display("   a |   b  |  s  | out");
        $monitor("%b | %b | %b | %b",a,b,s,out);
        a=4'b0; b=4'b0; s=3'b0;
        #1 a =4'd1;
        #1 b=4'd1;
        #1 a=4'd10;
        #1 s =3'd1;
        #1 s=3'd2;
        #1 b=4'd2; s=3'd3;
        #1 b=4'd4; s=3'd4;
        #1 s=3'd5;
        #1 s=3'd6;
        #1 s=3'd7;
    end


endmodule