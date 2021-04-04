module InstructionMemory (clk,state,pc,instruction);
    
    input clk;
    input [2:0] state;
    input [3:0] pc;
    
    output reg [31:0] instruction;

    reg [31:0] instruction_encodings [0:10];

    always @(posedge clk) begin
        
        if (state == 0) begin
            instruction <= instruction_encodings[pc];
        end
        
    end

    initial begin
        instruction = 0;
        instruction_encodings[0] = 32'b10001100000000010000000000000000;
        instruction_encodings[1] = 32'b10001100000000100000000000000001;
        instruction_encodings[2] = 32'b10001100000000110000000000000010;
        instruction_encodings[3] = 32'b00100100000001000000000000000000;
        instruction_encodings[4] = 32'b00100100001001010000000000000000;
        instruction_encodings[5] = 32'b00000000101000100011000000101010;
        instruction_encodings[6] = 32'b00010000110000000000000000000101;
        instruction_encodings[7] = 32'b00000000100001010010000000100001;
        instruction_encodings[8] = 32'b00000000101000110010100000100001;
        instruction_encodings[9] = 32'b00000000101000100011000000101010;
        instruction_encodings[10] = 32'b00010100110000001111111111111101;
        
    end
endmodule