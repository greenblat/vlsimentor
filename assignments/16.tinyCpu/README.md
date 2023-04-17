
# SEQUENCER (small Cpu)

- opcode of 9 bits
- data width 6 bits
- 8 registers 6 bits each
- opcodes:
000 LLL DDD   : set LLL literal to DDD register
001 SSS DDD   : SSS register ADD to DDD register
010 SSS DDD   : SSS register AND to DDD register
011 SSS DDD   : SSS register XOR to DDD register
100 LLL DDD   : LLL literal added to DDD register
101 LLL DDD   : jump LLL addresses forward if DDD register is not zero
110 XXX XXX   : Reserved for future, for now NOP
111 AAA AAA   : jump to AAAAAA program address




`module mycpu ( input clk, input rst_n
    ,input enable_run
    ,input [8:0] opcode
    ,output [5:0] prog_addr
    ,output reg [7:0] [5:0] regs
);
`

- tip: start with 3-4 clocks per instruction. We always can improve afterwards.


