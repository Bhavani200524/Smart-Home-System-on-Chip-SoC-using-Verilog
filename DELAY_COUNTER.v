module delay_counter (
    input clk,
    input rst,
    input enable,
    output reg done
);

    reg [31:0] count;

    parameter DELAY = 32'd100; // small for simulation

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            done <= 0;
        end else if (enable) begin
            if (count < DELAY) begin
                count <= count + 1;
                done <= 0;
            end else begin
                done <= 1;
                count <= 0;
            end
        end else begin
            count <= 0;
            done <= 0;
        end
    end

endmodule