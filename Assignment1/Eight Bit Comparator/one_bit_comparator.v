    //
    //             less(n) equal(n) greater(n)      
    //                 |    |     |
    //          _______|____|_____|_______
    //         |                          |
    //   a ----|         one              |------ less(n-1)
    //         |         bit              |------ equal(n-1)
    //   b ----|      comparator          |------ greater(n-1)
    //         |                          |
    //         |__________________________|
    //        


module one_bit_comparator (a,b,less_prev,equal_prev,greater_prev,less_new,equal_new,greater_new);

    input a,b,less_prev,equal_prev,greater_prev;
    output less_new,equal_new,greater_new;

    wire  less_new,equal_new,greater_new;

    assign less_new = less_prev&(~equal_prev)&(~greater_prev) | (~a)&(b)&(~less_prev)&(equal_prev)&(~greater_prev);

    assign equal_new=(~a)&(~b)&(~less_prev)&(equal_prev)&(~greater_prev) | (a)&(b)&(~less_prev)&(equal_prev)&(~greater_prev);

    assign greater_new = (~less_prev)&(~equal_prev)&(greater_prev) | (a)&(~b)&(~less_prev)&(equal_prev)&(~greater_prev);
    
endmodule