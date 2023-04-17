
# DFT

Stands for Design For Test. usually means either SCAN or BIST.
two assignments here.

![rambist.001](/Users/iliagreenblat/vlsifpga/assignments/2.DFT/rambist.001.jpeg)





![rambist.002](/Users/iliagreenblat/vlsifpga/assignments/2.DFT/rambist.002.jpeg)

## SCAN
look at dft graphics (svg or ps). This is simplification of SCAN used in all ASICS.

![dft](/Users/iliagreenblat/vlsifpga/assignments/2.DFT/dft.svg)

- first shift register (built with flops) is loaded with some pattern.
- all this time, "shift" input keeps all flops in shift mode from one to another.
- after the pattern is shifted in, one pulse of clock without shift.
- this captures the logic outputs.
- shift is continues to display the flops values to external world.

## BIST
refer to rambist.pdf



