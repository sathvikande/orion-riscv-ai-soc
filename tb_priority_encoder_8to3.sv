module tb_priority_encoder_8to3;

    logic [7:0] in;
    logic [2:0] out;
    logic       valid;

    // Instantiate Design Under Test (DUT)
    priority_encoder_8to3 dut (
        .in(in),
        .out(out),
        .valid(valid)
    );

    initial begin
        $display("Starting simulation for 8-to-3 Priority Encoder...");
        $display("Time | Input (Bin) | Output (Dec) | Valid");
        $display("-----------------------------------------");

        // Test all 256 input combinations
        for (int i = 0; i < 256; i++) begin
            in = 8'(i);
            #10; // Wait for logic propagation
            $display("%4t | %b |   %d |   %b", $time, in, out, valid);
        end

        $display("Simulation finished.");
        $finish;
    end

endmodule
