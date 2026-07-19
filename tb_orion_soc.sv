//==================================================
// tb_orion_soc.sv
// Testbench for Integrated ORION RISC-V + AI Accelerator SoC
//==================================================

module tb_orion_soc;

logic clk;
logic rst;

logic nn_done;
logic signed [15:0] nn_y0;
logic signed [15:0] nn_y1;

orion_soc dut(
    .clk(clk),
    .rst(rst),
    .nn_done(nn_done),
    .nn_y0(nn_y0),
    .nn_y1(nn_y1)
);

always #5 clk = ~clk;

initial begin
    $display("=== STARTING INTEGRATED RISC-V + AI ACCELERATOR SoC SIMULATION ===");

    clk = 0;
    rst = 1;

    #12;
    rst = 0;

    $display("Time | PC       | CPU Reg x3 | NN Input (x1,x2) | NN Done | NN Output (y0, y1)");
    $display("-----------------------------------------------------------------------------");

    for (int i = 0; i < 15; i++) begin
        @(posedge clk);
        #1;
        $display("%4t | 0x%h | %10d | (%2d, %2d)       |    %b    | (%d, %d)",
            $time,
            dut.cpu_core.pc,
            dut.cpu_core.regfile_inst.regfile[3],
            dut.nn_x1, dut.nn_x2,
            nn_done,
            nn_y0, nn_y1
        );
    end

    $display("-----------------------------------------------------------------------------");
    $display(">>> SUCCESS: ORION RISC-V + AI ACCELERATOR SOC COMPLETED RUN! <<<");
    $finish;
end

endmodule
