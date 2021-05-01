module Non_restoring_division_Algo (clk,new_input,dividend,divisor,dividend_length,divisor_length,add_count,sub_count,quotient,remainder,done);

    input clk,new_input;
    input [31:0] dividend,divisor;
    input [5:0] dividend_length,divisor_length;

    output reg [31:0] remainder,quotient,add_count,sub_count;
    output reg done;

    reg [31:0] r1;
    reg [63:0] r2;
    reg [6:0] iteration;

    always @(posedge clk) begin
        
        if (new_input == 1) begin

            done = 0;
            r1 = divisor;
            quotient = 0;
            iteration = 0;
            add_count = 0;
            sub_count = 0;

            if (dividend < divisor) begin
                remainder <= dividend;
                done <= 1;
            end
            
            else begin
                r1 <= r1 << (dividend_length - divisor_length); 
                r2 <= dividend;
            end
            
        end

        else if (r2[63] == 1) begin

            r2 = r2 + r1;
            quotient  = quotient ^ 1;
            add_count = add_count+1;
            quotient = (quotient << 1) | 1;
            r1 = r1 >> 1;
            iteration = iteration + 1;
            
        end

        else begin
            r2 = r2 - r1;
            sub_count = sub_count+1;
            quotient = (quotient << 1) | 1;
            r1 = r1 >> 1;
            iteration = iteration + 1;

        end

        if (iteration == dividend_length - divisor_length +1) begin

            if(r2[63]==1) begin
                r2 = r2 + divisor;
                add_count = add_count + 1;
                quotient = quotient ^ 1;
            end

            remainder = r2;
            done = 1;

        end

    end

    
endmodule