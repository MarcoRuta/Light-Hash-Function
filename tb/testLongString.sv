
module testBenchLongString;

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
  logic[31:0] i;
  @(reset_deassertion); 
 
      begin: TEST_LONG_STRING
            $display("\nLONG STRING TEST BEGIN");
            @(posedge clk);
            input_lenght = 64'd2000;
            M_valid = 1'b1;
            for (i  = 0 ; i < input_lenght ; i++ ) begin
                M = i;
                @(posedge clk);
            end
            M_valid = 1'b0;
            @(posedge clk);
            @(posedge clk);
            @(posedge clk);
            if(hash_ready) begin 
                $display("Digest computed: %h", digest);
                $display("LONG STRING TEST END\n");
            end
      end:  TEST_LONG_STRING


  $stop;
  end

endmodule

