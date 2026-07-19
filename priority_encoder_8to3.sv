module priority_encoder_8to3 (
    input  logic [7:0] in,
    output logic [2:0] out,
    output logic       valid
);

    always_comb begin
        // Default assignments to prevent latches
        out   = 3'd0;
        valid = 1'b0;

        // Priority logic from MSB (7) down to LSB (0)
        if (in[7]) begin
            out   = 3'd7;
            valid = 1'b1;
        end else if (in[6]) begin
            out   = 3'd6;
            valid = 1'b1;
        end else if (in[5]) begin
            out   = 3'd5;
            valid = 1'b1;
        end else if (in[4]) begin
            out   = 3'd4;
            valid = 1'b1;
        end else if (in[3]) begin
            out   = 3'd3;
            valid = 1'b1;
        end else if (in[2]) begin
            out   = 3'd2;
            valid = 1'b1;
        end else if (in[1]) begin
            out   = 3'd1;
            valid = 1'b1;
        end else if (in[0]) begin
            out   = 3'd0;
            valid = 1'b1;
        end
    end

endmodule
