//==================================================
// tb_orion_rv32.sv
// Top Testbench for ORION RV32 CPU
//==================================================

module tb_orion_rv32;

logic clk;
logic rst;

orion_rv32 dut(
    .clk(clk),
    .rst(rst)
);

// Clock Generation: 10ns period
always #5 clk = ~clk;

initial begin
    $display("=== STARTING ORION RV32 CPU SIMULATION ===");

    clk = 0;
    rst = 1;

    // Reset processor
    #12;
    rst = 0;

    $display("Time | PC       | Inst       | Reg Write | Write Data | x1 | x2 | x3 | x4 | x5 | x6 | x7");
    $display("-----------------------------------------------------------------------------------------");

    for (int i = 0; i < 15; i++) begin
        @(posedge clk);
        #1;
        $display("%4t | 0x%h | 0x%h |     %b     | 0x%h | %2d | %2d | %2d | %2d | %2d | %2d | %2d",
            $time, dut.pc, dut.instruction, dut.reg_write, dut.write_back_data,
            dut.regfile_inst.regfile[1], dut.regfile_inst.regfile[2],
            dut.regfile_inst.regfile[3], dut.regfile_inst.regfile[4],
            dut.regfile_inst.regfile[5], dut.regfile_inst.regfile[6],
            dut.regfile_inst.regfile[7]
        );
    end

    $display("-----------------------------------------------------------------------------------------");
    if (dut.regfile_inst.regfile[1] == 10 &&
        dut.regfile_inst.regfile[2] == 5 &&
        dut.regfile_inst.regfile[3] == 15 &&
        dut.regfile_inst.regfile[4] == 5 &&
        dut.regfile_inst.regfile[5] == 15 &&
        dut.regfile_inst.regfile[6] == 0 &&  // Skipped by BEQ branch!
        dut.regfile_inst.regfile[7] == 42)   // Target of BEQ branch!
    begin
        $display(">>> SUCCESS: RISC-V RV32 CPU EXECUTED INSTRUCTIONS & BRANCHES PERFECTLY! <<<");
    end else begin
        $display(">>> FAILURE: REGISTER RESULTS DO NOT MATCH EXPECTED VALUES! <<<");
    end

    $finish;
end

endmodule
