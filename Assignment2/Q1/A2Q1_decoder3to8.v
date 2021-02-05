//           _________________
//          |                 |
//          |        D        |---I0
//      a---|        E        |---I1
//          |        C        |---I2
//      b---|        o        |---I3
//          |        D        |---I4
//      c---|        E        |---I5
//          |        R        |---I6
//          |                 |---I7
//          |_________________|
//


module decoder3to8 (in,out);
    input [2:0] in;
    output [7:0] out;

    wire [7:0] out;

    assign out[0] = (~in[2])&(~in[1])&(~in[0]);
    assign out[1] = (~in[2])&(~in[1])&(in[0]);
    assign out[2] = (~in[2])&(in[1])&(~in[0]);
    assign out[3] = (~in[2])&(in[1])&(in[0]);
    assign out[4] = (in[2])&(~in[1])&(~in[0]);
    assign out[5] = (in[2])&(~in[1])&(in[0]);
    assign out[6] = (in[2])&(in[1])&(~in[0]);
    assign out[7] = (in[2])&(in[1])&(in[0]);
    
endmodule