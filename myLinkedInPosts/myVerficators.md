
My esteemed #verification professionals -
Especially those who verify my RTL.

I would like You to consider few suggestions of mine, that i believe will make my (and Yours) life easier and tape-outs closer.

The usual scenario is that my Verilog RTL modules are verified remotely. Mostly with SV+UVM. That by itself is not very productive, but i can’t change that. When test fails, what i get back are waves file and log file. That is what i work with to nail the bug.

Following are several suggestions to ease the debug process and allow me to see the daylight even during short winter days (used to be our kids, but they are all grown up now).



#1 : print clock number instead of simulation time in log messages.
 add something like: “int cycles;” to test-bench verilog code.
 Increment it on each posedge of the system clock. Specify this count as part of every UVM message info or error.

 Timescales today tend to be in ridiculously fine time units. So the time points reported in messages are too long and have too many zeroes. With shorter integer clock count it should be much easier to navigate as the count appears in the waves too.

#2: add counter to UVM error messages and have this count in waves too.
When UVM outputs an error, please add the relevant clock count, but also add the running number of this error message. Deposit this error number into error counts integer bus.
UVM error messages are cryptic enough, without the need to hunt them down across the simulation.
