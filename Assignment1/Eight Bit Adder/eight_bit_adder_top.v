`include "./eight_bit_adder.v"

module eight_bit_adder_top;
    reg [7:0] x;
    reg [7:0] y;
    reg carry_in;
    wire [7:0] sum;
    wire carry_out;

    eight_bit_adder ADDER(x,y,carry_in,sum,carry_out);

    initial begin
        x=100;y=12;carry_in=0;
        #1
        $monitor("x=%d(%b), y=%d(%b), carry_in=%b, sum=%d(%b), carry_out=%b",x,x,y,y,carry_in,sum,sum,carry_out);
        #1
        x=99;y=45;carry_in=1;
        #1
        x=55;y=127;carry_in=0;
        #1
        x=127;y=127;carry_in=0;
        #1
        x=127;y=127;carry_in=1;
        #1
        x=8'b 11111111;y=1;carry_in=0;
        #2
        $finish;        
    end

endmodule