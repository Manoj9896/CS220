//
//
// if you want to check the result for different period change the period of the clock
// by changing the PERIOD value
//
//

`include "A3Q1_read.v"


module DRAM_top;
    reg clk,input_valid;
    reg [3:0] row_no;

    wire [15:0] row_data;
    wire output_valid;

    read bank(clk,row_no,input_valid,output_valid,row_data);

    always @(output_valid) begin
        if(output_valid==1)begin
            $display("time = %d row_no = %d row_data = %b",$time,row_no,row_data);
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
        #300
        $finish;
    end

    initial begin
        #3
        row_no=1;input_valid=1;  // example for row miss, data will be diaplayed after '1 cycle period'
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD
        
        row_no=2;input_valid=1; // example for row conflict, data will be displayed after '2 cycle period'
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD
        
        row_no=2;input_valid=1; // example for row hit, data will be displayed after 'at the same clock edge i.e. without any delay'
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD
        // other example are as follow

        row_no=11; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD

        row_no=11; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD

        row_no=7; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD

        row_no=14; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD

        row_no=14; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
        `PERIOD

        row_no=15; input_valid=1;
        `PERIOD
        input_valid=0;
        `PERIOD
        input_valid=0;
                
    end
    
endmodule