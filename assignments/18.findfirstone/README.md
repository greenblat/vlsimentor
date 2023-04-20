

# findFirstOne options

A new twist here = choose best design option using synthesis. This structure appears ample times in real hardware.

## basic request

`module findfirstone #(parameter WID=64, parameter OWID=$clog2(WID)) (`
    `input [WID-1:0] din, output [OWID-1:0] indx, output valid`
`);`

given this header, **indx** should have index of LSB "1" in din.
**valid** output indicates whether there is "1" at all.

for example if *din = 0b00100100*, then indx should be *2*.





## advanced request

write several options of this design. You can instance them in parallel in the testbench.
Which one is the best?

Synthesis and static timing might give a clue.
For synthesis You can use **yosys** = free synthesis tool. Ask me for help with this.
If no optional design is clear winner with synthesis, You can try static timing.

Both tools are mentioned in tools section.

