


module uart_top (
    input clk,
    input rst_n,  // async reset
    input [15:0] baudrate,  // integer baudrate: divided the main clock to generate bit clock

    input rxd,    // incoming 
    output txd,   // outgoing 
    output [7:0] status,  // anybits You can think of
    input [7:0] txdata,   // byte to transmit, accepted when tx_empty is active
    output tx_empty,      // uart ready to accept another byte to transmit.
    input write_tx,      // push txdata byte to be transmitted.

    output [7:0] rxdata,   //  received byte
    output rx_valid,       //   rx byte is valid
    input read_rx,         //   clear the rx byte

    input enable_rx,       // optional: receive only when active
    input enable_tx,       // optional: transmit only when active
    input [7:0] fractional  // optional: fractional baudrate
);

// Your code here


endmodule
