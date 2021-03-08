module FSM (clk,Y,currState);
    
    input [1:0] Y;
    output reg [3:0] currState;
    input clk;

    reg [2:0] MICROCODE_ROM [0:12];
    reg [3:0] DISPATCH_ROM1 [0:3];
    reg [3:0] DISPATCH_ROM2 [0:3];

    always @(posedge clk) begin
        
        if (MICROCODE_ROM[currState]==0) begin
            currState <= #2 currState+1;
        end

        else if (MICROCODE_ROM[currState]==1) begin
            currState <= #2 DISPATCH_ROM1[Y];
        end

        else if (MICROCODE_ROM[currState]==2) begin
            currState <= #2 7;
        end

        else if (MICROCODE_ROM[currState]==3) begin
            currState <= #2 DISPATCH_ROM2[Y];
        end

        else begin
            currState <= #2 0;
        end

    end

    initial begin
        currState=0;
        MICROCODE_ROM[0]=0;
        MICROCODE_ROM[1]=0;
        MICROCODE_ROM[2]=0;
        MICROCODE_ROM[3]=1;
        MICROCODE_ROM[4]=2;
        MICROCODE_ROM[5]=2;
        MICROCODE_ROM[6]=0;
        MICROCODE_ROM[7]=0;
        MICROCODE_ROM[8]=0;
        MICROCODE_ROM[9]=0;
        MICROCODE_ROM[10]=3;
        MICROCODE_ROM[11]=4;
        MICROCODE_ROM[12]=4;
    end

    initial begin
        DISPATCH_ROM1[0]=4;
        DISPATCH_ROM1[1]=5;
        DISPATCH_ROM1[2]=6;
        DISPATCH_ROM1[3]=6;
    end

    initial begin
        DISPATCH_ROM2[0]=11;
        DISPATCH_ROM2[1]=12;
        DISPATCH_ROM2[2]=12;
        DISPATCH_ROM2[3]=12;
    end

endmodule