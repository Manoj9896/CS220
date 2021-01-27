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

    reg  less_new,equal_new,greater_new;


    always @(a or b or less_prev or equal_prev or greater_prev) begin

        if (less_prev==1'b1) begin
            less_new=less_prev;
            equal_new=equal_prev;
            greater_new=greater_prev;
        end

        else if (greater_prev==1'b1) begin
            less_new=less_prev;
            equal_new=equal_prev;
            greater_new=greater_prev;
        end
        else begin
            less_new=(~a)&b;
            equal_new= ~(a^b);
            greater_new= a&(~b);
        end
        
    end    
    
endmodule