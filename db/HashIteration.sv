/*
@Brief: given a byte M, performs Round operation over the vector h four times in order to obtain the new vector h_out
*/
module HashIteration (
    input [7 : 0] M,
    input [7 : 0] [3 : 0] h,
    output [7 : 0] [3 : 0] h_out
);

//Register used to store the output of the SBox
reg [3 : 0] s_box_out;

//Wire used to store the value of M6
wire [5 : 0] M6;

//Computation of M6 vector, used to access the SBox
assign M6 = {M[5], M[7]^M[2], M[3], M[0], M[4]^M[1], M[6]};

//Instantiation of the SBox module 
Sbox5 sbox(
    .in (M6),
    .out (s_box_out)
);

//Auxiliaries wires used to store results of intermediate rounds
wire [7 : 0] [3 : 0] h1_out;
wire [7 : 0] [3 : 0] h2_out;
wire [7 : 0] [3 : 0] h3_out;


//Instantiation of the four Round which must be executed
Round round1 (
    .s_box_out(s_box_out),
    .h_in(h),
    .h_out(h1_out)
);

Round round2 (
    .s_box_out(s_box_out),
    .h_in(h1_out),
    .h_out(h2_out)
);

Round round3 (
    .s_box_out(s_box_out),
    .h_in(h2_out),
    .h_out(h3_out)
);

Round round4 (
    .s_box_out(s_box_out),
    .h_in(h3_out),
    .h_out(h_out)
);

endmodule