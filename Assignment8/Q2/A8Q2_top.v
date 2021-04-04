
`include "A8Q2_Processor.v"

module A8Q1_top;

    reg clk;
    wire done;
    wire signed [7:0] finalResult;

    Processor PR(clk,done,finalResult);

    always @(posedge done) begin
        $display("time = %d finalResult = %d",$time,finalResult);

        #10
        $finish;

    end


    initial begin
        forever begin
            clk=0;
            #5
            clk=1;
            #5
            clk=0;
        end
    end
    
endmodule