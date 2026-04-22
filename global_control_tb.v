`timescale 1ns / 1ps

module global_control_tb;

    reg clk, rst, write_en;
    reg [1:0] mode_in;
    wire [1:0] mode_out;

    global_control uut (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .mode_in(mode_in),
        .mode_out(mode_out)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        write_en = 0;
        mode_in = 2'b00;

        #10 rst = 0;

        // Set COMFORT mode
        #10 write_en = 1;
        mode_in = 2'b00;

        #10 write_en = 0;

        // Change to LOCKDOWN mode
        #20 write_en = 1;
        mode_in = 2'b01;

        #10 write_en = 0;

        // Back to COMFORT
        #20 write_en = 1;
        mode_in = 2'b00;

        #10 write_en = 0;

        #50 $finish;
    end

endmodule