 /*
 @Brief: module that performs a light hash function based on DES s-box
         takes a string as input and returns the 32-bit digest of the given string
         processes a single byte of the input string in 1 clk cycle

    @input clk: clock signal
    @input M_valid: set if the input byte is valid and stable
    @input rst_n: if unset perform an async reset 
    @input M: actual byte of the string that has to be processed
    @input input_lengh: lenght of the string that has to be processed
    @output hash_ready: set if the digest is valid and stable
    @output digest_out: contains the computed digest 
 */
 module lightHashDES(
        input clk, 
        input M_valid,
        input rst_n,
        input [7 : 0] M,
        input [63 : 0] input_lenght,
        output reg hash_ready, 
        output reg [31 : 0] digest
    );

//Initial values (IV) of the digest
localparam Iv_h0 = 4'hF;
localparam Iv_h1 = 4'h3;
localparam Iv_h2 = 4'hC;
localparam Iv_h3 = 4'h2;
localparam Iv_h4 = 4'h9;
localparam Iv_h5 = 4'hD;
localparam Iv_h6 = 4'h4;
localparam Iv_h7 = 4'hB;    

//Binary register that represents if the FSA is busy in computing a digest (set if busy)
reg busy;

//Register used to keep trace of the remaining bytes to process
reg [63:0] counter;

//Register used to temporary store the value of the actual byte that has to be processed
reg [7 : 0] M_t;

//Register used to temporary store the value of M_valid
reg M_valid_t;

//Register used to store the temporary value of the digest
reg [7 : 0] [3 : 0]  H;

//Wire used to feedback the output of the HashIteration in H 
wire [7 : 0] [3 : 0] H_fb;

//Wires used for condition upon the state of FSA
wire init_state;
wire compute_state;
wire final_state;

//Init state: initial value of H are restored and a new processing activity begins
assign init_state = busy === 0 && M_valid; 

//Compute state: the computing of a digest is ongoing
assign compute_state = busy === 1 && counter > 0;

//Final state: the digest is ready and stable in output
assign final_state = busy === 1 && counter === 0;  

//Instantiation of HashIteration module
HashIteration main(
    .M(M_t), 
    .h(H),
    .h_out(H_fb)
);

always @(posedge clk or negedge rst_n) begin
        
        //IDLE state 
        if (!rst_n) begin 
            hash_ready <= 0;
            busy <= 0;

        //INIT state
        end else if(init_state) begin 
            counter <= input_lenght;
            busy <= 1;
            hash_ready <= 0;
            M_t <= M;
            M_valid_t <= M_valid;

            H[0] <= Iv_h0;
            H[1] <= Iv_h1;
            H[2] <= Iv_h2;
            H[3] <= Iv_h3;
            H[4] <= Iv_h4;
            H[5] <= Iv_h5;
            H[6] <= Iv_h6;
            H[7] <= Iv_h7;
       
        //COMPUTE state
        end else if(compute_state) begin 
            //The input is processed only if is valid
            if(M_valid_t === 1)begin 
                counter <= (counter - 1);
                H <= H_fb;
            end
            //Keep sampling the next byte
                M_t <= M;
                M_valid_t <= M_valid;

        //FINAL state    
        end else if(final_state) begin 
            hash_ready <= 1; 
            busy <= 0;
            digest <= H;

        //WRONG state: perform nothing    
        end else begin 
            #0;
        end
    end
    
 endmodule

