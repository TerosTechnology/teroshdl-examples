//! This is a **Wavedrom** example:
//! { signal: [
//!   { name: "pclk", wave: 'p.......' },
//!   { name: "Pclk", wave: 'P.......' },
//!   { name: "nclk", wave: 'n.......' },
//!   { name: "Nclk", wave: 'N.......' },
//!   {},
//!   { name: 'clk0', wave: 'phnlPHNL' },
//!   { name: 'clk1', wave: 'xhlhLHl.' },
//!   { name: 'clk2', wave: 'hpHplnLn' },
//!   { name: 'clk3', wave: 'nhNhplPl' },
//!   { name: 'clk4', wave: 'xlh.L.Hx' },
//! ]}

module wavedrom_example(q,qbar,clk,rst,sr);
	output reg q;
	output qbar;
	input clk, rst;
	input [1:0] sr;
endmodule