//           _________________
//          |                 |
//     I0---|        P E      |
//     I1---|        R N      |---a
//     I2---|        I C      |
//     I3---|        O O      |---b
//     I4---|        R D      |
//     I5---|        I E      |---c
//     I6---|        T R      |
//     I7---|        Y        |
//          |_________________|
//


module priority_encoder8to3 (in,out);
    input [7:0] in;
    output [2:0] out;

    wire [2:0] out;

    assign out[0] = (~in[0])&( in[1] | (~in[2])&( in[3] | (~in[4])&( in[5] | (~in[6])&in[7] ) ) );
    assign out[1] = (~in[0])&(~in[1])&( in[2] | in[3] ) | (~in[0])&(~in[1])&(~in[4])&(~in[5])&( in[6] | in[7] );
    assign out[2] = (~in[0])&(~in[1])&(~in[2])&(~in[3])&( in[4] | in[5] | in[6] | in[7] );
    
endmodule