module luminance_processor (
    input clk,
    input rst,
    input [7:0] light_in,        // ambient light sensor
    input [7:0] threshold,       // light threshold
    output reg light_on          // LED control
);

    // Low-pass filter (simple moving average)
    reg [7:0] prev1, prev2;
    wire [9:0] avg;

    assign avg = (light_in + prev1 + prev2) / 3;

    // Glitch-free state
    reg state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev1 <= 0;
            prev2 <= 0;
            state <= 0;
            light_on <= 0;
        end else begin
            // Shift register for filter
            prev2 <= prev1;
            prev1 <= light_in;

            // Decision logic (low light → turn ON)
            if (avg < threshold)
                state <= 1;
            else
                state <= 0;

            // Edge-aligned output (synchronous update)
            light_on <= state;
        end
    end

endmodule