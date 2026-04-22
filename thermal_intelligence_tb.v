`timescale 1ns / 1ps

module thermal_intelligence_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [7:0] temp_in;
    reg [7:0] threshold;
    reg [7:0] hysteresis;

    // Outputs
    wire cooling_on;
    wire buzzer;

    // Instantiate DUT (Device Under Test)
    thermal_intelligence uut (
        .clk(clk),
        .rst(rst),
        .temp_in(temp_in),
        .threshold(threshold),
        .hysteresis(hysteresis),
        .cooling_on(cooling_on),
        .buzzer(buzzer)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        temp_in = 0;
        threshold = 8'd50;
        hysteresis = 8'd5;

        // Reset release
        #10 rst = 0;

        // 🟢 Case 1: Normal temperature
        #10 temp_in = 40;

        // 🔴 Case 2: Cross threshold → ON
        #20 temp_in = 55;

        // 🔄 Case 3: Slight drop (still ON due to hysteresis)
        #20 temp_in = 52;

        // 🔄 Case 4: Near threshold but still ON
        #20 temp_in = 47;

        // 🟢 Case 5: Below hysteresis → OFF
        #20 temp_in = 40;

        // 🔴 Case 6: Again high → ON
        #20 temp_in = 60;

        // 🟢 Case 7: Drop again → OFF
        #20 temp_in = 35;

        #50 $finish;
    end

endmodule