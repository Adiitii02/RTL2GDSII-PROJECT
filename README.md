# 8-bit Ripple Carry Adder (RTL to GDSII Flow)

This project demonstrates the complete ASIC design flow for an **8-bit Ripple Carry Adder** constructed using **1-bit Full Adders**, implemented in Verilog and synthesized through the **Synopsys digital design toolchain**. It culminates in generating the GDSII layout using the **SAED 32nm PDK**.

---

## 📌 Table of Contents
- [Introduction](#introduction)
- [Tools Used](#tools-used)
- [Project Flow](#project-flow)
  - [RTL Design](#rtl-design)
  - [Synthesis (DC)](#synthesis-dc)
  - [Physical Design (ICC2)](#physical-design-icc2)
  - [Static Timing Analysis (PrimeTime)](#static-timing-analysis-primetime)
- [Final Results](#final-results)
- [Conclusion](#conclusion)

---

## 🧠 Introduction

The 8-bit Ripple Carry Adder is a classic digital design that chains 1-bit full adders to perform binary addition. The project showcases the complete **VLSI backend design flow** using Verilog and Synopsys tools.

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | RTL design |
| Synopsys VCS | Functional simulation |
| Synopsys Verdi | Waveform debugging |
| Design Compiler | Logic synthesis |
| IC Compiler II (ICC2) | Floorplan to Routing |
| PrimeTime | Static Timing Analysis |
| SAED 32nm | Standard cell library (SS corner) |

---

## 🚀 Project Flow

### 🔹 RTL Design

- Developed using Verilog:
  - `full_adder.v`
  - `ripple_adder.v`
- Testbench created and simulated using VCS.
- Functional correctness verified using Verdi.

**RTL Schematic**  
![RTL Schematic](images/rtl_schematic.png)

---

### 🔹 Synthesis (DC)

- Tool: `dc_shell`
- Used `compile_ultra` for optimized synthesis.
- Applied constraints (`seq_det.sdc`) with a **clock period of 3.4 ns**.

**Synthesis Report Screenshot**  
![DC Report](images/dc_report.png)

---

### 🔹 Physical Design (ICC2)

#### 🔸 Floorplanning
- Core utilization: 60%
- Pins auto-placed
- Cell placement using `create_placement`

![Floorplan](images/floorplan.png)

#### 🔸 Power Planning
- Power rings (M7/M8)
- Mesh grid (M6–M8)
- Cell rail on M1

![Power Plan](images/power_plan.png)

#### 🔸 Placement

- Legalized and optimized placement with parasitics set.

![Placement](images/placement.png)

#### 🔸 Clock Tree Synthesis (CTS)

- Local skew optimization enabled.
- Clock routes built using CCD flow.

![CTS](images/cts.png)

#### 🔸 Routing

- Timing-driven and crosstalk-aware routing.
- Antenna rule violations resolved using diodes.

![Routing](images/routing.png)

---

### 🔹 Static Timing Analysis (PrimeTime)

- Read SDC and parasitic SPEF files.
- Performed full timing update and report generation.

![PrimeTime GUI](images/pt_gui.png)

---

## 📈 Final Results

| Parameter | Value |
|----------|-------|
| **Area** | 34.149 μm² |
| **Final Slack** | +0.225552 ns |
| **Clock Period** | 3.4 ns |
| **Library** | SAED 32nm SS |
| **Power Consumption** | *(Shown in PrimeTime screenshot)* |

---

## ✅ Conclusion

This project implemented an 8-bit Ripple Carry Adder using the full RTL to GDSII flow. All backend stages—**synthesis**, **placement**, **clocking**, and **routing**—were optimized to meet the timing and area constraints.

Positive slack achieved in **PrimeTime** confirms the design is **functionally and temporally correct** at the intended clock frequency.

---

## 📎 Screenshots Folder

All images referenced above are available in the [`/images`](images) directory.

---

## 📚 License

This project is part of an academic VLSI submission and is for educational purposes only.

