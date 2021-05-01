`include "eight_bit_add_sub.v"

module A4Q1_top;

    reg signed [7:0] num1,num2;
    reg opcode;

    wire signed [7:0] sum;
    wire carry,overflow;

    eight_bit_add_sub EB_ADD_SUB(num1,num2,opcode,sum,carry,overflow);



    initial begin
        $monitor("num1=%d (in binary %b) num2=%d (in binary %b) opcode=%b sum=%d (in binary %b) carry=%b overflow=%b",num1,num1,num2,num2,opcode,sum,sum,carry,overflow);
        
        num1=10;num2=5;opcode=0;
        #1
        num1=10;num2=5;opcode=1;
        #1
        num1=127;num2=5;opcode=0;
        #1
        num1=127;num2=9;opcode=1;
        #1
        num1=55;num2=45;opcode=0;
        #1
        num1=100;num2=50;opcode=1;
        #1
        num1=-99;num2=-23;opcode=0;
        #1
        num1=-84;num2=-46;opcode=0;
        #1
        num1=-60;num2=5;opcode=1;
        #1
        num1=-51;num2=-1;opcode=1;
        #1
        $finish;
    end
    
endmodule