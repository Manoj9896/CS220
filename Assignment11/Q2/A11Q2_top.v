
`include "A11Q2_divider.v"

module A11Q2_top;

    reg clk,new_input;
    reg [31:0] dividend,divisor;
    reg [5:0] dividend_length,divisor_length;

    reg [63:0] data_encodings [0:9];
    reg [11:0] lengths [0:9];

    wire [31:0] remainder,quotient,add_count,sub_count;
    wire done;

    reg [3:0] counter;

    Non_restoring_division_Algo divider(clk,new_input,dividend,divisor,dividend_length,divisor_length,add_count,sub_count,quotient,remainder,done);


    always @(negedge clk) begin

        if (done == 1) begin
           counter = counter +1;

           // Note that we are also counting the addition operation when remainder in the end is negative

           $display("time=%d, dividend=%d, divisor=%d, quotient=%d, remainder=%d",$time,dividend,divisor,quotient,remainder);
           $display("additions=%d, subtractions=%d\n",add_count,sub_count);

           if(counter == 10) begin
               $finish;
           end

           else begin
               divisor <= data_encodings[counter][31:0];
               dividend <=data_encodings[counter][63:32];
               divisor_length <= lengths[counter][5:0];
               dividend_length <= lengths[counter][11:6];
               new_input <= 1;
           end

        end

        else if($time != 0) begin
            new_input <= 0;
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
        // encoding is done as = dividend:divisor
        counter = 0;
        new_input = 1;
        data_encodings[0][63:32] = 11;
        data_encodings[0][31:0]  = 3;
        lengths[0][11:6] = 4;
        lengths[0][5:0] = 2;
        
        data_encodings[1][63:32] = 55;
        data_encodings[1][31:0]  = 21;
        lengths[1][11:6] = 6;
        lengths[1][5:0] = 5; 
        
        data_encodings[2][63:32] = 101;
        data_encodings[2][31:0]  = 110; 
        lengths[2][11:6] = 7;
        lengths[2][5:0] = 7;
        
        data_encodings[3][63:32] = 999;
        data_encodings[3][31:0]  = 100; 
        lengths[3][11:6] = 10;
        lengths[3][5:0] = 7;
        
        data_encodings[4][63:32] = 5689;
        data_encodings[4][31:0]  = 89; 
        lengths[4][11:6] = 13;
        lengths[4][5:0] = 7;
        
        data_encodings[5][63:32] = 500;
        data_encodings[5][31:0]  = 356; 
        lengths[5][11:6] = 9;
        lengths[5][5:0] = 9;
        
        data_encodings[6][63:32] = 715;
        data_encodings[6][31:0]  = 12; 
        lengths[6][11:6] = 10;
        lengths[6][5:0] = 4;
        
        data_encodings[7][63:32] = 456;
        data_encodings[7][31:0]  = 23; 
        lengths[7][11:6] = 9;
        lengths[7][5:0] = 5;
        
        data_encodings[8][63:32] = 1000;
        data_encodings[8][31:0]  = 100; 
        lengths[8][11:6] = 11;
        lengths[8][5:0] = 7;
        
        data_encodings[9][63:32] = 32'b10101010101010101010101010101000;
        data_encodings[9][31:0]  = 32'b11010110; 
        lengths[9][11:6] = 32;
        lengths[9][5:0] = 8;

        divisor = data_encodings[counter][31:0];
        dividend = data_encodings[counter][63:32];
        divisor_length = lengths[counter][5:0];
        dividend_length = lengths[counter][11:6];
    end
    
endmodule