//==================================================
// tb_orion_systolic2.sv
// Testbench for 1x2 Systolic Array
//==================================================

module tb_orion_systolic2;

logic clk, rst;
logic [7:0] a0, b0;
logic [15:0] acc0, acc1;

orion_systolic2 dut(
    .clk(clk),
    .rst(rst),
    .a0(a0),
    .b0(b0),
    .acc0(acc0),
    .acc1(acc1)
);

always #5 clk = ~clk;

initial begin 
    $display("--- Testing 1x2 Systolic Array ---");

    clk = 0;
    rst = 1;
    a0  = 0;
    b0  = 0;

    #10;
    rst = 0;

    // Cycle 1: a0=4, b0=3 -> PE0 receives (4,3), accumulates 12
    a0 = 4; b0 = 3; #10;
    $display("Cycle 1: acc0=%d, acc1=%d", acc0, acc1);

    // Cycle 2: a0=2, b0=5 -> PE0 receives (2,5), accumulates 10 (total 22). PE1 receives previous (4,3), accumulates 12
    a0 = 2; b0 = 5; #10;
    $display("Cycle 2: acc0=%d, acc1=%d", acc0, acc1);

    // Cycle 3: a0=1, b0=7 -> PE0 receives (1,7), accumulates 7 (total 29). PE1 receives previous (2,5), accumulates 10 (total 22)
    a0 = 1; b0 = 7; #10;
    $display("Cycle 3: acc0=%d, acc1=%d", acc0, acc1);

    #10;
    $display("Final Accumulators: acc0=%d, acc1=%d", acc0, acc1);
    if (acc0 == 29 && acc1 == 22)
        $display("SYSTOLIC ARRAY TEST PASSED!");
    else
        $display("SYSTOLIC ARRAY TEST FAILED!");

    $finish;
end

endmodule
