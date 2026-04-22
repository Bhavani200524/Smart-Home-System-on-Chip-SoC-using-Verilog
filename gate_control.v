module gate_control (
    input clk,
    input rst,
    input doorbell,     // trigger input
    output pwm_out      // servo signal
);

    wire trigger;
    wire open_done;
    wire close_done;

    // Edge detector (doorbell press)
    edge_detect ED (
        .clk(clk),
        .rst(rst),
        .in(doorbell),
        .pulse(trigger)
    );

    // Delay counter (auto-close timing)
    delay_counter DC (
        .clk(clk),
        .rst(rst),
        .enable(open_done),
        .done(close_done)
    );

    // PWM servo controller
    pwm_servo_control PWM (
        .clk(clk),
        .rst(rst),
        .trigger(trigger),
        .close_signal(close_done),
        .open_done(open_done),
        .pwm_out(pwm_out)
    );

endmodule