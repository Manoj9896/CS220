`include "one_bit_add_sub.v"

module five_bit_add_sub (num1,num2,opcode,sum,carry);

    input [4:0] num1,num2;
    input opcode;

    output wire [4:0] sum;
    output wire carry;

    wire [3:0] intermidates_carry;

    one_bit_add_sub OB_ADD_SUB0(num1[0],num2[0],opcode,opcode,sum[0],intermidates_carry[0]);
    one_bit_add_sub OB_ADD_SUB1(num1[1],num2[1],intermidates_carry[0],opcode,sum[1],intermidates_carry[1]);
    one_bit_add_sub OB_ADD_SUB2(num1[2],num2[2],intermidates_carry[1],opcode,sum[2],intermidates_carry[2]);
    one_bit_add_sub OB_ADD_SUB3(num1[3],num2[3],intermidates_carry[2],opcode,sum[3],intermidates_carry[3]);
    one_bit_add_sub OB_ADD_SUB4(num1[4],num2[4],intermidates_carry[3],opcode,sum[4],carry);
    
endmodule