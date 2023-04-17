
# APB interface

very popular slow bus interface,  suitable to hook register files and slow peripherals to central NOC.
NOC is network on the chip.

read APB standard in docs.

inputs:
    pclk
    paddr[9:0]
    psel
    pwrite
    penable
    pwdata[31:0]
    pstrb / psize  [3:0]

outputs:
    pready
    pslverr
    prdata[31:0]


internally we have ram:  10 address bits, 31 data bits,
This ram should be written / read from APB interface according to APB protocol.

Tips:

- APB protocol can be messy and too variant. Implement simple / basic stuff. When in doubt - choose easy path.
- pstrb or psize - not mandatory to implement. otherwise byte-enabled write of the ram is needed.
- address must be word aligned. two LSB address lines should be disregarded.

