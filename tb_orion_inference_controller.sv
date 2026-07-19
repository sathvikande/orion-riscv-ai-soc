//==================================================
// tb_orion_inference_controller.sv
// Testbench for Orion AI Inference FSM Controller
//==================================================

module tb_orion_inference_controller;

logic clk, rst, start, compute_done, clear;
logic compute_en, done;
logic [1:0] act_sel;

orion_inference_controller dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .compute_done(compute_done),
    .clear(clear),
    .compute_en(compute_en),
    .done(done),
    .act_sel(act_sel)
);

always #5 clk = ~clk;

initial begin
    $display("--- Testing AI Inference Controller FSM ---");

    clk = 0;
    rst = 1;
    start = 0;
    compute_done = 0;
    clear = 0;

    #10;
    rst = 0;
    #10;

    // Trigger start: IDLE -> COMPUTE
    start = 1; #10;
    start = 0; #10;
    $display("State: COMPUTE -> compute_en=%b, done=%b", compute_en, done);

    // Compute complete: COMPUTE -> DONE
    compute_done = 1; #10;
    compute_done = 0; #10;
    $display("State: DONE -> compute_en=%b, done=%b", compute_en, done);

    // Clear flag: DONE -> IDLE
    clear = 1; #10;
    clear = 0; #10;
    $display("State: IDLE -> compute_en=%b, done=%b", compute_en, done);

    if (done == 0 && compute_en == 0)
        $display("INFERENCE CONTROLLER TEST PASSED!");
    else
        $display("INFERENCE CONTROLLER TEST FAILED!");

    $finish;
end 

endmodule
