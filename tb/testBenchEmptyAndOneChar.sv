
module testBenchEmptyAndOneChar;

  reg clk = 1'b0; 
  always #10 clk = !clk; 
  
  reg rst_n = 1'b0; 
  event reset_deassertion; 
  
  reg M_valid;
  reg [63:0] input_lenght;
  reg hash_ready;
  reg [7 : 0] M;
  reg [31 : 0] digest;


  lightHashDES test_light_hash (
      .clk            (clk)
      ,.rst_n         (rst_n)
      ,.M_valid		    (M_valid)
      ,.M 			      (M)
      ,.input_lenght  (input_lenght)  
      ,.hash_ready 	  (hash_ready)
      ,.digest        (digest)
    );

  initial begin
    #12.8 rst_n = 1'b1;
    -> reset_deassertion; 
  end
     
  
  initial begin 
 
    localparam empty_digest = 32'hb4d92c3f;
    localparam A_digest = 32'h4b76d630;


    @(reset_deassertion); 
 
    begin: EMPTY_TEST
    $display("\n***EMPTY TEST BEGIN***");
    @(posedge clk);
    M_valid = 1'b1;
    input_lenght = 64'd0;
    @(posedge clk);
    M_valid = 1'b0;
    @(posedge clk);
    @(posedge clk);
  

    if(hash_ready)begin
        $display("Digest result of empty test: %h", digest);
        $display("test result: [ %s ] ", empty_digest === digest ? "Successful" : "Failure" );
        $display("***EMPTY TEST END***\n");
    end
    end: EMPTY_TEST


    begin: ONE_CHAR_TEST
    $display("***ONE CHAR TEST (A) BEGIN***");
    @(posedge clk);
    M_valid = 1'b1;
    input_lenght = 64'd1;
    M = 8'd65;
    @(posedge clk);
    M_valid = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    if(hash_ready)begin
          $display("Digest result of one char test (A): %h", digest);
          $display("test result: [ %s ] ", A_digest === digest ? "Successful" : "Failure" );
          $display("***ONE CHAR TEST (A) END***\n");
      end
    end: ONE_CHAR_TEST


  $stop;
  end

endmodule

