module fsm(clk,in,o);
    input clk,in;
    output reg o=1;

    reg a,b,c,da,db,dc;

    initial begin
        a = 0;
        b = 0;
        c = 0;
    end

    always@(posedge clk) begin

        da = (~in & (c | a)) | (a & (b | c)) | (b & in) ;
        db = (a & b) | (~a & ~b & in) | (a & ~c & in);
        dc =  ~c | a | (b & in) | (~b & c & ~in);
        a = da;
        b = db;
        c = dc;

        if({da,db,dc} ==3'b101)begin
            o = 0;
        end

        else begin
            o  = 1;
        end
    end
 
endmodule