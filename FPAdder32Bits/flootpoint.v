module sumador_fp(input[31:0]A,input[31:0]B,output[31:0]Resultado);
    reg [22:0]MA,MB; /*Mantisa para A y para B*/
    reg [7:0]EA,EB,EX,ED; /*Exponente de de A y de B. ED es el exponente de la diferencia de la resta y EX es el exponente del resultado.*/
    reg [25:0]MA2,MB2; /*Variables para las mantisas donde se hacen el complemento 2's*/
    reg [25:0]MR;/*Mantisa resultante*/
    reg SA,SB,SR;/*Signo de A, B y el resultado*/
    reg [4:0]EM;/* */
    reg [31:0]Resultado;/*variable par escribir el resultado*/
    initial begin
        /*Declaro de cuanto seran las entradas y el orden de los bits que se deben
        de tener para que no se pierdan o corran a lugares que no deben*/
        MA=A[22:0];
        MB=B[22:0];
        EA=A[30:23];
        EB=B[30:23];
        SA=A[31];
        SB=B[31];
    end
    always @* begin
        /*Declaro de cuanto seran las entradas y el orden de los bits que se deben
        de tener para que no se pierdan o corran a lugares que no deben*/
        MA=A[22:0];
        MB=B[22:0];
        EA=A[30:23];
        EB=B[30:23];
        SA=A[31];
        SB=B[31];
        ED=EA-EB;/*hago la diferencia entre los exponentes de mis entradas A y B*/
        
        /*si mis exponentes son iguales, el exponente del resultado es igual al de A
        con lo que hago el complemento 2's de ambas mantisas A y B y el signo resultante
        es igual al de mi primera entrada*/
        if(EA==EB)begin
            EX=EA;
            MA2={2'b00,1'b1,MA};
            MB2={2'b00,1'b1,MB};
            SR=SA;
        end
        /*Si el exponente de A es menor al de B, al exponente de la diferencia le hago
        una NOT y le sumo 1
        con lo que la mantisas de A tiene que ser igual a un corrimiento de un bit a la derecha
        para que sea mayo al de la diferencia
        luego el exponetne del resultado es igual al del B
        luego con las mantisa MA2 y MB2 los nuevos valores los guardo ahí por los shift
        el signo es igual al de la segunda entrada*/
        if(EA<EB) begin
            ED=~ED + 8'b0001;
            MA[22:0]={1'b1,MA}>>ED;
            EX=EB;
            MA2={3'b000,MA[22:0]};
            MB2={2'b00,1'b1,MB};
            SR=SB;
        end
        /*el mismo caso de arriba solo que cuando el exponente de A es mayor 
        al exponente de B*/
        if(EA>EB) begin
            ED=~ED + 8'b0001;
            MB[22:0]={1'b1,MB}>>ED;
            EX=EA;
            MA2={2'b00,1'b1,MA};
            MB2={3'b000,MB[22:0]};
            SR=SA;
        end
        /*cuando el signo de A es 1 le hace la NOT para que sea negativo
        y luego se lo asigna a la variable de la nueva mantisa*/
        if(SA==1) begin
            MA2=~MA2[25:0] + 23'b0001;
        end else begin
            MA2=MA2;
        end
        /*cuando el signo de B es 1 le hace la NOT para que sea negativo
        y luego se lo asigna a la variable de la nueva mantisa*/
        if(SB==1) begin
            MB2=~MB2[25:0] + 23'b0001;
        end else begin
            MB2=MB2;
        end
        /*para la mantisa del resultado hago la suma de las dos mantisas nuevas
        donde se hacen los shift's y las condiciones que se describen anteriomente*/
        MR=MA2+MB2;
        /*y si a la mantisa resultante el primer bit es 1 se le hace una NOT
        + 1 para arreglar el bit*/
        if(MR[25]==1) begin
            MR=~MR+ 24'b0001;
        end
        /*la parte de todos los if es para saber que tantos shift tiene que hacer dependiendo de todos los shifts en cada caso que tiene
        y luego lo normaliza de la manera correcta antes de sacarlo en el resultado*/
        if(MR[25:23]==3'b000) begin
        if(MR[22]==1) begin
        EM=1;
        end else if (MR[21]==1) begin
        EM=2;
        end else if (MR[20]==1) begin
        EM=3;
        end else if (MR[19]==1) begin
        EM=4;
        end else if (MR[18]==1) begin
        EM=5;
        end else if (MR[17]==1) begin
        EM=6;
        end else if (MR[16]==1) begin
        EM=7;
        end else if (MR[15]==1) begin
        EM=8;
        end else if (MR[14]==1) begin
        EM=9;
        end else if (MR[13]==1) begin
        EM=10;
        end else if (MR[12]==1) begin
        EM=11;
        end else if (MR[11]==1) begin
        EM=12;
        end else if (MR[10]==1) begin
        EM=13;
        end else if (MR[9]==1) begin
        EM=14;
        end else if (MR[8]==1) begin
        EM=15;
        end else if (MR[7]==1) begin
        EM=16;
        end else if (MR[6]==1) begin
        EM=17;
        end else if (MR[5]==1) begin
        EM=18;
        end else if (MR[4]==1) begin
        EM=19;
        end else if (MR[3]==1) begin
        EM=20;
        end else if (MR[2]==1) begin
        EM=21;
        end else if (MR[1]==1) begin
        EM=22;
        end else if (MR[0]==1) begin
        EM=23;
        end

        MR=MR<<EM;
        EX=EX-EM;
        end else if(MR[25:23]==3'b001) begin
            MR=MR;
            EX=EX;
        end else if(MR[25:23]==3'b010) begin
            MR=MR>>1;
            EX=EX+1;
        end else if(MR[25:23]==3'b011) begin
            MR=MR>>1;
            EX=EX+1;
        end
        Resultado={SR,EX,MR[22:0]};
    end
endmodule
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
// module test();

//     reg [31:0] a,b;
//     wire [31:0] result;
//     sumador_fp try (a,b,result);    
//     initial begin

//         a=32'b11000111010000001110100001011000;
//         b=32'b11000111111010110111000010010100;
          
//         $display("a     |  b  |   result ");
//         $display("------------------------");
//         $monitor("%b | %b | %b", a,b,result);
//     end
// endmodule