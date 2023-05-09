module virtualbus (
    //! @virtualbus m00_axi4_stream @dir in
    //! tdata of stream
    input [7:0] m00_tdata,
    //! valid of stream
    input   m00_tvalid,
    //! id of current message
    input [3:0] m00_tid,
    //! destination of packet
    input [3:0] m00_tdest,
    //! this device is ready to receive
    output reg m00_tready,
    //! @end

    input clk,
    input rstn
);

endmodule