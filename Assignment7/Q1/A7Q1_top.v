`include "A7Q1_Processor.v"

module A7Q1_top;

    reg clk;

    wire [3:0] RF;
    wire [3:0] IF;
    wire [3:0] JF;
    wire [3:0] count3;
    wire [3:0] count4;
    wire [3:0] count5;
    wire [3:0] count6;

    reg [31:0] instruction;

    reg [31:0] instruction_encodings [0:7];
    reg [3:0] counter;

    Processor Interface(clk,instruction,RF,IF,JF,count3,count4,count5,count6,done);

    always @(posedge done) begin
        counter = counter+1;

        if(counter==8) begin
            $display("Time = %d R-Format = %d I-Format = %d J-Format = %d $3 = %d $4 = %d $5 = %d $6 = %d",$time,RF,IF,JF,count3,count4,count5,count6);
            $finish;
        end

        instruction <= instruction_encodings[counter];
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
        // R-format : [op:rs:rt:rd:shamt:func]
        // I-format : [op:rs:rt:immediate]
        // J-format : [op:target]

        instruction_encodings[0] = 32'b00100000000001000011010001010110; 
        instruction_encodings[1] = 32'b00100000000001011111111111111111; 
        instruction_encodings[2] = 32'b00000000101001000011000000010100;           
        instruction_encodings[3] = 32'b00100000000000110000000000000111; 
        instruction_encodings[4] = 32'b00000000011001100011000000000100; 
        instruction_encodings[5] = 32'b00000000000000110001100001000010;
        instruction_encodings[6] = 32'b01011100100001011001101010111100; 
        instruction_encodings[7] = 32'b00001000000100100011010001010110;
        counter=0;

        instruction = instruction_encodings[0];
    end
    
endmodule