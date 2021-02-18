`include "five_bit_add_sub.v"

module worm_coordinates (clk,direction,steps,x_coordinate,y_coordinate);
    input clk;
    input [1:0] direction;
    input [1:0] steps;

    output reg [4:0] x_coordinate;
    output reg [4:0] y_coordinate;

    wire [4:0] x_new1, y_new1;
    wire [4:0] x_new2, y_new2;

    reg opcode1,opcode2;

    wire carry;

    five_bit_add_sub FB_ADD_SUB1(x_coordinate,{3'b000,steps},opcode1,x_new1,carry); // moving in east direction
    five_bit_add_sub FB_ADD_SUB2(x_coordinate,{3'b000,steps},opcode2,x_new2,carry); // moving in west direction
    five_bit_add_sub FB_ADD_SUB3(y_coordinate,{3'b000,steps},opcode1,y_new1,carry); // moving in north direction
    five_bit_add_sub FB_ADD_SUB4(y_coordinate,{3'b000,steps},opcode2,y_new2,carry); // moving in south direction

    always @(posedge clk) begin
        
        if(direction==1) begin  // east direction
            if (x_new1[4]==1) begin
                x_coordinate <= #2 15;
            end
            else begin
                x_coordinate <= #2 x_new1;
            end
        end

        else if (direction==3) begin // west direction
            if (x_new2[4]==1) begin
                x_coordinate <= #2 0;
            end
            else begin
                x_coordinate <= #2 x_new2;
            end
            
        end

        else if (direction==0) begin // North direction

            if (y_new1[4]==1) begin
                y_coordinate <= #2 15;
            end

            else begin
                y_coordinate <= #2 y_new1;
            end

        end

        else begin             // South direction

            if (y_new2[4]==1) begin
                y_coordinate <= #2 0;
            end

            else begin
                y_coordinate <= #2 y_new2;
            end

        end
        
    end

    initial begin
        x_coordinate=0;
        y_coordinate=0;
        opcode1=0;
        opcode2=1;
    end
    
endmodule