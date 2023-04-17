
# How i like to see verilog RTL code

- net names are lower case. port names must be lower case.
- parameters and localparams are UPPER case. 
- keep distinction between parameters and localparams.
- module header format is the new one (output reg [3:0] cucu)
- all instance connections are in the form:   .pin(sig)
- verilog module of 5 lines, should not be independent module, but be inline in other modules. Unless it is special and appears dozens of time.
- verilog module over 500 lines, better be made hierarchical.
