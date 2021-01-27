`include "./eight_bit_comparator.v"

module eight_bit_comparator_top;
    reg [7:0] A,B;
    wire less,equal,greater;

    eight_bit_comparator CMP(A,B,less,equal,greater);


    initial begin
        $monitor("A=%d A(in binary)=%b B=%d B(in binary)=%b less=%b equal=%b greater=%b",A,A,B,B,less,equal,greater);
        A=100;B=100;
        #1
        A=45;B=78;
        #1
        A=199;B=89;
        #1
        A=255;B=255;
        #1
        A=132;B=23;
        #1
        A=16;B=70;
        #1
        A=71;B=71;
        #1
        A=111;B=111;
        #1
        A=0;B=1;
        #1
        A=174;B=115;
        #1
        $finish;
    end

    
endmodule