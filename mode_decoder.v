module mode_decoder (
    input [1:0] mode,
    output reg high_security,
    output reg normal_operation
);

    always @(*) begin
        case (mode)
            2'b00: begin // COMFORT
                normal_operation = 1;
                high_security = 0;
            end

            2'b01: begin // LOCKDOWN
                normal_operation = 0;
                high_security = 1;
            end

            default: begin
                normal_operation = 1;
                high_security = 0;
            end
        endcase
    end

endmodule