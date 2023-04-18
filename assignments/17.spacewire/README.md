

# Spacewire
Basic functionality of spacewire like communication.
take a look at the pdf file in this directory.

## assignment

### transmitter
the header should look like this:
`module spwire_tx (input clk, input rst_n, input vldin, input [31:0] din`
    `,output tx0, output tx1`
`);`

Every time "vldin" pulses, the 32 bits of "din" are transmitted on outputs.

### receiver
the header should look like this:
`module spwire_rx (input clk, input rst_n, input rx0, input rx1`
    `,output vldout, output [31:0] dout, output [4:0] valid_bits` 
`);`

Every time 32 bits arrive, vldout is pulsed and dout cleared.
All the time, "dout" has all arrived bits (when less than 32) and "valid_bits"
displays the number of arrived bits. This is needed because, short bursts of data or
simple noise can disrupt the 32 bit boundaries.

## Tips
- Assume "clk" is much fastest changing signal in the system.
- Dont forget to synchronize async inputs
- When in doubt about assignment, assume most logical and simple resolution of the dilemmas.





