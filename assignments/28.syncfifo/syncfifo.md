
## Assignment - synchronous FIFO

In this assignment you will be implementing a FIFO queue.

<u>_Inputs:_</u>  
**clk** - clock  
**rst\_n** - reset our queue.  
parameter - **WID** - width: size of elements to save in queue.  
parameter - **DEP** - depth: queue size.  
**din\[WID-1:0\]** - the data we want to push in our queue.  
**vldin** - when turned on we should save **din\[WID-1:0\]** in our queue.  
**readout** - pop the FIFO queue and remove it from the queue.
*Note: readout when queue is empty should return all zeros.*

<u>_outputs:_</u>  
**empty** - queue is empty.  
**full**\- we have reached **DEP** elements and queue is full.  
_Note: if full is on, we should ignore vldin and we cannot push any more elements to queue._  
**dout** - outputs the "oldest" element in FIFO queue.

parameters

- **WID** : define width of the data bus.
- **DEP** : define the depth of the fifo, that is the number of physical entries in the fifo.

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/b2997f3cf87633a6415079eea129ddc7df1bd75177f82381.PNG)

Here is a headstart:

```plaintext
module FIFO #(parameter WID = 8, DEP = 16)(  
    input clk  
    ,input rst_n  
    ,input din[WID-1:0]
    ,input vldin
    ,input readout
    ,output empty
    ,output full 
    ,output dout[WID-1:0] 
);
```
