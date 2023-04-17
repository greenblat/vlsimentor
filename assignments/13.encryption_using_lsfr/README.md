


# using LFSR as encryptor  / decryptor

simple to crack encryptor.

**Dont use it to encrypt ATM four digits.**

-find or write code for 32 bit LFSR. select reasonable feedback taps.
-or make feedback taps a parameter.
-each incoming byte is XORed with 8 bits of this lfsr and lfsr is advanced.


`module lfsr_crypt (`
    `input clk`
    `,input rst_n`
    `,input [31:0] initial_lfsr_state // small increase in safety`
    `,input [7:0] din`
    `,input vldin`
    `,input restart // reset the LFSR to initial (cosntraint: vldin negated)`

    `,output [7:0] dout`
    `,output vldout`
`);`

`....`
endmodule`

:
