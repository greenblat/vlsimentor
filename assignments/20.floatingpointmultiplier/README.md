

* 20. Floating point multitplier
Read floating point IEEE standard. Partial implementation is asked here.

- Clock and Reset.  the usuals.
- Two floating point inputs. 32 bits.
- vldin:  valid inputs, start computing. may take several clock.
- One floating point output. 
- vldout:  the output is valid. 

** points
- the design can be pipelined or "run-to-completion".  if needed. 
- 32 float format   {signbit,exponent[7:0],mantissa[22:0]} = floatin[31:0];
- mantissa has implied msb==1 , making it effectively 24 bits wide:   {1'b1,mantissa[22:0]}
- exponenti encoding: zero means -127,   other numbers values signify   (exponent-127)
- no need to treat extreme cases (NotANumber, overflow, underflow and such).
- zero is special case. look in provided verilog skeleton. It has no clocks by the way.

** flow
 - do sum exponents. notice strange encoding!
 - multiply mantisses.
 - renormalize resulting mantissa (leading one and shift which affects new exponent).
 - compute correct sign bit.

 ** bonus assignment
  - implememt float adder.

** testbench
in verilog, "real" variables are usually 64 bits. the mantissa is larger, but MSB of mantissas should be the same.








