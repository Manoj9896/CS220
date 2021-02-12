`define PERIOD #10  // period of clock cycle

module read (clk,row_no,input_valid,output_valid,row_data);
    input clk,input_valid;
    input [3:0] row_no;

    output output_valid;
    output [15:0] row_data;
    reg output_valid;
    reg [15:0 ] row_data;

    reg [3:0] open_row=4'bz;
    reg [31:0] bank [0:15];

    initial begin
        bank[0] =0;
        bank[1] =1;
        bank[2] =2;
        bank[3] =3;
        bank[4] =4;
        bank[5] =5;
        bank[6] =6;
        bank[7] =7;
        bank[8] =8;
        bank[9] =9;
        bank[10] =10;
        bank[11] =11;
        bank[12] =12;
        bank[13] =13;
        bank[14] =14;
        bank[15] =15;
    end

    

    always @(posedge clk) begin

        if (input_valid==1) begin

            if(open_row==4'bz)begin // row miss
                open_row <= row_no;
                output_valid <= 0;
                row_data <= `PERIOD bank[row_no];
                output_valid <= `PERIOD 1; 
            end 

            else if (open_row==row_no) begin // row hit
                output_valid <= 0;
                row_data <= bank[row_no];
                output_valid <= 1;                
            end 

            else begin // row conflict
                open_row <= row_no;
                output_valid <= 0;
                row_data <= #20 bank[row_no];
                output_valid <= #20 1;                                
            end
            
        end      
    end
    
endmodule