`include "./A2Q1_decoder3to8.v"
`include "./A2Q1_encoder8to3.v"

module moduleName;
    reg [2:0] decode_in;
    wire [7:0] decode_out;

    reg [7:0] encode_in;
    wire [2:0] encode_out;

    decoder3to8 decoder(decode_in,decode_out);
    encoder8to3 encoder(encode_in,encode_out);


    initial begin
        $monitor("decode_in = %d decode_out=%b encode_in=%b encode_out=%d",decode_in,decode_out,encode_in,encode_out);
        decode_in=0; encode_in=decode_out;
        #1
        decode_in=1; encode_in=decode_out;
        #1
        decode_in=2; encode_in=decode_out;
        #1
        decode_in=3; encode_in=decode_out;
        #1
        decode_in=4; encode_in=decode_out;
        #1
        decode_in=5; encode_in=decode_out;
        #1
        decode_in=6; encode_in=decode_out;
        #1
        decode_in=7; encode_in=decode_out;
        #1
        $finish;
        
    end
    
    
endmodule