`timescale 1ns / 1ps

module security_fsm_tb;

    reg clk, rst, arm, motion;
    wire alarm_led, buzzer;

    security_fsm uut (
        .clk(clk),
        .rst(rst),
        .arm(arm),
        .motion(motion),
        .alarm_led(alarm_led),
        .buzzer(buzzer)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        arm = 0; motion = 0;

        #10 rst = 0;

        // NORMAL → ARMED
        #10 arm = 1;

        // No motion yet
        #20 motion = 0;

        // Motion detected → ALARM
        #10 motion = 1;
        #10 motion = 0;

        // Stay in alarm
        #100;

        // Disarm → back to NORMAL
        #10 arm = 0;

        #50 $finish;
    end

endmodule