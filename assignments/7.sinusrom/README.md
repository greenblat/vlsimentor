


# verilog rom. 
**use script to generate verilog code**

inputs
- clk
- rst_n
- angle[7:0]  0 to 255 : 255 is 90 degrees.
outputs
- sinus[7:0]  0 to 255 : 255 is "1".

## idea
Write python script to generate the verilog module. You can use genver.py to generate it,
or write your own python script to generate the verilog code.

## pointers
-  this module can be made by long case statement. 
-  module can be written without clock and reset , or with them, sampling the output.





