//! This is a **multiline**
//! entity description using **MarkDown**
module documenter_basic_example #(
    parameter PARAM1 = 1024 //! number of bytes in fifo
)(
	//! description ***output*** port
    output reg [PARAM1-1:0] data, 
    input clk, //! 300Mhz Clock
    input rstn //! other description
);

localparam SN=11223344; //! SN for this node

//! Always example
always @(posedge clk or negedge rstn) begin: myproc
end

//! Instantiation example
mymodule dut(
    .rstn (rstn),
    .clk (clk)
);

//! Function example
function reg[1:0] myfunc(input a,b);
    myfunc = {a,b};
endfunction


endmodule