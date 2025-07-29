**Please use .md viewer, like Typora or similar**
# Assignments
various level verilog exersizes.

some are simple, some are tricky.
the numbering order is almost random, as ideas came into my head.

write RTL, write testbench,  test it in real simulator. 
good luck.

my emai is greenblat@mac.com put there just the verilogs, i will take a look and comment.  Also there is no particular order to assignments. In all assignments,  please do best effort to fill undefined holes in specification by taking the most reasonable / simple path.

Every time You read specification of a new module, You will  notice undefined stuff, stuff that makes You ask questions. If there is "obvious" "reasonable" way to resolve it - take it and add a note.

Each assignment requires a design (module of verilog or hierarchy of them) and testbench to run the design. No one expects full verification (except maybe You) , but test of basic functionality.


| directory| general idea |
|-----|------|
| 1.ser2par |   |
| 2.DFT | mini scan or bist  |
| 3.busPermutator | tricky bus to bus permutation  |
| 4.parity | parity bits on a bus   |
| 5.Code2Verilog | python reference code to verilog  |
| 6.lsfr | pseudo random sequence  |
| 7.sinusrom | use script to generate rtl module  |
| 8.apb2ram | apb 2 ram : hook ram module to apb bus.  |
| 9.basic_fifo |   |
| 10.cordic | implement square root using cordic algorith. python reference.  |
| 11.dualFifo | fifo with high / low priority input  |
| 12.simple_uart | find UART basic description and give it a shot  |
| 13.encryption_using_lsfr | XOR between stream of data and LFSR pseudo random.   |
| 14.majority | basic math tricks  |
| 15.round_robin | design of fair resource allocation |
| 16.tinyCpu | design of tiny simple CPU |
| 17.spacewire | spacewire demo design  |
| 18.findfirstone | outputs position of first one in input vector |
| 19.reorderingFifo |  fifo with a twist |
| 20.floatingpointmultiplier | floating point (32bits) multiplierd design  |
| 21.ring_oscillator    | exercise in gate level simulation |
| 22.synchronizers      |  fast to slow pulse passing synch |
| 23.PLD      |  prgorammable logic device |
| 24.latches      |  latch based register file |
| 25.sharedFifo      |  four wide fifos share wide entries |
| 26.delay_line |  variable delay in clocks between data in to data out |
| 27.uart_baudrate_guess |  listen to uart transmission and guess it's baurate |
| 28.syncfifo      |  basic syncronous fifo |
| 29.pattern      |  pattern recognition in stream of bits |
