# Memory_Verification_using_UVM-based_Environment

This project focuses on verifying a single-port memory design (16x32) using a UVM-based verification environment written in SystemVerilog. The main goal is to ensure correct functionality of all memory operations including read, write, reset, and boundary conditions using an organized and reusable verification structure.

Project Overview:

* Memory model: 16x32 single-port RAM
* Verification method: UVM (Universal Verification Methodology)
* Language: SystemVerilog
* Simulator: QuestaSim

Files Included:

* memory16x32.sv : Design Under Test (DUT) – Memory module
* interface.sv    : Interface connecting DUT with UVM components
* top.sv          : Top module that instantiates DUT and UVM environment
* UVM environment files (my_driver, my_monitor, my_agent, my_scoreboard, my_env, my_test, etc.)

Verification Features:

* Random and directed test sequences
* Write and Read operation verification
* Reset functionality checking
* Scoreboard comparison (Expected vs Actual)
* Functional and code coverage tracking
* Error reporting using UVM messaging

How to Run:

1. Compile the files using QuestaSim
2. Load the top module
3. Run the simulation
4. View waveforms and UVM report log for verification results

Tools Used:

* SystemVerilog
* QuestaSim
* UVM


This project demonstrates a solid understanding of memory design verification, UVM architecture, and simulation-based validation.
