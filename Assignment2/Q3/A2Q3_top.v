`include "A2Q3_blink.v"

module A2Q3_top;
    reg clk;
    wire M;

    blink toggler(clk,M);

    always @(M) begin
        $display("time = %d M = %b",$time,M);
    end


    initial begin
        forever begin
            clk=1;
            #5
            clk=0;
            #5
            clk=1;
        end
    end

    initial begin
        #3100000
        $finish;
    end
    
endmodule