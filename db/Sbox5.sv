/*
@Brief: LUT Implementation of Sbox5, accepts a 6-bit input and returns a 4-bit output
*/
module Sbox5 (
    input [5 : 0] in,
    output reg [3 : 0] out
);

//Registers used to store the value of row and column
reg [1 : 0] row;
reg [3 : 0] column;

    always @(*) begin

        //Row is selected from concatenation of MSB and LSB
        row = {in[5], in[0]};
        //Column is selected from the bits 4:1
        column = in[4 : 1];
        
        case (column)
            4'b0000 : case (row)
                        2'b00 :  out = 4'b0010; 
                        2'b01 :  out = 4'b1110;
                        2'b10 :  out = 4'b0100;
                        2'b11 :  out = 4'b1011;
                    endcase
            4'b0001 : case (row)
                        2'b00 :  out = 4'b1100; 
                        2'b01 :  out = 4'b1011;
                        2'b10 :  out = 4'b0010;
                        2'b11 :  out = 4'b1000;
                    endcase
            4'b0010 : case (row)
                        2'b00 :  out = 4'b0100; 
                        2'b01 :  out = 4'b0010;
                        2'b10 :  out = 4'b0001;
                        2'b11 :  out = 4'b1100;
                    endcase
            4'b0011 : case (row)
                        2'b00 :  out = 4'b0001; 
                        2'b01 :  out = 4'b1100;
                        2'b10 :  out = 4'b1011;
                        2'b11 :  out = 4'b0111;
                    endcase
            4'b0100 : case (row)
                        2'b00 :  out = 4'b0111;
                        2'b01 :  out = 4'b0100;
                        2'b10 :  out = 4'b1100;
                        2'b11 :  out = 4'b0001;
                    endcase
            4'b0101 : case (row)
                        2'b00 :  out = 4'b1010; 
                        2'b01 :  out = 4'b0111;
                        2'b10 :  out = 4'b1101;
                        2'b11 :  out = 4'b1110;
                    endcase
            4'b0110 : case (row)
                        2'b00 :  out = 4'b1011;
                        2'b01 :  out = 4'b1101;
                        2'b10 :  out = 4'b0111;
                        2'b11 :  out = 4'b0010;
                    endcase
            4'b0111 : case (row)
                        2'b00 :  out = 4'b0110;
                        2'b01 :  out = 4'b0001;
                        2'b10 :  out = 4'b1000;
                        2'b11 :  out = 4'b1101;
                    endcase
            4'b1000 : case (row)
                        2'b00 :  out = 4'b1000; 
                        2'b01 :  out = 4'b0101;
                        2'b10 :  out = 4'b1111;
                        2'b11 :  out = 4'b0110;
                    endcase
            4'b1001 : case (row)
                        2'b00 :  out = 4'b0101;
                        2'b01 :  out = 4'b0000;
                        2'b10 :  out = 4'b1001;
                        2'b11 :  out = 4'b1111;
                    endcase
            4'b1010 : case (row)
                        2'b00 :  out = 4'b0011;
                        2'b01 :  out = 4'b1111;
                        2'b10 :  out = 4'b1100;
                        2'b11 :  out = 4'b0000;
                    endcase
            4'b1011 : case (row)
                        2'b00 :  out = 4'b1111; 
                        2'b01 :  out = 4'b1100;
                        2'b10 :  out = 4'b0101;
                        2'b11 :  out = 4'b1001;
                    endcase
            4'b1100 :  case (row)
                        2'b00 :  out = 4'b1101;
                        2'b01 :  out = 4'b0011;
                        2'b10 :  out = 4'b0110;
                        2'b11 :  out = 4'b1100;
                    endcase
            4'b1101 :  case (row)
                        2'b00 :  out = 4'b0000; 
                        2'b01 :  out = 4'b1001;
                        2'b10 :  out = 4'b0011;
                        2'b11 :  out = 4'b0100;
                    endcase
            4'b1110 : case (row)
                        2'b00 :  out = 4'b1110; 
                        2'b01 :  out = 4'b1000;
                        2'b10 :  out = 4'b0000;
                        2'b11 :  out = 4'b0101;
                    endcase
            4'b1111 : case (row)
                        2'b00 :  out = 4'b1001;
                        2'b01 :  out = 4'b0110;
                        2'b10 :  out = 4'b1110;
                        2'b11 :  out = 4'b0011;
                    endcase 
        endcase
    end
endmodule