# FSM-Based Traffic Light Controller in Verilog

## 📌 Project Overview
This repository contains a synchronous sequential digital design implementing an intersection traffic light controller. The circuit handles transitions between North-South (NS) and East-West (EW) road signals using an optimal **2-always-block Moore Finite State Machine (FSM)** design style.

## 🛠️ Design Details
- **Language:** Verilog HDL
- **Target Tool:** Xilinx Vivado
- **Architecture Style:** Moore Finite State Machine
- **State Map:** 
  - `S0 (00)`: NS Green / EW Red (10 Cycles)
  - `S1 (01)`: NS Yellow / EW Red (3 Cycles)
  - `S2 (10)`: NS Red / EW Green (10 Cycles)
  - `S3 (11)`: NS Red / EW Yellow (3 Cycles)

## 📊 Behavioral Simulation Waveform
![Simulation Waveform](waveform.png)

## 🚀 How to Run in Vivado
1. Clone or download this repository.
2. Create a new RTL project in Xilinx Vivado.
3. Import `rtl/traffic_light_controller.v` as a Design Source.
4. Import `sim/tb_traffic_light_controller.v` as a Simulation Source.
5. Click **Run Simulation** -> **Run Behavioral Simulation**.
