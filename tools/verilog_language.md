

Verilog 

- is rich language. includes all You need
- VHDL : language favored by Israeli Military firms and some Europeans. Also FPGA designers. But totally stinks.
- verilog is very old language, long overdue for reform.
- two main uses: Design and Verification (TestBench). 
- Design is written in subset of Verilog - usually called RTL.
- Verification is done in plain verilog or in UVM(+SV) or like sane people in python-driven.
- SystemVerilog : today the additions introduced by SV are actually called plain verilog.
- filenames of rtl should have extension .v or .sv in case SV features.
- filenames of include files should be .vh    - beware : better not use includes!
- macro constructs are Your enemy!  `define `ifdef ....
- 
