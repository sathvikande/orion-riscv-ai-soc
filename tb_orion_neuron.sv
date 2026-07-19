//==================================================
// tb_orion_neuron.sv
// Testbench for Orion Artificial Neuron with ReLU
//==================================================

module tb_orion_neuron;

logic signed [7:0] x1, x2;
logic signed [7:0] w1, w2;
logic signed [7:0] bias;
logic signed [15:0] y;

orion_neuron dut(
    .x1(x1),
    .x2(x2),
    .w1(w1),
    .w2(w2),
    .bias(bias),
    .y(y)
);

initial begin 
    $display("--- Testing Neuron Block ---");

    // Test 1: Positive output
    x1 = 2; x2 = 3; w1 = 4; w2 = 5; bias = -2; #10;
    $display("Neuron Output: y=%d (Expected 21)", y);

    // Test 2: Negative sum -> ReLU output 0
    x1 = 1; x2 = 1; w1 = -5; w2 = -5; bias = 0; #10;
    $display("Neuron Output (ReLU clip): y=%d (Expected 0)", y);

    if (y == 0)
        $display("NEURON TEST PASSED!");
    else
        $display("NEURON TEST FAILED!");

    $finish;
end

endmodule
