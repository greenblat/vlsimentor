
# Guess UART traffic baudrate

- we have incoming RXD stream from UART.  assume 8 bit uart word, but that is not essential.
- we have high speed system clock. it is at least 16 times faster than RXD bit time.
- we define "baudrate" as number of system clocks that fit into one serial bit duration.

- Looking at RXD, and monitoring the low times, guess the baudrate.
- We dont control what goes on in the traffic. The traffic is random characters. 
- Baudrate can be any number, from 16 to 64K (16 bit). Baudrate is not limited to regular rates, like 9600.
- We may introduce confidence numeric output. We start with low confidence number. The confidence should grow with more significant traffic.  For example, "U" (capital U character is alternation of single zeros and ones. Character like that has low times exactly like baudrate. Yet the accuracy better served by longer low times (provided we can estimate how many bits they are).
  Because for single bit time, little jitter noise can be significant.





