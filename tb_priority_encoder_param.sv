module tb_priority_encoder_param;

    // Test with Width = 8
    logic [7:0] in_8;
    logic [2:0] out_8;
    logic       valid_8;

    priority_encoder_param #(
        .WIDTH(8)
    ) dut_8 (
        .in(in_8),
        .out(out_8),
        .valid(valid_8)
    );

    // Test with Width = 12 (shows non-power-of-2 capability)
    logic [11:0] in_12;
    logic [3:0]  out_12;
    logic        valid_12;

    priority_encoder_param #(
        .WIDTH(12)
    ) dut_12 (
        .in(in_12),
        .out(out_12),
        .valid(valid_12)
    );

    initial begin
        $display("Starting simulation for Parameterized Priority Encoder...");
        
        // --- Test Width = 8 ---
        $display("\n--- Testing 8-bit Priority Encoder ---");
        in_8 = 8'b0000_0000; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=0, Valid=0)", in_8, out_8, valid_8);

        in_8 = 8'b0000_0001; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=0, Valid=1)", in_8, out_8, valid_8);

        in_8 = 8'b0000_1010; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=3, Valid=1)", in_8, out_8, valid_8);

        in_8 = 8'b1010_0100; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=7, Valid=1)", in_8, out_8, valid_8);

        // --- Test Width = 12 ---
        $display("\n--- Testing 12-bit Priority Encoder ---");
        in_12 = 12'b0000_0000_0000; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=0, Valid=0)", in_12, out_12, valid_12);

        in_12 = 12'b0000_0100_0000; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=6, Valid=1)", in_12, out_12, valid_12);

        in_12 = 12'b1000_0000_0001; #10;
        $display("In: %b | Out: %d | Valid: %b (Expected: Out=11, Valid=1)", in_12, out_12, valid_12);

        $display("\nSimulation finished.");
        $finish;
    end

endmodule
