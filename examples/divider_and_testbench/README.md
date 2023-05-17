
# Annotated code of module and testbench 
My idea on how finished assignment should look like.
It is an attempt to explain how i see good environment. divided clearly into design and testbench.

- verilog module of divider 32 bits by 16 bits. result of 32 bits.
- testbench verilog that instances the divider and drives test cases.
- annotation of verilog constructs, especially where it is different from programming lanugages.
- the verification is easy, because golden model is trivial to compute in verilog. for other algorithms Python driven verification is better.


## Points
-  design is 32 / 32 integer, unsigned divider.
- golden model is easy:   a / b --->   result,remainder.
- testbench randomly invents pairs of arguments.
- it then proceeds to compare the results with expected: (a/b and a%b).
- the divider is ""run-to-completion"". it means when new job enters (through pulse of **vldin**) it becomes **busy**
   and cannot accept new jobs till busy goes down or **vldout** output pulses.
- it does 10000 computations. each correct comparison, increments **current** counter, incorrect comparison increments "wrongs" counter.
- there is **cycles** counter, that counts clocks. All counters are visible in $display() and in waves.
- by the way, this divider is part of some real silicon. Perhaps Your inverter conditioner is running it right now.
- advanced students can be curious about python verification version.


## Files
- **comp**     script to create iverilog (icarus) executable.
- **dump.vcd**	simnulation waves in VCD format.
- **rtl/**      verilog files
- **tb.vvp**	icarus executable
- **ver.log**   simulation run log
