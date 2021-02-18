`include "eight_bit_add_sub.v"

module A4Q2_top;

    reg signed [7:0] num1,num2;
    reg opcode;

    wire signed [7:0] sum;
    wire carry,overflow;

    eight_bit_add_sub EB_ADD_SUB(num1,num2,opcode,sum,carry,overflow);



    initial begin
        $monitor("num1=%d num2=%d sum=%d carry=%b overflow=%b",num1,num2,sum,carry,overflow);
        
        num1=10;num2=5;opcode=0;
        #1
        num1=10;num2=5;opcode=1;
        #1
        num1=10;num2=5;opcode=0;
        #1
        num1=10;num2=5;opcode=0;
        #1
        num1=10;num2=5;opcode=0;
        #1
        $finish;
    end
    
endmodule