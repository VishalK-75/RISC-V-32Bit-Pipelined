# 5-Stage Pipelined 32-bit RISC-V Processor Core

A hardware design and implementation of a 5-stage concurrent pipelined processor based on the open-source **RISC-V (RV32I) Architecture**, modeled entirely in **Verilog HDL**.

## 🛠️ Microarchitectural Overview
* **Concurrent Pipeline Datapath:** Divided into Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Writeback (WB) cycles.
* **32-bit Word Handling:** Optimized for standard 32-bit wide instructions, data buses, immediate sign extensions, and a 32x32-bit Register File.
* **Bypassing & Forwarding Logic:** A centralized Hazard Unit monitors instruction destination and source registers to route calculated data values directly back to the ALU inputs, minimizing raw data dependency delays.
* **Load-Use Protection:** Automatically forces a single-cycle hardware pipeline stall bubble when an instruction immediately reads a register target currently being retrieved from Data RAM.

## 📁 Workspace Layout
* `/src` : Synthesizable Verilog design modules (`Pipeline_32_Top.v`, `Hazard_Unit.v`, etc.)
* `/sim` : GTKWave signal logging workspace save metrics (`pipeline_trace.gvw`).

## 🚀 How to Run
Compile your Verilog workspace source modules using a hardware description simulator and review the execution tracking clock-by-clock by loading the output trace file directly into **GTKWave**.# RISC-V-32Bit-Pipelined
