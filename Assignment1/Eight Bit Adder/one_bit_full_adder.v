    //
    //                   carry(n-1)     
    //                      |     
    //          ____________|___________
    //         |                        |
    //   a ----|         one            |
    //         |         bit            |------ sum(n)
    //   b ----|        adder           |------ carry(n)
    //         |                        |
    //         |________________________|
    //        


module one_bit_full_adder (a,b,cin,sum,cout);

    input a,b,cin;
    output sum,cout;

    wire sum,cout;

    assign sum=(a^b^cin);
    assign cout=((a&b)|(b&cin)|(cin&a));
    
endmodule