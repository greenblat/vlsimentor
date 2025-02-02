


# verilog rom. 
**use script to generate verilog code**

inputs
- clk
- rst_n
- angle[7:0]  0 to 255 : 255 is 90 degrees.
outputs
- sinus[7:0]  0 to 255 : 255 is "1".

## idea
Write python script to generate the verilog module. You can use genver.py to generate it,
or write your own python script to generate the verilog code.

## pointers
-  this module can be made by long case statement. 
-  module can be written without clock and reset , or with them, sampling the output.

## example of template:
```plaintext
module sinusrom(  
    input clk  
    ,input rst_n  
    ,input [7:0] angle  
    ,output reg [7:0] sinus  
);

wire [7:0] dout;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sinus <= 0;
    end else begin
        sinus <= dout;
    end
end

assign dout = (angle == 255) ? 255 :
                (angle == 254) ? <continue code using script>
                ...
                (angle == 0) ? 0 : 8'bx;

endmodule
םופ
```



