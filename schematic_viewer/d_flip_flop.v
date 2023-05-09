// FPGA projects using Verilog/ VHDL 
// fpga4student.com
// Verilog code for D Flip FLop
// Verilog code for rising edge D flip flop 
module RisingEdge_DFlipFlop(D,clk,Q);
    input D; // Data input 
    input clk; // clock input 
    output Q; // output Q 

    always @(posedge clk) 
    begin
        Q <= D; 
    end 

endmodule 