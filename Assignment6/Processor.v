`include "RF.v"

module instruction_processor (clk,opcode,read_address1,read_address2,write_address,write_data,read_data1,read_data2,calculated_value,done);
    input clk;
    input [2:0] opcode;
    input [4:0] read_address1,read_address2,write_address;
    input [15:0] write_data;
    output wire [15:0] read_data1,read_data2;
    output reg done;
    output reg [15:0] calculated_value;

    reg [2:0] valid_address=3'b000;
    
    reg [15:0] write_data_temp;
    
    RegisterFile register_interface(clk,read_address1,read_address2,write_address,write_data_temp,valid_address,read_data1,read_data2);

    always @(posedge clk) begin
        if (opcode==0) begin // No read, one write (000)
            valid_address[0] = 1; 
            write_data_temp=write_data;
            valid_address[0] <= #20 0;
            done <= #20 1;
        end
        else if (opcode==1) begin // One read, no write (001)
            valid_address[1] = 1;
            valid_address[1] <= #20 0;
            done <= #20 1;
        end
        else if (opcode==2) begin // Two reads, no write (010)
            valid_address = 3'b110;
            valid_address <= #20 3'b000;
            done <= #20 1;
        end
        else if (opcode==3) begin //One read, one write (011)
            valid_address = 3'b011;
            write_data_temp=write_data;
            valid_address <= #20 3'b000;
        end
        else if (opcode==4) begin //Two reads, one write (100)
            valid_address = 3'b111;
            write_data_temp=write_data;
            valid_address <= #20 3'b000;
        end
        else if (opcode==5) begin //Two reads, add two read values, write the result, ignore overflow (101)
            valid_address = 3'b110;
            calculated_value = #160 read_data1+read_data2;
            write_data_temp = calculated_value;
            valid_address = 3'b001;
            valid_address <= #180 3'b000;
        end
        else if (opcode==6) begin // Two reads, subtract second read value from the first value, write the result, ignore overflow (110)
            valid_address = 3'b110;
            calculated_value =  read_data1-read_data2;
            #160
            write_data_temp = calculated_value;
            valid_address = 3'b001;
            valid_address <= #180 3'b000;
        end
        else begin // One read, shift the read value left, write the result (111)
            valid_address = 3'b010;
            calculated_value = (read_data1 << write_data);
            #160 
            write_data_temp = calculated_value;
            valid_address = 3'b001;
            valid_address <= #180 3'b000;
        end
    end

endmodule