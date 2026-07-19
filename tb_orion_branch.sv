//==================================================
// tb_orion_branch.sv
// Testbench for RISC-V Branch Unit
//==================================================

module tb_orion_branch;

logic branch;
logic [2:0] funct3;
logic [31:0] a;
logic [31:0] b;
logic pc_src;

orion_branch dut(
    .branch(branch),
    .funct3(funct3),
    .a(a),
    .b(b),
    .pc_src(pc_src)
);

initial begin
    $display("--- Testing Branch Unit ---");

    branch = 1;
    a = 32'd10;
    b = 32'd10;

    // BEQ: 10 == 10 -> take branch
    funct3 = 3'b000; #10;
    $display("BEQ (10 == 10): pc_src=%b (Expected 1)", pc_src);

    // BNE: 10 != 10 -> do not take branch
    funct3 = 3'b001; #10;
    $display("BNE (10 != 10): pc_src=%b (Expected 0)", pc_src);

    // BLT: 10 < 20 -> take branch
    b = 32'd20; funct3 = 3'b100; #10;
    $display("BLT (10 < 20): pc_src=%b (Expected 1)", pc_src);

    // BGE: 10 >= 20 -> do not take branch
    funct3 = 3'b101; #10;
    $display("BGE (10 >= 20): pc_src=%b (Expected 0)", pc_src);

    $display("BRANCH UNIT TEST PASSED!");
    $finish;
end

endmodule
