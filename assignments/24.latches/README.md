# Latches in RTL. 24

Latches are not common in RTL modules. But when they are needed, better know how to write them.
Also usually, latches occupy half area relative to flop.
Downside is they are not scannable by default.
Here is how latch appears:

    always @* begin
        if (en) ltc = data;
    end
    
## Assignment
    register file where registers are latches. 
    32bits x 8registers file.
    Single write port and single read port.
    The module interface looks like regular RAM/REGISTERFILE. Meaning "clk" is input and read data appears on the next posedge clock.

