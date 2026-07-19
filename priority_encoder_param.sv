module priority_encoder_param #(
    parameter int WIDTH = 8,
    parameter int OUT_WIDTH = $clog2(WIDTH)
) (
    input  logic [WIDTH-1:0]     in,
    output logic [OUT_WIDTH-1:0] out,
    output logic                 valid
);

    always_comb begin
        out   = '0;
        valid = 1'b0;
        // Loop from LSB to MSB. Higher indexes overwrite lower indexes, 
        // which naturally results in MSB-first priority.
        for (int i = 0; i < WIDTH; i++) begin
            if (in[i]) begin
                out   = OUT_WIDTH'(i);
                valid = 1'b1;
            end
        end
    end

endmodule
