module Processor(clk,instruction,RF,IF,JF,count3,count4,count5,count6,done);

    input clk;
    input [31:0] instruction;

    output reg [3:0] RF;
    output reg [3:0] IF;
    output reg [3:0] JF;
    output reg [3:0] count3;
    output reg [3:0] count4;
    output reg [3:0] count5;
    output reg [3:0] count6;

    output reg done;

    wire [5:0] opcode;
    reg [5:0] rd;

    assign opcode = instruction[31:26];

    always @(posedge clk) begin

        if (opcode==0) begin
            RF = RF+1;
            rd = instruction[15:11];
        
            case (rd)
                3: begin
                    count3 <= count3+1;
                end 
                4: begin
                    count4 <= count4+1;
                end 
                5: begin
                    count5 <= count5+1;
                end 
                6: begin
                    count6 = count6+1;
                end 
                
            endcase

            done <= 1;

        end

        else if (opcode == 2 || opcode == 3) begin
            JF = JF+1;
            done <= 1;
        end

        else begin
            IF = IF+1;

            rd = instruction[20:16];

            case (rd)
                3: begin
                    count3 <= count3+1;
                end 
                4: begin
                    count4 <= count4+1;
                end 
                5: begin
                    count5 <= count5+1;
                end 
                6: begin
                    count6 <= count6+1;
                end 
                
            endcase

            done <= 1;
        end
    end

    always @(negedge clk) begin
        done <= 0;
    end

    initial begin
        RF=0;
        IF=0;
        JF=0;
        count3=0;
        count4=0;
        count5=0;
        count6=0;
    end
    
endmodule