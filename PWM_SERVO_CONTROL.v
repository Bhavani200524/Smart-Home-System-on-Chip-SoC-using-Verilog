module pwm_servo_control (
    input clk,
    input rst,
    input trigger,
    input close_signal,
    output reg open_done,
    output reg pwm_out
);

    reg [19:0] counter;
    reg [19:0] duty;

    parameter OPEN  = 20'd15;  // open position
    parameter CLOSE = 20'd5;   // close position

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            duty <= CLOSE;
            open_done <= 0;
        end else begin
            counter <= counter + 1;

            if (trigger) begin
                duty <= OPEN;
                open_done <= 1;
            end

            if (close_signal) begin
                duty <= CLOSE;
                open_done <= 0;
            end
        end
    end

    always @(posedge clk) begin
        pwm_out <= (counter < duty);
    end

endmodule