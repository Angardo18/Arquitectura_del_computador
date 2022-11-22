//data path control case 


// module tb();

//     reg [5:0] comman;
//     wire [2:0] ded;
//     reg ed;
//     wire a,b,c,d,e,f;


//     contol s1(ed, comman, a,b,c,d,e,f,ded);
//     initial begin
//         $display(" RegDst AluSrc  MemtoReg  RegWr  MemWr nPC_sel ");
//         $monitor("%b  %b  %b  %b  %b  %b  %b ",a,b,c,d,e,f,ded);
 
//         #1 comman = 6'b00000; ed=0;
//         #1 comman = 6'b00101; ed=1;
//     end
// endmodule

module  contol (input equal ,input [5:0] comman  ,output reg  RegDst, AluSrc, MemtoReg, RegWr, MemWr, nPC_sel, output reg  [2:0] ALUctr);
always @ (*) begin
    casez ({comman,equal}) 
    // load word
    7'b000000?: begin 
                RegDst =   1'b0;
                AluSrc=    1'b1;
                MemtoReg=  1'b1; 
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b000;  
                end           

    // store word 
    7'b000001?: begin
                RegDst =   1'b0; 
                AluSrc=    1'b1;
                MemtoReg=  1'b0;
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0;
                ALUctr =   3'b000;   
                end 
     // Branch equal 
    7'b0000101: begin 
                RegDst =   1'b0; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0; 
                RegWr =    1'b0; 
                MemWr=     1'b0; 
                nPC_sel =  1'b1; 
                ALUctr =   3'b001;  
                end 
    // sumador
    7'b000011?: begin
                RegDst =   1'b1; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0;
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b000;   
                end 
     // restador 
    7'b000100?: begin
                RegDst =   1'b1; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0;
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b001;   
                end 
    //multiplicador 
    7'b000101?: begin
                RegDst =   1'b1; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0; 
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b010; 
                end 
     // divisor 
    7'b000110?: begin
                RegDst =   1'b1; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0;
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b100; 
                end 
    //float 
    7'b000111?: begin
                RegDst =   1'b1; 
                AluSrc=    1'b0;
                MemtoReg=  1'b0;
                RegWr =    1'b1; 
                MemWr=     1'b0; 
                nPC_sel =  1'b0; 
                ALUctr =   3'b110;  
                end 
endcase 
end
endmodule
