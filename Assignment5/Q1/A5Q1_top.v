`include "A5Q1_FSM.v"

module A5Q1_TOP;
    reg [1:0] Y;
    reg clk;

    wire [3:0] currState;

    FSM F1(clk,Y,currState);

    always @(posedge clk) begin
        $display("clk=%b Y=%d currState=%d",clk,Y,currState);
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
        Y=00;
        #10
        Y=01;
        #10
        Y=10;
        #10
        Y=11;
        #10
        Y=00;
        #10
        Y=01;
        #10
        Y=10;
        #10
        Y=11;
        #10
        Y=00;
        #10
        Y=01;
        #10
        Y=10;
        #10
        $finish;
    end
    
endmodule