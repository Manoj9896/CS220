`include "./A2Q1_decoder3to8.v"
`include "./A2Q1_encoder8to3.v"

module moduleName;
    reg [2:0] decode_in;
    wire [7:0] decode_out;

    wire [2:0] encode_out;

    decoder3to8 decoder(decode_in,decode_out);
    encoder8to3 encoder(decode_out,encode_out);


    initial begin
        $monitor("decode_in = %d decode_in(in binary) = %b encode_out = %d encode_out(in binary) = %b ",decode_in,decode_in,encode_out,encode_out);
        decode_in=0; 
        #1
        decode_in=1; 
        #1
        decode_in=2; 
        #1
        decode_in=3; 
        #1
        decode_in=4; 
        #1
        decode_in=5; 
        #1
        decode_in=6; 
        #1
        decode_in=7; 
        #1
        $finish;

    end
    
    
endmodule