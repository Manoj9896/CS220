module blink (clk,out);
    input clk;
    output out;
    reg out=0;

    reg [15:0] counter=0;

    always @(posedge clk) begin
        
        counter<=counter+1;

        if (counter==25000) begin
            out <= ~out;
            counter <= 1;
        end

    end

    
endmodule