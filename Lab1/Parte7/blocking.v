module blocking();

    reg x,y,z;
    reg [15:0] reg_a, reg_b;
    integer count;

    initial begin
        $monitor($time," a= %b b= %b",reg_a,reg_b);
        x = 0; y=0; z=1;
        count = 0;
        reg_a = 16'b0;
        reg_b = reg_a; 

        reg_a[2] =  #15 1'b1;
        reg_b[15:13] =  #10 {x,y,z};
        count = count + 1;
    end

endmodule