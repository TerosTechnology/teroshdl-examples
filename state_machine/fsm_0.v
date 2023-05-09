module verilog_sm (
    input clk,
    input rstn
);

wire push_a_done;
wire push_b_done;
wire new_data;
wire crc_done;

typedef enum logic[1:0] {IDLE,PUSH_A,PUSH_B,CRC} state_t;
state_t state;
state_t nextstate;

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        state <= IDLE;
    end
    else begin
        state <= nextstate;
    end
end

always_comb begin
    case (state)
        IDLE: if(new_data) nextstate = PUSH_A;
        PUSH_A: begin
            if(push_a_done) nextstate = PUSH_B;
            else if (push_a_done&push_b_done) nextstate = CRC;
        end
        PUSH_B: if(push_b_done) nextstate = PUSH_M;
        CRC: nextstate= IDLE;
        default: nextstate = state;
    endcase
end
endmodule