

# CRC

LFSR most common usage is CRC generation and check.

good explanation:
https://en.wikipedia.org/wiki/Linear-feedback_shift_register

## task 1
Your task is to implement LFSR described in pcrc.png 
it is CRC used in CAN-XL protocol to protect headers of frames.


## task 2
another lsfr:  FIBONACCI LSFR

run simulation to find out the cycle sequence length. 
(How many iterations till same combination appears again).
here is C code: 
#include <stdint.h>
unsigned lfsr_fib(void)
{
    uint16_t start_state = 0xACE1u;  /* Any nonzero start state will work. */
    uint16_t lfsr = start_state;
    uint16_t bit;                    /* Must be 16-bit to allow bit<<15 later in the code */
    unsigned period = 0;

    do
    {   /* taps: 16 14 13 11; feedback polynomial: x^16 + x^14 + x^13 + x^11 + 1 */
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u;
        lfsr = (lfsr >> 1) | (bit << 15);
        ++period;
    }
    while (lfsr != start_state);

    return period;
}

