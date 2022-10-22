/*
@Brief: computes a round on the vector h such that h_out[i] = (h_in[i+2] ^ s_box_out) << floor(i/2)
*/
module Round (
    input [3 : 0] s_box_out, 
    input [7 : 0] [3 : 0] h_in, 
    output reg [7 : 0] [3 : 0]  h_out 
);

//Temporary register used to store the result of the Xor before the circular shift is performed
reg [3 : 0] temp; 

    always @(*) begin

        temp = h_in[2] ^ s_box_out;
        h_out[0] = temp;

        temp = h_in[3] ^ s_box_out;
        h_out[1] = temp;

        temp = h_in[4] ^ s_box_out;
        h_out[2] = (temp << 1) | (temp >> 3);

        temp = h_in[5] ^ s_box_out;
        h_out[3] = (temp << 1) | (temp >> 3);

        temp = h_in[6] ^ s_box_out;
        h_out[4] = (temp << 2) | (temp >> 2);

        temp = h_in[7] ^ s_box_out;
        h_out[5] = (temp << 2) | (temp >> 2);

        temp = h_in[0] ^ s_box_out;
        h_out[6] = (temp << 3) | (temp >> 1);
    
        temp = h_in[1] ^ s_box_out;
        h_out[7] = (temp << 3) | (temp >> 1);

    end
endmodule
