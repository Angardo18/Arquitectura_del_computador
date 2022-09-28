

module Full_adder(output s, output cout, input a, input b, input cin);
    wire C1,C2,C3;
    
    xor  (C1,a,b);
    xor  (s,C1,cin);
    and  (C3,a,b);     
    and  (C2,C1,cin); 
    or  (cout,C2,C3); 
    
endmodule

module Ripple32bit(output [31:0]s, output c, input [31:0]a, input [31:0] b, input cIn);

    wire [31:0] carry;
    Full_adder fa0(.a(a[0]), .b(b[0]), .cin(cIn), .s(s[0]), .cout(carry[0]));
    Full_adder fa1(.a(a[1]), .b(b[1]), .cin(carry[0]), .s(s[1]), .cout(carry[1]));    
    Full_adder fa2(.a(a[2]), .b(b[2]), .cin(carry[1]), .s(s[2]), .cout(carry[2]));  
    Full_adder fa3(.a(a[3]), .b(b[3]), .cin(carry[2]), .s(s[3]), .cout(carry[3]));
    Full_adder fa4(.a(a[4]), .b(b[4]), .cin(carry[3]), .s(s[4]), .cout(carry[4]));
    Full_adder fa5(.a(a[5]), .b(b[5]), .cin(carry[4]), .s(s[5]), .cout(carry[5]));
    Full_adder fa6(.a(a[6]), .b(b[6]), .cin(carry[5]), .s(s[6]), .cout(carry[6]));
    Full_adder fa7(.a(a[7]), .b(b[7]), .cin(carry[6]), .s(s[7]), .cout(carry[7]));
    Full_adder fa8(.a(a[8]), .b(b[8]), .cin(carry[7]), .s(s[8]), .cout(carry[8]));
    Full_adder fa9(.a(a[9]), .b(b[9]), .cin(carry[8]), .s(s[9]), .cout(carry[9]));
    Full_adder fa10(.a(a[10]), .b(b[10]), .cin(carry[9]), .s(s[10]), .cout(carry[10]));
    Full_adder fa11(.a(a[11]), .b(b[11]), .cin(carry[10]), .s(s[11]), .cout(carry[11]));   
    Full_adder fa12(.a(a[12]), .b(b[12]), .cin(carry[11]), .s(s[12]), .cout(carry[12]));
    Full_adder fa13(.a(a[13]), .b(b[13]), .cin(carry[12]), .s(s[13]), .cout(carry[13]));   
    Full_adder fa14(.a(a[14]), .b(b[14]), .cin(carry[13]), .s(s[14]), .cout(carry[14]));
    Full_adder fa15(.a(a[15]), .b(b[15]), .cin(carry[14]), .s(s[15]), .cout(carry[15]));   
    Full_adder fa16(.a(a[16]), .b(b[16]), .cin(carry[15]), .s(s[16]), .cout(carry[16]));
    Full_adder fa17(.a(a[17]), .b(b[17]), .cin(carry[16]), .s(s[17]), .cout(carry[17]));    
    Full_adder fa18(.a(a[18]), .b(b[18]), .cin(carry[17]), .s(s[18]), .cout(carry[18]));
    Full_adder fa19(.a(a[19]), .b(b[19]), .cin(carry[18]), .s(s[19]), .cout(carry[19]));    
    Full_adder fa20(.a(a[20]), .b(b[20]), .cin(carry[19]), .s(s[20]), .cout(carry[20]));
    Full_adder fa21(.a(a[21]), .b(b[21]), .cin(carry[20]), .s(s[21]), .cout(carry[21]));    
    Full_adder fa22(.a(a[22]), .b(b[22]), .cin(carry[21]), .s(s[22]), .cout(carry[22]));
    Full_adder fa23(.a(a[23]), .b(b[23]), .cin(carry[22]), .s(s[23]), .cout(carry[23]));    
    Full_adder fa24(.a(a[24]), .b(b[24]), .cin(carry[23]), .s(s[24]), .cout(carry[24]));
    Full_adder fa25(.a(a[25]), .b(b[25]), .cin(carry[24]), .s(s[25]), .cout(carry[25]));    
    Full_adder fa26(.a(a[26]), .b(b[26]), .cin(carry[25]), .s(s[26]), .cout(carry[26]));
    Full_adder fa27(.a(a[27]), .b(b[27]), .cin(carry[26]), .s(s[27]), .cout(carry[27]));   
    Full_adder fa28(.a(a[28]), .b(b[28]), .cin(carry[27]), .s(s[28]), .cout(carry[28]));
    Full_adder fa29(.a(a[29]), .b(b[29]), .cin(carry[28]), .s(s[29]), .cout(carry[29])); 
    Full_adder fa30(.a(a[30]), .b(b[30]), .cin(carry[29]), .s(s[30]), .cout(carry[30]));
    Full_adder fa31(.a(a[31]),  .b(b[31]), .cin(carry[30]), .s(s[31]), .cout(c));

endmodule

module resta32bits(input [31:0] a, b, input op, output [31:0] salida, output cout);

       wire [31:0] nb;
       wire [31:0] bin; //entrada b al sumador

       not (nb[0],b[0]);
       not (nb[1],b[1]);
       not (nb[2],b[2]);
       not (nb[3],b[3]);
       not (nb[4],b[4]);
       not (nb[5],b[5]);
       not (nb[6],b[6]);
       not (nb[7],b[7]);
       not (nb[8],b[8]);
       not (nb[9],b[9]);
       not (nb[10],b[10]);
       not (nb[11],b[11]);
       not (nb[12],b[12]);
       not (nb[13],b[13]);
       not (nb[14],b[14]);
       not (nb[15],b[15]);
       not (nb[16],b[16]);
       not (nb[17],b[17]);
       not (nb[18],b[18]);
       not (nb[19],b[19]);
       not (nb[20],b[20]);
       not (nb[21],b[21]);
       not (nb[22],b[22]);
       not (nb[23],b[23]);
       not (nb[24],b[24]);
       not (nb[25],b[25]);
       not (nb[26],b[26]);
       not (nb[27],b[27]);
       not (nb[28],b[28]);
       not (nb[29],b[29]);
       not (nb[30],b[30]);
       not (nb[31],b[31]);
       
       Ripple32bit add( salida,cout,a,nb,1'b1);
endmodule