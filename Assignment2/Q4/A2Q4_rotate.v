module rotate (clk,out);
    input clk;
    output [3:0] out;

    reg [3:0] out;

    reg [3:0] temp;
    reg [15:0] counter;

    always @(posedge clk) begin
        if ($time==0) begin
            counter=1;
            out=4'b1000;
            temp=out;
        end
        else if (counter==25000) begin
            out[0]=temp[3];
            out[1]=temp[0];
            out[2]=temp[1];
            out[3]=temp[2];

            temp=out;
            counter=1;
        end

        else begin
            counter=counter+1;
        end
        
    end
    
endmodule