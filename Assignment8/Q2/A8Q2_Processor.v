
`include "A8Q2_InstructionMemory.v"
`define MAX_PC 11
`define OUTPUT_REG 4

module Processor (clk,done,finalResult);

    input clk;

    output reg done;
    output reg signed [7:0] finalResult;

    reg signed [7:0] Registerfile [0:31];
    reg signed [7:0] nums [0:2];       // for data memory
    reg [2:0] state;

    wire [31:0] currInstruction;

    reg [4:0] rs,rt,rd;
    reg [5:0] opcode,func;
    reg [15:0] immediate;
    reg [7:0] address;
    reg [7:0] pc;
    reg invalid;

    reg signed [7:0] source1,source2,destination;


    InstructionMemory IM(clk,state,pc,currInstruction);

    always @(posedge clk) begin

        if (state == 0) begin
            state <= 1;
        end

        else if (state == 1) begin
            opcode = currInstruction[31:26];

            if(opcode == 0) begin
                rs <= currInstruction[25:21];
                rt <= currInstruction[20:16];
                rd <= currInstruction[15:11];
                func <= currInstruction[5:0];
            end

            else if (opcode == 2 || opcode == 3) begin
                address <= currInstruction[7:0];
            end

            else begin
                rs <= currInstruction[25:21];
                rt <= currInstruction[20:16];
                immediate <= currInstruction[15:0];
            end

            state<=2;
        end

        else if (state == 2) begin

            //$display("$time = %d rs=%d rt=%d rd=%d",$time,rs,rt,rd);
            
            if (opcode!=2 && opcode!=3) begin
                source1 <= Registerfile[rs];
                source2 <= Registerfile[rt];
            end            

            state <= 3;
        end

        else if (state == 3) begin
            
            if(opcode==0)begin

                if (func==33) begin
                    destination <= source1+source2;
                    pc <= pc+1;
                end

                else if (func==42) begin
                    destination <= $signed(source1) < $signed(source2);
                    pc <= pc+1;
                end

                else if (func==8) begin
                    pc <= `MAX_PC;
                end

                else begin
                    invalid <= 1;

                end

            end

            else begin
                
                if(opcode==9)begin
                    destination <= source1+immediate;
                    pc <= pc+1;
                end

                else if(opcode==4)begin
                    destination = (source1==source2)?1:0;
                    //$display("des = %d,source1 = %d source2 =%d %d",destination,source1,source2,Registerfile[1]);
                    
                    if(destination == 1)begin
                        pc <= pc+immediate;
                    end

                    else begin
                        pc <= pc+1;
                    end
                end

                else if(opcode==5)begin
                    destination = (source1==source2)?0:1;
                    
                    if(destination == 1)begin
                        pc <= pc+immediate;
                    end

                    else begin
                        pc <= pc+1;
                    end
                end

                else if (opcode==35) begin
                    address <= immediate + source1;
                    pc <= pc+1;
                end

                else if (opcode==3) begin
                    pc <= currInstruction[25:0];
                end

                else begin
                    invalid <=1;
                end
                
            end

            state <= 4;
        end

        else if (state == 4) begin

            if (opcode==35) begin
                destination = nums[address];
                // $display("des=%d address=%d",destination,address);

            end
            
            state <= 5;
        end

        else if (state == 5) begin

            if(opcode==0) begin
                if (invalid==0 && rd != 0) begin
                    Registerfile[rd] <= destination;
                end
            end

            else if (invalid == 0 && (opcode == 35 || opcode == 9)) begin
                Registerfile[rt] <= destination;
                //$display("rt=%d des=%d",rt,destination);
            end
            

            if (pc < `MAX_PC) begin
                state <= 0;
                invalid <= 0;
            end

            else begin
                state <= 6;
            end
            
        end

        else if (state == 6) begin
            finalResult <= Registerfile[`OUTPUT_REG];
            done <=1;
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
        pc=0;
        done = 0;
        invalid = 0;
    end

    // data memory initialization 

    initial begin
        nums[0]=-20;  //a
        nums[1]=10;  //b
        nums[2]=2;  //c
    end
    
endmodule