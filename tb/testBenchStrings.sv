
module testBenchString;

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
    reg [31 : 0] temp;
    logic[15:0] i;

    static string string_1a = "Welcome_to_testing";
    static string string_1b = "Welcome_to_testing";
    static string string_2a = "Welcoma_to_testing";


    @(reset_deassertion); 
   
    begin: TWO_STRING_SAME_HASH_TEST
      @(posedge clk);
      $display("\nSAME MESSAGE SAME HASH BEGIN");
      @(posedge clk);
      input_lenght = 64'd18;
      for (i = 0; i < input_lenght ; i++) begin
          M = string_1a.getc(i);
          M_valid = 1'b1;
          @(posedge clk);
      end
      M_valid = 1'b0;
      @(posedge clk)
      @(posedge clk)
      @(posedge clk);
      if(hash_ready)begin 
          $display("Digest of the string_1a: %h", digest);
          temp = digest;
      end

      @(posedge clk);
      input_lenght = 64'd18;
      for (i = 0; i < input_lenght ; i++) begin
          M = string_1b.getc(i);
          M_valid = 1'b1;
          @(posedge clk);
          M_valid = 1'b0;
          @(posedge clk);
      end
      M_valid = 1'b0;
      @(posedge clk)
      @(posedge clk)
      @(posedge clk);

      if(hash_ready)begin
            $display("Digest of the string_1b: %h", digest);
            $display("test result: [ %s ] ", temp === digest ? "Successful" : "Failure" );
            temp <= digest;
        end
    $display("SAME MESSAGE SAME HASH END\n");
    end: TWO_STRING_SAME_HASH_TEST

    begin: TWO_STRING_DIFFERENT_HASH_TEST
      @(posedge clk);
      $display("DIFFERENT MESSAGE DIFFERENT HASH BEGIN");
      @(posedge clk);
      input_lenght = 64'd18;
      for (i = 0; i < input_lenght ; i++) begin
          M = string_1a.getc(i);
          M_valid = 1'b1;
          @(posedge clk);
      end
      M_valid = 1'b0;
      @(posedge clk)
      @(posedge clk)
      @(posedge clk);
      if(hash_ready)begin 
          $display("Digest of the string_1a: %h", digest);
          temp = digest;
      end

      @(posedge clk);
      input_lenght = 64'd18;
      for (i = 0; i < input_lenght ; i++) begin
          M = string_2a.getc(i);
          M_valid = 1'b1;
          @(posedge clk);
      end
      M_valid = 1'b0;
      @(posedge clk)
      @(posedge clk)
      @(posedge clk);

      if(hash_ready)begin
            $display("Digest of the string_2a: %h", digest);
            $display("test result: [ %s ] ", temp !== digest ? "Successful" : "Failure" );
        end
    $display("DIFFERENT MESSAGE DIFFERENT HASH END\n");
    end: TWO_STRING_DIFFERENT_HASH_TEST

  $stop;
  end

endmodule

