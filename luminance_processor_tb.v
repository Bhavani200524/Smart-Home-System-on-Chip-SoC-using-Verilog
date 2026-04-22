`timescale 1ns / 1ps

module luminance_processor_tb;

    reg clk, rst;
    reg [7:0] light_in;
    reg [7:0] threshold;

    wire light_on;

    luminance_processor uut (
        .clk(clk),
        .rst(rst),
        .light_in(light_in),
        .threshold(threshold),
        .light_on(light_on)
    );

    // Clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        light_in = 0;
        threshold = 8'd50;

        #10 rst = 0;

        // 🌞 Bright light → OFF
        #10 light_in = 80;

        // 🌤️ Medium light → OFF
        #20 light_in = 60;

        // 🌙 Low light → ON
        #20 light_in = 30;

        // Noise (glitch) → filtered
        #10 light_in = 55;
        #10 light_in = 25;

        // Very low → ON stable
        #20 light_in = 20;

        // Back to bright → OFF
        #20 light_in = 70;

        #50 $finish;
    end

endmodule