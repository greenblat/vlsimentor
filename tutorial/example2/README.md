
# UART basics
Two uarts head to head. One UART gets characters to transmit. They go to second UART and it loops them back.
So first UART is supposed to get them again.

## BAUDRATES.
Baudrate is the length of time it takes to send single bit. In this design the register called BAUDRATE holds
the division of the clock factor. 
So if the value of this register is 10, it takes 10 system clocks to transmit (or receive) one bit. Transmision of one byte
takes 10 bits (start bit zero, 8 data bits and one or more stop bits (ones)).

## Exercise

In this design You can set baudrates of two uarts to different frequencies ( different division factors (baudrate register values).
Dont make them less than 6.
The exercise is to determine what difference between baudrates will cause faulty reception. For example if one register is set to 100, what are the limit values of the second baudrate register, that ensure correct reception?



**This example uses python-driven-verification. Requires "C" compilation of shared library in vlsistuff/python-verilog repository.**
It is possible to make simple demo with pure verilog too, just modify the tb.v


