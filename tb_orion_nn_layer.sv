//==================================================
// tb_orion_nn_layer.sv
// Testbench for 2-Neuron NN Layer
//==================================================

module tb_orion_nn_layer;

logic signed [7:0] x1;
logic signed [7:0] x2;

logic signed [15:0] y0;
logic signed [15:0] y1;

orion_nn_layer dut(
    .x1(x1),
    .x2(x2),
    .y0(y0),
    .y1(y1)
);

initial begin 
    $display("--- Testing Neural Network Layer ---");

    x1 = 2;
    x2 = 3;
    #10;

    $display("NN Layer Outputs: y0=%d (Expected 21), y1=%d (Expected 9)", y0, y1);

    if (y0 == 21 && y1 == 9)
        $display("NN LAYER TEST PASSED!");
    else
        $display("NN LAYER TEST FAILED!");

    $finish;
end 

endmodule
