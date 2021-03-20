`include "Processor.v"

module A6Q1;

    reg clk;
    reg [2:0] opcode;
    reg [4:0] read_address1,read_address2,write_address;
    reg signed [15:0] write_data;
    wire signed [15:0] calculated_value;
    wire signed [15:0] read_data1,read_data2;
    wire done;

    instruction_processor PR(clk,opcode,read_address1,read_address2,write_address,write_data,read_data1,read_data2,calculated_value,done);

    always @(posedge clk) begin

        // if(opcode==0)begin
        //     $display("time=%d write_address = %d write_data = %d",$time,write_address,write_data);
        // end

        if (opcode==1 | opcode==3) begin //If instruction is 001,011 display the address of the register and the 16-bit value read.
            $display("time=%d read_address1 = %d read_data1 = %d",$time,read_address1,read_data1);
        end

        else if (opcode==2 | opcode==4) begin //If instruction is 010,100 display the two 16-bit values read along with the corresponding register addresses.
            $display("time=%d read_address1 = %d read_data1 = %d read_address2 = %d read_data2 = %d",$time,read_address1,read_data1,read_address2,read_data2);
        end

        else if (opcode==5 | opcode==6 | opcode==7) begin //If instruction is 101 or 110 or 111, display the address of the register written and the 16-bit value written.
            $display("time=%d write_address = %d written_data = %d",$time,write_address,calculated_value);
        end
        
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
        #3
        opcode=0;write_address=1;write_data=12; // take 20 units
        #30
        opcode=3;read_address1=1;write_address=2;write_data=-9; // take 40 units
        #50
        opcode=4;read_address1=1;read_address2=2;write_address=3; write_data=65; // take 40 units
        #50
        opcode=2;read_address1=1;read_address2=3; // take 40 units
        #50
        opcode=7;read_address1=3;write_address=5; write_data=3; // 
        #300
        $finish;
    end    
endmodule