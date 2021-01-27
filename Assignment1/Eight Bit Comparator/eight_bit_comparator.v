`include "./one_bit_comparator.v"

module eight_bit_comparator (A,B,less,equal,greater);

    input [7:0] A;
    input [7:0] B;

    output less,equal,greater;
    wire less,equal,greater;

    wire [7:0] temp_less,temp_equal,temp_greater;

    assign temp_less[7]=1'bz;           // switch is open for the most significant bit
    assign temp_equal[7]=1'bz;          //switch is open for the most significant bit
    assign temp_greater[7]=1'bz;        //switch is open for the most significant bit
    
    
    one_bit_comparator CM7(A[7],B[7],temp_less[7],temp_equal[7],temp_greater[7],temp_less[6],temp_equal[6],temp_greater[6]);
    one_bit_comparator CM6(A[6],B[6],temp_less[6],temp_equal[6],temp_greater[6],temp_less[5],temp_equal[5],temp_greater[5]);
    one_bit_comparator CM5(A[5],B[5],temp_less[5],temp_equal[5],temp_greater[5],temp_less[4],temp_equal[4],temp_greater[4]);
    one_bit_comparator CM4(A[4],B[4],temp_less[4],temp_equal[4],temp_greater[4],temp_less[3],temp_equal[3],temp_greater[3]);
    one_bit_comparator CM3(A[3],B[3],temp_less[3],temp_equal[3],temp_greater[3],temp_less[2],temp_equal[2],temp_greater[2]);
    one_bit_comparator CM2(A[2],B[2],temp_less[2],temp_equal[2],temp_greater[2],temp_less[1],temp_equal[1],temp_greater[1]);
    one_bit_comparator CM1(A[1],B[1],temp_less[1],temp_equal[1],temp_greater[1],temp_less[0],temp_equal[0],temp_greater[0]);
    one_bit_comparator CM0(A[0],B[0],temp_less[0],temp_equal[0],temp_greater[0],less,equal,greater);
    
endmodule