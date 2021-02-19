module one_bit_add_sub(a,b,cin,opcode,sum,carry);

    input a,b,cin,opcode;
    output wire sum,carry;

    wire temp;
    assign temp=b^opcode;
    
    assign sum=(a^temp^cin);
    assign carry=((a&temp)|(temp&cin)|(cin&a));
    
endmodule