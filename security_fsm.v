module security_fsm (
    input clk,
    input rst,
    input arm,            // system arm switch
    input motion,         // motion sensor input
    output reg alarm_led,
    output reg buzzer
);

    // FSM States
    parameter NORMAL = 2'b00;
    parameter ARMED  = 2'b01;
    parameter ALARM  = 2'b10;

    reg [1:0] state, next_state;

    // Edge detection for motion
    reg motion_prev;
    wire motion_pulse;

    assign motion_pulse = motion & ~motion_prev;

    // Clock divider signals
    wire slow_clk;   // LED strobe
    wire buzz_clk;   // 1kHz buzzer

    // Instantiate clock dividers
    clock_divider #(25_000_000) LED_DIV (clk, rst, slow_clk); // adjust based on FPGA clock
    clock_divider #(50_000)     BUZZ_DIV (clk, rst, buzz_clk);

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= NORMAL;
        else
            state <= next_state;
    end

    // Motion edge detect
    always @(posedge clk) begin
        motion_prev <= motion;
    end

    // Next state logic
    always @(*) begin
        case (state)
            NORMAL: next_state = (arm) ? ARMED : NORMAL;
            ARMED:  next_state = (motion_pulse) ? ALARM : ARMED;
            ALARM:  next_state = (arm == 0) ? NORMAL : ALARM;
            default: next_state = NORMAL;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            alarm_led <= 0;
            buzzer <= 0;
        end else begin
            case (state)
                NORMAL: begin
                    alarm_led <= 0;
                    buzzer <= 0;
                end

                ARMED: begin
                    alarm_led <= 0;
                    buzzer <= 0;
                end

                ALARM: begin
                    alarm_led <= slow_clk;  // blinking LED
                    buzzer <= buzz_clk;     // 1kHz tone
                end
            endcase
        end
    end

endmodule