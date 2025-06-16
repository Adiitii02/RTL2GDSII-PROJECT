
read_verilog rca_8bit_synth.v
read_sdc constraint.sdc
initialize_floorplan -core_utilization 0.6 -aspect_ratio 1 -row_core_ratio 0.8
place_opt
clock_opt
route_opt
report_area > layout_area.rpt
report_timing > layout_timing.rpt
report_power > layout_power.rpt
write_gds rca_8bit.gds
