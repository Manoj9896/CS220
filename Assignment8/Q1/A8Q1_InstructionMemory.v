module InstructionMemory (clk,state,pc,instruction);
    
    input clk;
    input [2:0] state;
    input [7:0] pc;
    
    output reg [31:0] instruction;

    reg [31:0] instruction_encodings [0:13];

    always @(posedge clk) begin
        
        if (state == 0) begin
            instruction <= instruction_encodings[pc];
        end
        
    end

    initial begin
        instruction = 0;
        instruction_encodings[0] = 32'b00100100000000100000000000000000;
        instruction_encodings[1] = 32'b00100100000000110000000000000000;
        instruction_encodings[2] = 32'b00000000011000010010000000101010;
        instruction_encodings[3] = 32'b00010000100000000000000000001000;
        instruction_encodings[4] = 32'b00100100000001010000000000001010;
        instruction_encodings[5] = 32'b00010000011001010000000000000110;
        instruction_encodings[6] = 32'b10001100011001100000000000000000;
        instruction_encodings[7] = 32'b00000000010001100001000000100001;
        instruction_encodings[8] = 32'b00100100011000110000000000000001;
        instruction_encodings[9] = 32'b00000000011000010010000000101010;
        instruction_encodings[10] = 32'b00010100100000001111111111111011;
        instruction_encodings[11] = 32'b00000011111000000000000000001000;
        instruction_encodings[12] = 32'b10001100000000010000000000001010;
        instruction_encodings[13] = 32'b00001100000000000000000000000000;
    end
endmodule