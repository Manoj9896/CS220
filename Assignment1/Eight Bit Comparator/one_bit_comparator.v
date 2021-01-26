module one_bit_comparator (a,b,ln_1,en_1,gn_1,ln,en,gn);
    input a,b,ln_1,en_1,gn_1;
    output ln,en,gn;

    wire ln,en,gn;

    assign ln=(~a)&(~b)&ln_1&(~en_1)&(~gn_1) | (~a)&(b)&ln_1&(~en_1)&(~gn_1) | (~a)&(b)&(~ln_1)&(en_1)&(~gn_1) | (a)&(~b)&ln_1&(~en_1)&(~gn_1) | (a)&(b)&ln_1&(~en_1)&(~gn_1);

    assign en=(~a)&(~b)&(~ln_1)&(en_1)&(~gn_1) | (a)&(b)&(~ln_1)&(en_1)&(~gn_1);

    assign gn=(~a)&(~b)&(~ln_1)&(~en_1)&(gn_1) | (~a)&(b)&(~ln_1)&(~en_1)&(gn_1) | (a)&(~b)&(~ln_1)&(en_1)&(~gn_1) | (a)&(~b)&(~ln_1)&(~en_1)&(gn_1) | (a)&(b)&(~ln_1)&(~en_1)&(gn_1);
    
endmodule