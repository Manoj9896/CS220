`include "./A2Q4_rotate.v"

module A2Q4_top;

    reg clk;
    wire [3:0] out;

    rotate rotater(clk,out);

    always @(out) begin
        $display("time = %d out = %b",$time,out);        
    end

    initial begin
        forever begin
            clk=1;
            #5;
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