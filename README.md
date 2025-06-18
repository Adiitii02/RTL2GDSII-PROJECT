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

Design, implement, and verify an **8-bit Ripple Carry Adder** using **1-bit Full Adders**, and carry out the complete **ASIC VLSI flow** to generate a GDSII-compatible layout using the **SAED 32nm** standard cell library.

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
sum = A ⊕ B ⊕ Cin
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

**RTL Schematic:** <p> RTL Schematic <p> 
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
![](images/dc_report_1.jpeg)
![](images/dc_report_2.jpeg)


---

### 🔹 4. Floorplanning (ICC2)

- Tool: ICC2 with SAED 32nm PDK
- Core Utilization: 60%
- Pins auto-placed
- Floorplan saved and opened as `RIPPLE_ADDER`

**Floorplan Layout:** 
![Floorplan](images/floorplan.jpeg)

---

### 🔹 5. Power Planning

- Core rings and mesh using M7/M8/M6 layers
- Standard cell rails created on M1

**Power Plan Visualization:** 
![Power Plan](images/powerplan.jpeg)

---

### 🔹 6. Placement

- Legalized using `place_opt` and `legalize_placement`
- Placement checked with parasitic models

**Placement Layout:**  
![Placement](images/placement.jpeg)

---

### 🔹 7. Clock Tree Synthesis (CTS)

- CCD flow with local skew optimization
- Clock network synthesized and routed

**CTS Result:**  
![CTS](images/cts.jpeg)

---

### 🔹 8. Routing

- Global, track, and detailed routing completed
- Antenna violations fixed using diodes

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

## 📊 Results

| Metric           | Value             |
|------------------|------------------|
| **Area**         | 34.149 μm²        |
| **Final Slack**  | +0.225552 ns      |
| **Clock Period** | 3.4 ns            |
| **Power**        | *From PT Report*  |
| **Library**      | SAED 32nm SS      |

---

## Conclusion

This project successfully demonstrates the entire RTL to GDSII design flow of a classic digital component using Synopsys tools. The design met all performance and area goals under the 32nm technology node, with validated timing through STA.

The result confirms a solid understanding of the full ASIC flow—from RTL to layout—and reinforces best practices in power planning, timing closure, and physical optimization.

