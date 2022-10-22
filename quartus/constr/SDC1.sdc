create_clock -name clk -period 10 [get_ports clk]
set_false_path -from [get_ports rst_n] -to [get_clocks clk]

set_input_delay -min 1 -clock [get_clocks clk] [all_inputs]
set_input_delay -max 2 -clock [get_clocks clk] [all_inputs]
set_output_delay -min 1 -clock [get_clocks clk] [all_outputs]
set_output_delay -max 2 -clock [get_clocks clk] [all_outputs]

