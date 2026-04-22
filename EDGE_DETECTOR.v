module edge_detect (
    input clk, rst,
    input in,
    output reg pulse
);

    reg prev;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev <= 0;
            pulse <= 0;
        end else begin
            pulse <= in & ~prev;
            prev <= in;
        end
    end

endmodule