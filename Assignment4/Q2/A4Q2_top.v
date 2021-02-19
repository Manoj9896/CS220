`include "worm_coordinates.v"

module A4Q2_top;

    reg clk;
    reg [1:0] direction,steps;

    wire [4:0] x_coordinate,y_coordinate;

    worm_coordinates WORM(clk,direction,steps,x_coordinate,y_coordinate);

    always @(negedge clk) begin
        $display("diection=%d steps=%d  new coordinates are : x_coordinate=%d y_coordinate=%d",direction,steps,x_coordinate,y_coordinate);        
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
        direction=0;steps=1;
        #10
        direction=0;steps=3;
        #10
        direction=1;steps=2;
        #10
        direction=2;steps=1;
        #10
        direction=3;steps=2;
        #10
        direction=3;steps=1;
        #10
        direction=0;steps=1;
        #10
        direction=1;steps=3;
        #10
        direction=1;steps=2;
        #10
        direction=2;steps=1;
        #10
        direction=2;steps=0;
        #10
        direction=1;steps=3;
        #10
        direction=1;steps=3;
        #10
        direction=0;steps=2;
        #10
        direction=1;steps=3;
        #10
        direction=1;steps=2;
        #10
        direction=0;steps=2;
        #10
        direction=1;steps=3;
        #10
        $finish;
    end
    
endmodule