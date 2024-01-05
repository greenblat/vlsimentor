
# PLD 30
porgammable logic device. May be viewed as FPGA's little sibling.

## Background
In every VLSI project, some degree of field programmability is desired.
Sometimes the standard is not completely frozen, sometimes interface to IP (internal or external) needs to be flexible and so on - 
reasons why there is need for programmability.
Here we are talking about implementation with bunch of inputs and bunch of  outputs, that their boolean function from inputs  can be configured in the field.
For this, we are ok to dedicate flops or latches to create the configuration. Imagine we have 30 inputs and 30 outputs. Obviously, it is not practical to implement all functions on all outputs.Some kind of practical solution is in order. 

## Project
In the first stage, we dont want any functional flops involved, only pure combinatorial transfer functions from inputs 
to outputs. 
Header of the design is in pld30.v file.

## Interface
There are just two pins to program internal setup flops. You may add few more.
The number 30 (of inputs and outputs) is not chosen randomly. It is not too small and not too big.
## Points
- configuration on power up can be done slowly and serially.
- quality of the solution will be judged by versatility of the solution versus number of resources (flops and combies) required.
- good design is also the one where increasing the number of inputs or outputs can be done easily.
- the confifguration is likely to come from NVM module (either on or off chip). This point is to make sure  it is doable by modest logical means.


## Later stages
- introduce functional flops (their functinality may be limited)
- flops may be utilized as inputs  (need to have a system clock).
- Create software to turn Verilog to programming file.
