module blink (clk,out);
    input clk;
    output out;
    reg out;

    reg [15:0] counter;

    always @(posedge clk) begin

        if($time==1'b0)begin
            counter = 1;
            out = 0;
        end
        else if (counter==25000) begin
            out = ~out;
            counter = 1;
        end
        else begin
            counter=counter+1;
        end
    end

    
endmodule