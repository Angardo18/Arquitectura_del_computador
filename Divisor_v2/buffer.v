
module invert(input [31:0] b, output[31:0] a );

    buf (a[0],b[31]);
    buf (a[1],b[30]);
    buf (a[2],b[29]);
    buf (a[3],b[28]);
    buf (a[4],b[27]);
    buf (a[5],b[26]);
    buf (a[6],b[25]);
    buf (a[7],b[24]);
    buf (a[8],b[23]);
    buf (a[9],b[22]);
    buf (a[10],b[21]);
    buf (a[11],b[20]);
    buf (a[12],b[19]);
    buf (a[13],b[18]);
    buf (a[14],b[17]);
    buf (a[15],b[16]);
    buf (a[16],b[15]);
    buf (a[17],b[14]);
    buf (a[18],b[13]);
    buf (a[19],b[12]);
    buf (a[20],b[11]);
    buf (a[21],b[10]);
    buf (a[22],b[9]);
    buf (a[23],b[8]);
    buf (a[24],b[7]);
    buf (a[25],b[6]);
    buf (a[26],b[5]);
    buf (a[27],b[4]);
    buf (a[28],b[3]);
    buf (a[29],b[2]);
    buf (a[30],b[1]);
    buf (a[31],b[0]);

endmodule

