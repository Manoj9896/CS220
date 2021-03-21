`include "Processor.v"

module A6Q1;

    reg clk;
    reg [2:0] opcode;
    reg [4:0] read_address1,read_address2,write_address;
    reg signed [15:0] write_data;
    wire signed [15:0] calculated_value;
    wire signed [15:0] read_data1,read_data2;
    wire done;

    reg [33:0] instructions_codings [0:8];
    reg [33:0] curr_instruction;
    reg [3:0] count;

    instruction_processor PR(clk,opcode,read_address1,read_address2,write_address,write_data,read_data1,read_data2,calculated_value,done);

    always @(posedge done) begin


        if (opcode==1 || opcode==3) begin //If instruction is 001,011 display the address of the register and the 16-bit value read.
            $display("time=%d opcode = %b read_address1 = %d read_data1 = %d",$time,opcode,read_address1,read_data1);
        end

        else if (opcode==2 || opcode==4) begin //If instruction is 010,100 display the two 16-bit values read along with the corresponding register addresses.
            $display("time=%d opcode = %b read_address1 = %d read_data1 = %d read_address2 = %d read_data2 = %d",$time,opcode,read_address1,read_data1,read_address2,read_data2);
        end

        else if (opcode==5 || opcode==6 || opcode==7) begin //If instruction is 101 or 110 or 111, display the address of the register written and the 16-bit value written.
            $display("time=%d opcode = %b write_address = %d written_data = %d",$time,opcode,write_address,calculated_value);
        end

        count = count+1;

        if(count==9) begin
            $finish;
        end
        
        curr_instruction = instructions_codings[count];
        opcode = curr_instruction[33:31];
        read_address1 <= curr_instruction[30:26];
        read_address2 <= curr_instruction[25:21];
        write_address <= curr_instruction[20:16];
        write_data <= curr_instruction[15:0];
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
        // instrucion-read_address1-read_address2-write_address-write_data
        // 3 + 5 + 5 + 5 + 16=34 bits
        instructions_codings[0] = 34'b0000000000000000010000000000010001;
        instructions_codings[1] = 34'b0110000100000000101111111111110111;
        instructions_codings[2] = 34'b1000000100010000110000000001000001;
        instructions_codings[3] = 34'b0100001000011000000000000000000000;
        instructions_codings[4] = 34'b1110001100000001010000000000000011;
        instructions_codings[5] = 34'b1010000100010001000000000000000000;
        instructions_codings[6] = 34'b1110010000000001000000000000001001;
        instructions_codings[7] = 34'b1100010100100001100000000000000000;
        instructions_codings[8] = 34'b0010011000000000000000000000000000;

        curr_instruction = instructions_codings[0];
        count = 0;
        opcode = curr_instruction[33:31];
        read_address1 = curr_instruction[30:26];
        read_address2 = curr_instruction[25:21];
        write_address = curr_instruction[20:16];
        write_data = curr_instruction[15:0];
    end    

endmodule