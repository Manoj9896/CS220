`include "./eight_bit_comparator.v"

module eight_bit_comparator_top;
    reg [7:0] A,B;
    wire less,equal,greater;

    eight_bit_comparator CMP(A,B,less,equal,greater);


    initial begin
        A=100;B=100;
        #1
        $monitor("A=%d B=%d les=%b equal=%b greater=%b",A,B,less,equal,greater);
        #1
        A=45;B=78;
        #1
        A=78;B=44;
        #1
        A=7;B=7;
        #1
        A=8;B=8;
        #1
        A=45;B=45;
        #1
        A=71;B=71;
        #1
        A=111;B=111;
        #1
        $finish;
    end

    
endmodule