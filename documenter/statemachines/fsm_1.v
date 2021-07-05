`timescale 1ns/1ns
module stepper1(clk, control, reset, warnbit, curr_state);
    input clk, reset;
    input [1:0] control;
    output warnbit;
    output [3:0] curr_state;
    
    wire reset;
    wire [1:0] control;
    reg warnbit;
    
    //Control bit inputs (cw, ccw)
    localparam same_state_ctrl = 2'd0;
    localparam clk_wise_ctrl = 2'd2;
    localparam counter_clk_wise_ctrl = 2'd1;
    localparam warn_state_ctrl = 2'd3;
    
    //State outputs
    localparam state_0 = 4'd5;
    localparam state_1 = 4'd1;
    localparam state_2 = 4'd9;
    localparam state_3 = 4'd8;
    localparam state_4 = 4'd10;
    localparam state_5 = 4'd2;
    localparam state_6 = 4'd6;
    localparam state_7 = 4'd4;
    
    reg [3:0] curr_state;
    
    always@(posedge clk)
    begin
        if (reset)
        begin
            curr_state = state_0;
        end
        else
        begin
            case (control)
                same_state_ctrl:
                begin
                    warnbit = 1'b0;
                    case (curr_state)
                        state_0: curr_state = state_0;
                        state_1: curr_state = state_1;
                        state_2: curr_state = state_2;
                        state_3: curr_state = state_3;
                        state_4: curr_state = state_4;
                        state_5: curr_state = state_5;
                        state_6: curr_state = state_6;
                        state_7: curr_state = state_7;
                        default: curr_state = state_0;
                    endcase
                end
                counter_clk_wise_ctrl:
                begin
                    warnbit = 1'b0;
                    case (curr_state)
                        state_0: curr_state = state_7;
                        state_1: curr_state = state_0;
                        state_2: curr_state = state_1;
                        state_3: curr_state = state_2;
                        state_4: curr_state = state_3;
                        state_5: curr_state = state_4;
                        state_6: curr_state = state_5;
                        state_7: curr_state = state_6;
                        default: curr_state = state_0;
                    endcase
                end
                clk_wise_ctrl:
                begin
                    warnbit = 1'b0;
                    case (curr_state)
                        state_0: curr_state = state_1;
                        state_1: curr_state = state_2;
                        state_2: curr_state = state_3;
                        state_3: curr_state = state_4;
                        state_4: curr_state = state_5;
                        state_5: curr_state = state_6;
                        state_6: curr_state = state_7;
                        state_7: curr_state = state_0;
                        default: curr_state = state_0;
                    endcase
                end
                warn_state_ctrl:
                begin
                    warnbit = 1'b1;
                    case (curr_state)
                        state_0: curr_state = state_0;
                        state_1: curr_state = state_1;
                        state_2: curr_state = state_2;
                        state_3: curr_state = state_3;
                        state_4: curr_state = state_4;
                        state_5: curr_state = state_5;
                        state_6: curr_state = state_6;
                        state_7: curr_state = state_7;
                        default: curr_state = state_0;
                    endcase
                end
            endcase
        end
    end
endmodule