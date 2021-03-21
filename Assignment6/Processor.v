`include "RF.v"

// done ---> telling the top module whether instruction is completed or not
// calculated_value ---> storing the result after addition or subtraction or shift operator as we cannot acces the register file directly
// rest input and output are with the names
// opcode --> instruction code

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
    reg [4:0] cycles=0;
    
    
    RegisterFile register_interface(clk,read_address1,read_address2,write_address,write_data_temp,valid_address,read_data1,read_data2);

    
    always @(posedge clk) begin

        if (opcode==0) begin // No read, one write (000)

            if(cycles==0) begin
                done <= 0;
                valid_address <= 3'b001;
                write_data_temp <= write_data;
                cycles <= cycles+1;
            end 

            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <= 1;
            end         

            else begin
                cycles=cycles+1;
            end

        end

        else if (opcode==1) begin // One read, no write (001)

            if (cycles==0) begin
                done <= 0;
                valid_address <= 3'b010;
                cycles<=cycles+1;
            end

            else if (cycles==2) begin
                valid_address = 3'b000;
                cycles <= 0;
                done <=  1;
            end

            else begin
                cycles = cycles+1;
            end

        end

        else if (opcode==2) begin // Two reads, no write (010)
            
            if (cycles==0) begin
                done <= 0;
                valid_address <= 3'b110;
                cycles<=cycles+1;
            end

            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <=  1;
            end

            else begin
                cycles = cycles+1;
            end

        end

        else if (opcode==3) begin //One read, one write (011)
            
            if (cycles==0) begin
                done <= 0;
                write_data_temp <= write_data;
                valid_address <= 3'b011;
                cycles<=cycles+1;
            end

            else if (cycles==2) begin
                valid_address = 3'b000;
                cycles <= 0;
                done <=  1;
            end

            else begin
                cycles = cycles+1;
            end

        end

        else if (opcode==4) begin //Two reads, one write (100)

            if (cycles==0) begin
                done <= 0;
                write_data_temp <= write_data;
                valid_address <= 3'b111;
                cycles<=cycles+1;
            end

            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <= 1;
            end

            else begin
                cycles <= cycles+1;
            end

        end

        else if (opcode==5) begin //Two reads, add two read values, write the result, ignore overflow (101)

            if (cycles==0) begin
                done <= 0;
                valid_address <= 3'b110;
                cycles <= cycles+1;                
            end
            
            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= cycles+1;
            end

            else if (cycles==18) begin
                valid_address <= 3'b001;
                write_data_temp <= calculated_value;
                cycles <= cycles+1;
            end

            else if(cycles==20) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <= 1;
            end

            else begin
                cycles = cycles+1;
            end
            calculated_value <= read_data1+read_data2;           
        end

        else if (opcode==6) begin // Two reads, subtract second read value from the first value, write the result, ignore overflow (110)
            
            if (cycles==0) begin
                done <= 0;
                valid_address <= 3'b110;
                cycles <= cycles+1;                
            end
            
            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= cycles+1;
            end

            else if (cycles==18) begin
                valid_address <= 3'b001;
                write_data_temp <= calculated_value;
                cycles <= cycles+1;
            end

            else if(cycles==20) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <= 1;
            end

            else begin
                cycles = cycles+1;
            end
            
            calculated_value <= read_data1-read_data2;

        end

        else begin // One read, shift the read value left, write the result (111)
            
            if (cycles==0) begin
                done <= 0;
                valid_address <= 3'b010;
                cycles <= cycles+1;                
            end
            
            else if (cycles==2) begin
                valid_address <= 3'b000;
                cycles <= cycles+1;
            end

            else if (cycles==18) begin
                valid_address <= 3'b001;
                write_data_temp <= calculated_value;
                cycles <= cycles+1;
            end

            else if(cycles==20) begin
                valid_address <= 3'b000;
                cycles <= 0;
                done <= 1;
            end

            else begin
                cycles = cycles+1;
            end
            calculated_value <= read_data1 << write_data;
        end

    end

endmodule