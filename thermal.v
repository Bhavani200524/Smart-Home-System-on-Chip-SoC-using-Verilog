`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 26.03.2026
// Design Name: Thermal Intelligence
// Description: HVAC control with hysteresis
//////////////////////////////////////////////////////////////////////////////////

module thermal_intelligence (
    input clk,
    input rst,
    input [7:0] temp_in,
    input [7:0] threshold,
    input [7:0] hysteresis,
    output reg cooling_on,
    output reg buzzer
);

    // State: 0 = NORMAL, 1 = OVERHEAT
    reg state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
            cooling_on <= 0;
            buzzer <= 0;
        end else begin
            case (state)

                // NORMAL STATE
                1'b0: begin
                    if (temp_in > threshold) begin
                        state <= 1;
                        cooling_on <= 1;
                        buzzer <= 1;
                    end
                end

                // OVERHEAT STATE
                1'b1: begin
                    // Safe hysteresis condition
                    if (temp_in + hysteresis < threshold) begin
                        state <= 0;
                        cooling_on <= 0;
                        buzzer <= 0;
                    end
                end

                default: state <= 0;

            endcase
        end
    end

endmodule