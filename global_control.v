module global_control (
    input clk,
    input rst,
    input write_en,           // write enable (like memory-mapped control)
    input [1:0] mode_in,      // external mode input
    output reg [1:0] mode_out // system-wide control word
);

    // Mode Encoding
    parameter COMFORT  = 2'b00;
    parameter LOCKDOWN = 2'b01;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mode_out <= COMFORT;
        end else if (write_en) begin
            mode_out <= mode_in;
        end
    end

endmodule