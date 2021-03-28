
`include "A7Q2_constants.h"

module Processor (clk,instruction,counter,finalResult);

    input clk;
    input [31:0] instruction;
    
    output reg [3:0] counter;
    output reg [7:0] finalResult;

    reg signed [7:0] Registerfile [0:31];

    reg [2:0] state;

    reg [4:0] rs,rt,rd;
    reg [31:0] currInstruction;
    reg [5:0] opcode,func;
    reg [15:0] imediate;

    reg signed [7:0] source1,source2,destination;

    reg invalid;


    always @(posedge clk) begin

        if (state==0) begin
            currInstruction <= instruction;
            counter <= counter+1;
            state <= 1;
        end
        
        else if (state==1) begin
            opcode = currInstruction[31:26];

            if (opcode==0) begin
                rs <= currInstruction[25:21];
                rt <= currInstruction[20:16];
                rd <= currInstruction[15:11];
                func <= currInstruction[5:0];
            end

            else begin
                rs <= currInstruction[25:21];
                rt <= currInstruction[20:16];
                imediate <= currInstruction[15:0];
            end
            state <= 2;
        end

        else if (state==2) begin
            
            if (opcode==0) begin
                source1 <= Registerfile[rs];
                source2 <= Registerfile[rt];
            end

            else begin
                source1 <= Registerfile[rs];
            end
            state <= 3;
        end

        else if (state==3) begin
            
            if(opcode==0)begin
                if (func==33) begin
                    destination <= source1+source2;
                end
                else if (func==35) begin
                    destination <= source1-source2;
                end
                else begin
                    invalid <= 1;
                end
            end

            else begin
                if(opcode==9)begin
                    destination <= source1+imediate;
                end
                else begin
                    invalid <= 1;
                end
            end

            state <= 4;
        end

        else if (state==4) begin
            
            if(opcode==0) begin
                if (invalid==0 && rd != 0) begin
                    Registerfile[rd] <= destination;
                end
            end

            else begin
                if (invalid==0 && rt != 0) begin
                    Registerfile[rt] <= destination;
                end
            end

            if (counter < `MAX_PC) begin
                state <= 0;
                invalid <= 0;
            end

            else begin
                state <= 5;
            end
    
        end

        else if (state==5) begin
            finalResult = Registerfile[`OUTPUT_REG];
            counter = counter+1;
        end
        
    end


    initial begin
        Registerfile[0]=0;
        Registerfile[1]=0;
        Registerfile[2]=0;
        Registerfile[3]=0;
        Registerfile[4]=0;
        Registerfile[5]=0;
        Registerfile[6]=0;
        Registerfile[7]=0;
        Registerfile[8]=0;
        Registerfile[9]=0;
        Registerfile[10]=0;
        Registerfile[11]=0;
        Registerfile[12]=0;
        Registerfile[13]=0;
        Registerfile[14]=0;
        Registerfile[15]=0;
        Registerfile[16]=0;
        Registerfile[17]=0;
        Registerfile[18]=0;
        Registerfile[19]=0;
        Registerfile[20]=0;
        Registerfile[21]=0;
        Registerfile[22]=0;
        Registerfile[23]=0;
        Registerfile[24]=0;
        Registerfile[25]=0;
        Registerfile[26]=0;
        Registerfile[27]=0;
        Registerfile[28]=0;
        Registerfile[29]=0;
        Registerfile[30]=0;
        Registerfile[31]=0; 
        state = 0;
        counter = 0;      
        invalid = 0;
    end
    
endmodule