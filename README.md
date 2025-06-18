# 8-bit Ripple Carry Adder using 1-bit Full Adders | RTL to GDSII

> This project demonstrates the complete ASIC design flow of an 8-bit Ripple Carry Adder (RCA) using Verilog and Synopsys tools, from RTL to GDSII layout, following industry practices.

---

## 📌 Table of Contents

1. [Objective](#objective)
2. [Tools & Environment](#tools--environment)
3. [Project Architecture](#project-architecture)
4. [Step-by-Step Flow](#step-by-step-flow)
    - RTL Design
    - Simulation
    - Synthesis
    - Floorplanning
    - Power Planning
    - Placement
    - Clock Tree Synthesis
    - Routing
    - Static Timing Analysis
5. [Results](#results)
6. [Conclusion](#conclusion)

---

## Objective

Design, implement, and verify an **8-bit Ripple Carry Adder** using **1-bit Full Adder**, and carry out the complete **ASIC VLSI flow** to generate a GDSII-compatible layout using the **SAED 32nm** standard cell library.

---

## Tools & Environment

| Tool             | Purpose                         |
|------------------|----------------------------------|
| **Verilog HDL**  | RTL Design                      |
| **Synopsys VCS** | Functional Simulation           |
| **Verdi**        | Waveform Debugging              |
| **Design Compiler (DC)** | Logic Synthesis        |
| **ICC2**         | Physical Design (PDK: SAED 32nm)|
| **PrimeTime (PT)**| Static Timing Analysis (STA)   |
| **Linux OS**     | Environment: Rocky Linux        |


---

## Project Architecture

### 1-bit Full Adder (FA)
Computes:
sum = A ⊕ B ⊕ Cin <p>
cout = AB + BCin + ACin

### 8-bit Ripple Carry Adder
Cascaded connection of 8 full adders. Each FA's carry-out is connected to the next FA's carry-in.

---

## Step-by-Step Flow

### 🔹 1. RTL Design

- Files: <p>1 bit Full Adder <p>
  - ![1 bit Full Adder code](images/full_adder.png)<p> 8 bit Ripple Adder <p>
  - ![8 bit Ripple Adder code](images/ripple_adder.png)<p> Testbench of Ripple Adder <p>
  - ![Testbench Code](images/tb_ripple_adder.png) 
- Created using Verilog HDL.
- Modular and hierarchical design.

**Gates Used**
![Gates](images/gates_used.jpeg)

**RTL Schematic:**  
![RTL Schematic](images/rtl_schematic.jpeg)

---

### 🔹 2. Simulation

- Tool: Synopsys VCS
- Verilog testbench validates functional correctness.
- Waveform viewed using Verdi (`.fsdb` output)

**Simulation Waveform:**  <p>
![Waveform](images/waveform.jpeg)

---

### 🔹 3. Synthesis (Design Compiler)

- `compile_ultra` used for optimization.
- Clock constraint: 3.4 ns
- Area and timing reports generated using `report_qor` and `report_timing`

 DC Report:  
![DC Report](images/dc_report.jpeg)<p> Constraints File <p>
![Constraints File](images/constraint.jpeg)<p>
Cell Area <p>
![DC Report](images/dc_report_1.jpeg)
![report](images/dc_report_1.jpeg)<p>
report_units
![report_2](images/dc_report_2.jpeg)


---

### 🔹 4. Floorplanning (ICC2)

- Tool: ICC2 with SAED 32nm PDK
- Core Utilization: 60%
- Pins auto-placed
- Floorplan saved and opened as `RIPPLE_ADDER`


### 🗂️ Floorplan Script (`floorplan.tcl`)

```tcl
# This script sets up the floorplan for 8-bit Ripple Carry Adder
set PDK_PATH ./../ref
create_lib -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm RIPPLE_ADDER_LIB

read_verilog {./../DC/results/bit8_shifter.mapped.v} -library RIPPLE_ADDER_LIB -design ripple_adder -top ripple_adder

open_lib RIPPLE_ADDER_LIB
open_block RIPPLE_ADDER

initialize_floorplan -core_utilization 0.6 -core_offset {3 3} -coincident_boundary false
set_individual_pin_constraints -ports [get_ports B] -sides 2
pin_spacing_distance 3

place_pins -self
create_placement -floorplan -effort high

save_block -as RIPPLE_ADDER
save_lib
``` 

**Floorplan Layout:**
![Floorplan](images/floorplan.jpeg)

---

### 🔹 5. Power Planning

- Core rings and mesh using M7/M8/M6 layers
- Standard cell rails created on M1

### PowerPlan Script (`power_planning.tcl`)

```tcl
## Power-planning - To build Power Delivery Network (PDN)
## #####################################################################################
#
############################################################################
### Step 1: to_create power/ground nets and to_connect power/ground nets :-
##############################################################################

#to create power nets

create_net -power {VDD}
create_net -ground {VSS}

## to connect power/ground_nets
#
connect_pg_net -all_blocks -automatic

#################################################################################
### step 2: to create power and ground ring patterns
#################################################################################
###
#scenario1:

create_pg_ring_pattern core_ring_pattern -horizontal_layer M7 -horizontal_width .4 -horizontal_spacing .3 -vertical_layer M8 -vertical_width .4 -vertical_spacing .3

set_pg_strategy core_power_ring -core -pattern {{name : core_ring_pattern}{nets : {VDD VSS}}{offset : {.5 .5}}}

compile_pg -strategies core_power_ring

###############################################################################
### step 3: to create pg mesh pattern
################################################################################


create_pg_mesh_pattern mesh -layers { {{vertical_layer: M6}{width: .34} {spacing: interleaving}{pitch: 5} {offset: .5}} {{horizontal_layer: M7}{width: .38} {spacing: interleaving} {pitch: 5} {offset: .5}} {{vertical_layer: M8}{width: .38} {spacing: interleaving}{pitch: 5} {offset: .5}}}

set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {stop: innermost_ring}

#set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {{{side: 1 2} {direction: L T} {stop: innermost_ring}}}

compile_pg -strategies core_mesh


###################################################
###step 4 : to create std cell power rail pattern
#######################################################

create_pg_std_cell_conn_pattern std_cell_rail -layers {M1} -rail_width 0.06

set_pg_strategy rail_strat -core -pattern {{name: std_cell_rail} {nets: VDD VSS} }

compile_pg -strategies rail_strat
#compile_pg

##########################################################
### step 5 : To save block and Save lib
#############################################################
## "save_block"  will save block as the deign name (full_adder.design) by default
#
save_block

## "save_block -as <preferred name>" to save the block in user preferred name
##
## "save_lib" will save library as created already

save_lib
```


**Power Plan Visualization:** 
![Power Plan](images/powerplan.jpeg)

---

### 🔹 6. Placement

- Legalized using `place_opt` and `legalize_placement`
- Placement checked with parasitic models

 
### Placement Script (`placement.tcl`)

 ```tcl
####mode for placement

set mode1 "func"
set corner1 "nom"
set scenario1 "${mode1}::${corner1}"
remove_modes -all; remove_corners -all; remove_scenarios -all

create_mode $mode1
create_corner $corner1
create_scenario -name func::nom -mode func -corner nom
current_mode func
current_scenario func::nom

source ./../CONSTRAINTS/full_adder.sdc

#set_dont_use [get_lib_cells */FADD*]
#set_dont_use [get_lib_cells */HADD*]
#set_dont_use [get_lib_cells */AO*]
#set_dont_use [get_lib_cells */OA*]
set_dont_use [get_lib_cells */NAND*]
#set_dont_use [get_lib_cells */XOR*]
set_dont_use [get_lib_cells */NOR*]
#set_dont_use [get_lib_cells */XNOR*]
#set_dont_use [get_lib_cells */MUX*]

current_corner nom
current_scenario func::nom

set parasitic1 "p1"
set tluplus_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

set parasitic2 "p2"
set tluplus_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set layer_map_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
read_parasitic_tech -tlup $tluplus_filep2 -layermap $layer_map_filep2 -name p2

set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic2
set_app_options -name place.coarse.continue_on_missing_scandef -value true

place_pins -self
place_opt
legalize_placement

save_block -as full_adder_placement
save_lib
```
 

**Placement Layout:**  
![Placement](images/placement.jpeg)

---

### 🔹 7. Clock Tree Synthesis (CTS)

- CCD flow with local skew optimization
- Clock network synthesized and routed

### Clock Script (`clock.tcl`)

```tcl
#pre-clock sanity checks
####################################################

check_design -checks pre_clock_tree_stage


###################################################
##        CTS using CCD  commands
####################################################
##
##stage 1:
##

synthesize_clock_tree
##stage 2:
#
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value false
set_app_options -name clock_opt.flow.enable_ccd -value true

clock_opt -to build_clock
#stage 3:
###
#
clock_opt -from route_clock -to route_clock
clock_opt

###########################################################
###  to report qor the respective CTS
############################################################
#
#report_clock_qor
#report_clock_qor -largest 2 -show_verbose_paths
#report_clock_qor -largest 2 -show_verbose_paths > cts_ccd.rpt

##########################################################
#  to save the block
########################################################

save_block -as full_adder_cts_CCD
save_lib
```


**CTS Result:**  
![CTS](images/cts.jpeg)

---

### 🔹 8. Routing

- Global, track, and detailed routing completed
- Antenna violations fixed using diodes

### Route Script (`route.tcl`)

```tcl
# set app options
#########################################################
#

set_app_options -name route.global.crosstalk_driven -value false


#track assignment
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true
#

#detail route 
set_app_options -name route.detail.timing_driven -value true
set_app_options -name route.detail.save_after_iterations -value false
set_app_options -name route.detail.force_max_number_iterations -value false
set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -name route.detail.diode_libcell_names -value */ANTENNA_RVT
#

####################################
#Atomic commands for route_auto
###################################
route_global
#save_block route_global_database

route_track
#save_block route_track_database

route_detail
#save_block route_detail_database

#route_auto
#
#
#
route_opt

######################################
# OUTPUTS
#
#
write_verilog ./results/full_adder.routed.v
write_sdc -output ./results/full_adder.routed.sdc
write_parasitics -format spef -output ./results/full_adder_${scenario1}.spef
#
```

**Routed Design:**  
![Routing](images/routing.jpeg)

---

### 🔹 9. Static Timing Analysis (PrimeTime)

- Netlist, SDC, and SPEF loaded
- Final Slack: `+0.225552 ns`
- STA confirms timing closure

**Final Slack**
![FS](images/Final_slack.jpeg)

**Cell and Pin Count**
![cell](images/cell_pin_count.jpeg)

**PrimeTime Report:**  
![PT](images/pt_gui.jpeg)

**Power Report**
![Power Report](images/pt_shell_power_report.jpeg)



---

## Results

| Metric           | Value             |
|------------------|------------------|
| **Cell Area (DC)**         | 134.70 μm² (netlist only)|    
|**Design Area (DC)**   |141.86 μm² (after placement)|
|**Cell Area (ICC2)**	|160.11 μm² (post-layout)|
| **Final Slack**  | +0.225552 ns      |
| **Clock Period** | 3.4 ns            |
| **Power**        | *From PT Report*  |
| **Library**      | SAED 32nm SS      |

---

## Conclusion

This project successfully demonstrates the entire RTL to GDSII design flow of a classic digital component using Synopsys tools. The design met all performance and area goals under the 32nm technology node, with validated timing through STA.

The result confirms a solid understanding of the full ASIC flow—from RTL to layout—and reinforces best practices in power planning, timing closure, and physical optimization.

**CREDITS:**<p>
This project was finished as a component of Pandit Deendayal Energy University's (PDEU) RTL to GDSII Flow workshop.<p>
We are deeply appreciative of VLSI Expert Mr. Puneet Mittal, for his outstanding leadership, technical mentoring, and unwavering support during the workshop, and the distinguished PDEU teaching members, for providing a solid basis in VLSI design and facilitating hands-on learning with cutting-edge EDA tools.


**MADE BY:**<p>
Name: Aditi Anand <p>
Roll no.: 22BEC048<p>
College: Pandit Deendayal Energy University, Gandhinagar <p>
Email ID: aditi.aec22@sot.pdpu.ac.in

