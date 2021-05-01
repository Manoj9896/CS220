module Booths_Algo (clk,new_input,multiplicand,multiplier,product,add_count,sub_count,done);

    input clk;
    input new_input;
    input [31:0] multiplicand, multiplier;


    output reg [5:0] add_count,sub_count;
    output reg [63:0] product;
    output reg done;

    reg [5:0] index;

    wire [63:0] r1;
    reg [63:0] r2;

    assign r1 = $signed(multiplicand) << index;


    always @(posedge clk) begin

        if (new_input == 1) begin
            product = 0;
            done = 0;
            add_count = 0;
            sub_count = 0;
            r2 = $signed(multiplier);


            if (multiplier[index]==1) begin
                product <= product - r1;
                sub_count <= sub_count+1;   
            end
                  
        end

        else if (multiplier[index] != multiplier[index-1]) begin


            if (multiplier[index] == 1) begin
                product <= product - r1;
                sub_count <= sub_count+1;
            end
            else begin
                product <= product + r1; 
                add_count <= add_count + 1;
            end       

        end

        if ( (index == 31) || (r2 == -1) || (r2 == 0) ) begin
            done <= 1;
            index <= 0;
        end

        else begin
            index <= index + 1;
        end 

        r2 <= r2 >>> 1; 
                
    end

    initial begin
        index = 0;
    end
    
endmodule