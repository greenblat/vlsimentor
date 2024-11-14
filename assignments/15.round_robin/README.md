
# ROUND ROBIN

Very popular module to arbitrate multiple requests.
If on this clock we granted request "I", on next clock we will grant
request "I+(first active request)"
this will go on in cirular fasion.


`module round_robin #(parameter WID=16) (
     input clk, input rst_n
    ,input [WID-1:0] requests
    ,output [WID-1:0] grants
);
endmodule
`

- Assume requests come in random order and frequency.
- Some clocks are have no requests, some clocks have many requests.
- tip:  {requests,requests}
