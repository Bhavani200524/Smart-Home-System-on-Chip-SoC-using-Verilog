`timescale 1ns / 1ps

module gate_control_tb;

    reg clk, rst, doorbell;
    wire pwm_out;

    gate_control uut (
        .clk(clk),
        .rst(rst),
        .doorbell(doorbell),
        .pwm_out(pwm_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; doorbell = 0;

        #10 rst = 0;

        // Press doorbell → OPEN
        #10 doorbell = 1;
        #10 doorbell = 0;

        // Wait for auto-close
        #200;

        // Press again
        #20 doorbell = 1;
        #10 doorbell = 0;

        #200 $finish;
    end

endmodule