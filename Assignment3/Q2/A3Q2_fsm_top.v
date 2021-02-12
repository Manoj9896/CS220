`include "A3Q2_fsm.v"

module FSM_top;
    reg in;
    reg clk;
    wire out;

    fsm uut(clk,in,out);

    always @(posedge clk) begin
        $display("Input Bit: %b, Time: %d, Output: %b \n",in, $time, out);
    end

    initial begin
        #100;
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
    
    initial begin
        #3
        in = 0;
        #10
        in = 1;
        #10
        in = 0;
        #10
        in = 1;
        #10
        in = 0;
        #10
        in = 0;
        #10
        in = 0;
        #10
        in = 1;
        #10
        in = 0;
        #10
        in = 1;
        #10
        in = 0;
    end

endmodule