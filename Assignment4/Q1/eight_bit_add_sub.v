`include "one_bit_add_sub.v"


module eight_bit_add_sub(num1,num2,opcode,sum,carry,overflow);

    input [7:0] num1,num2;
    input opcode;

    output wire [7:0] sum;
    output wire carry,overflow;

    wire [6:0] intermidates_carry;

    one_bit_add_sub OB_ADD_SUB0(num1[0],num2[0],opcode,opcode,sum[0],intermidates_carry[0]);
    one_bit_add_sub OB_ADD_SUB1(num1[1],num2[1],intermidates_carry[0],opcode,sum[1],intermidates_carry[1]);
    one_bit_add_sub OB_ADD_SUB2(num1[2],num2[2],intermidates_carry[1],opcode,sum[2],intermidates_carry[2]);
    one_bit_add_sub OB_ADD_SUB3(num1[3],num2[3],intermidates_carry[2],opcode,sum[3],intermidates_carry[3]);
    one_bit_add_sub OB_ADD_SUB4(num1[4],num2[4],intermidates_carry[3],opcode,sum[4],intermidates_carry[4]);
    one_bit_add_sub OB_ADD_SUB5(num1[5],num2[5],intermidates_carry[4],opcode,sum[5],intermidates_carry[5]);
    one_bit_add_sub OB_ADD_SUB6(num1[6],num2[6],intermidates_carry[5],opcode,sum[6],intermidates_carry[6]);
    one_bit_add_sub OB_ADD_SUB7(num1[7],num2[7],intermidates_carry[6],opcode,sum[7],carry);

    assign overflow=intermidates_carry[6]^carry;
    
endmodule