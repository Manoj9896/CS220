`include "./A2Q2_priority_encoder8to3.v"

module priority_encoder3to8_top ;

    reg [7:0] in;
    wire [2:0] out;

    priority_encoder8to3 PE(in,out);

    initial begin
        $monitor("in = %b out = %b",in,out);
        in=8'b00000000;
        #1
        in=8'b00000010;
        #1
        in=8'b00000100;
        #1
        in=8'b00001000;
        #1
        in=8'b00010000;
        #1
        in=8'b00100000;
        #1
        in=8'b01000000;
        #1
        in=8'b10000000;
        #1
        $finish;
    end
    
endmodule