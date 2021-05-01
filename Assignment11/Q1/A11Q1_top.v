`include "A11Q1_Booths_Algo.v"

module A11Q1_top;

    reg clk;
    reg new_input;

    reg signed [63:0] data_encodings [0:9];
    reg signed [31:0] multiplicand,multiplier;
    wire [5:0] add_count,sub_count;
    wire  done;
    wire signed [63:0] product;
    reg [3:0] counter;

    Booths_Algo calc(clk,new_input,multiplicand,multiplier,product,add_count,sub_count,done);



    always @(negedge clk) begin

        if (done == 1) begin
           counter = counter +1;

           $display("time=%d, multiplicand=%d, multiplier=%d, product=%d",$time,multiplicand,multiplier,product);
           $display("additions=%d, subtractions=%d\n",add_count,sub_count);

           if(counter == 10) begin
               $finish;
           end

           else begin
               multiplier <= data_encodings[counter][31:0];
               multiplicand <=data_encodings[counter][63:32];
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
        // encoding is done as = multiplicand:multiplier
        counter = 0;
        new_input = 1;
        data_encodings[0][63:32] = 11;
        data_encodings[0][31:0]  = 2147483648; 
        
        data_encodings[1][63:32] = 55;
        data_encodings[1][31:0]  = 21; 
        
        data_encodings[2][63:32] = -101;
        data_encodings[2][31:0]  = 110; 
        
        data_encodings[3][63:32] = -999;
        data_encodings[3][31:0]  = 100; 
        
        data_encodings[4][63:32] = 5689;
        data_encodings[4][31:0]  = -89; 
        
        data_encodings[5][63:32] = 500;
        data_encodings[5][31:0]  = 356; 
        
        data_encodings[6][63:32] = 715;
        data_encodings[6][31:0]  = 0; 
        
        data_encodings[7][63:32] = 456;
        data_encodings[7][31:0]  = 9876; 
        
        data_encodings[8][63:32] = 1234;
        data_encodings[8][31:0]  = 1234; 
        
        data_encodings[9][63:32] = -1;
        data_encodings[9][31:0]  = 32'b01010101010101010101010101010101; 

        multiplier = data_encodings[counter][31:0];
        multiplicand =data_encodings[counter][63:32];

    end
    
endmodule