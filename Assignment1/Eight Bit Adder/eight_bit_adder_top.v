`include "./eight_bit_adder.v"

module eight_bit_adder_top;
    reg [7:0] A;
    reg [7:0] B;
    reg carry_in;
    wire [7:0] sum;
    wire carry_out;

    eight_bit_adder ADDER(A,B,carry_in,sum,carry_out);

    initial begin
        $monitor("A=%d A(in binary)=%b B=%d B(in binary)=%b carry_in=%b sum=%d sum(in binary)=%b carry_out=%b",A,A,B,B,carry_in,sum,sum,carry_out);
        A=100;B=12;carry_in=0;
        #1
        A=99;B=45;carry_in=1;
        #1
        A=55;B=159;carry_in=0;
        #1
        A=85;B=123;carry_in=0;
        #1
        A=127;B=127;carry_in=1;
        #1
        A=8'b 11111111;B=1;carry_in=0;
        #1
        A=91;B=69;carry_in=0;
        #1
        A=255;B=255;carry_in=1;
        #1
        A=211;B=14;carry_in=1;
        #1
        A=70;B=10;carry_in=0;
        #1
        $finish;        
    end

endmodule