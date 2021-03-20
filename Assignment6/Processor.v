`include "RF.v"

module instruction_processor (clk,opcode,read_address1,read_address2,write_address,write_data,read_data1,read_data2,done);
    input clk;
    input [2:0] opcode;
    output reg done;

    reg [2:0] valid_address=3'b000;
    reg [15:0] add,sub,shift;
    
    RegisterFile register_interface(clk,read_address1,read_address2,write_address,write_data,read_data1,read_data2);

    always @(posedge clk) begin
        if (opcode==0) begin // No read, one write (000)
            valid_address[0] = 1; 
            valid_address[0] <= #20 0;
        end
        else if (opcode==1) begin // One read, no write (001)
            valid_address[1] = 1;
            valid_address[1] <= #20 0;
        end
        else if (opcode==2) begin // Two reads, no write (010)
            valid_address = 3'b110;
            valid_address <= #20 3'b000;
        end
        else if (opcode==3) begin //One read, one write (011)
            valid_address = 3'b011;
            valid_address <= #20 3'b000;
        end
        else if (opcode==4) begin //Two reads, one write (100)
            valid_address = 3'b111;
            valid_address <= #20 3'b000;
        end
        else if (opcode==5) begin //Two reads, add two read values, write the result, ignore overflow (101)
            valid_address = 3'b110;
            add <= #160 read_data1+read_data2;
            write_data <= add;
            valid_address <= 3'b001;
            valid_address <= #20 3'b000;

        end
        else if (opcode==6) begin // Two reads, subtract second read value from the first value, write the result, ignore overflow (110)
            valid_address = 3'b110;
            sub <= #160 read_data1-read_data2;
            write_data <= sub;
            valid_address <= 3'b001;
            valid_address <= #20 3'b000;
        end
        else begin // One read, shift the read value left, write the result (111)
            valid_address = 3'b010;
            shift <= #160 read_data1 << 1;
            write_data <= shift;
            valid_address <= 3'b001;
            valid_address <= #20 3'b000;
        end
    end

endmodule