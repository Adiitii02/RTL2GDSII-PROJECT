
read_file -format verilog ripple_carry_adder_8bit.v
set_top ripple_carry_adder_8bit
link
compile -exact_map
write -format ddc -hierarchy -output rca_8bit.ddc
write_sdf rca_8bit.sdf
write -format verilog -hierarchy -output rca_8bit_synth.v
report_area > area.rpt
report_timing > timing.rpt
report_power > power.rpt
