`timescale 1ns / 1ps

module smart_home_soc_tb;

    reg clk, rst;
    reg [7:0] temp_in, light_in;
    reg motion, doorbell, arm;
    reg write_en;
    reg [1:0] mode_in;

    wire cooling_on, buzzer, light_on, alarm_led, pwm_out;

    smart_home_soc uut (
        .clk(clk),
        .rst(rst),
        .temp_in(temp_in),
        .light_in(light_in),
        .motion(motion),
        .doorbell(doorbell),
        .arm(arm),
        .write_en(write_en),
        .mode_in(mode_in),
        .cooling_on(cooling_on),
        .buzzer(buzzer),
        .light_on(light_on),
        .alarm_led(alarm_led),
        .pwm_out(pwm_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        temp_in = 40;
        light_in = 80;
        motion = 0;
        doorbell = 0;
        arm = 0;
        write_en = 0;
        mode_in = 2'b00;

        #10 rst = 0;

        // Comfort mode
        #10 write_en = 1; mode_in = 2'b00;
        #10 write_en = 0;

        // Temperature rise
        #20 temp_in = 60;

        // Low light
        #20 light_in = 30;

        // Arm system
        #20 arm = 1;

        // Motion detected
        #20 motion = 1;
        #10 motion = 0;

        // Doorbell press
        #20 doorbell = 1;
        #10 doorbell = 0;

        // Lockdown mode
        #50 write_en = 1; mode_in = 2'b01;
        #10 write_en = 0;

        #100 $finish;
    end

endmodule