
`include "A7Q2_Processor.v"

module A7Q2_top;
    
    reg clk;
    reg [31:0] instruction;
    reg [31:0] instruction_encodings [0:6];

    wire [3:0] counter;
    wire [7:0] finalResult;

    Processor Interface(clk,instruction,counter,finalResult);


    always @(posedge clk) begin
        if(counter==8) begin
            $display("time = %d finalResult = %d",$time,finalResult);
            $finish;
        end
        instruction <= instruction_encodings[counter];

    end

    initial begin
        // rs source operand 1
        // rt source operand 2
        instruction_encodings[0] = 32'b00100100000000010000000000101101;
        instruction_encodings[1] = 32'b00100100000000101111111111101100;
        instruction_encodings[2] = 32'b00100100000000111111111111000100;
        instruction_encodings[3] = 32'b00100100000001000000000000011110;
        instruction_encodings[4] = 32'b00000000001000100010100000100001;
        instruction_encodings[5] = 32'b00000000011001000011000000100001;
        instruction_encodings[6] = 32'b00000000101001100010100000100011;
        instruction = instruction_encodings[0];
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