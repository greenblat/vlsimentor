



# verilog rom. 
**use script to generate code**

inputs
- clk
- rst_n
- angle[7:0]  0 to 255 : 255 is 90 degrees.
outputs
- sinus[7:0]  0 to 255 : 255 is "1".

## idea
Use genver.py to generate the table itself.
or write Your own script to generate the verilog

## pointers
-  this module can be made by long case statement. 
-  module can be written without clock and reset , or with them, sampling the output.





