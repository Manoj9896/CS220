
// Instruction are define in the InstructionMemory module
// Data Memory is defined in the Processor module (in the end)
// RefisterFile is defined in the Processor module
    
`include "A8Q1_Processor.v"

module A8Q1_top;

    reg clk;
    wire done;
    wire signed [7:0] finalResult;

    Processor PR(clk,done,finalResult);

    always @(posedge done) begin
        
        $display("time = %d finalResult = %d",$time,finalResult);
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