//==================================================
// tb_orion_control.sv
// Testbench for Main Control Unit
//==================================================

module tb_orion_control;

logic [6:0] op_code;
logic reg_write;
logic mem_write;
logic mem_read;
logic alu_src;
logic mem_to_reg;
logic [1:0] alu_op;
logic branch;
logic jump;
logic jalr;
logic lui;

orion_control dut(
    .op_code(op_code),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .alu_src(alu_src),
    .mem_to_reg(mem_to_reg),
    .alu_op(alu_op),
    .branch(branch),
    .jump(jump),
    .jalr(jalr),
    .lui(lui)
);

initial begin
    $display("--- Testing Control Unit ---");

    // 1. R-Type
    op_code=7'b0110011; #10;
    $display("R-type: reg_write=%b, alu_src=%b, alu_op=%b (Expected 1, 0, 10)", reg_write, alu_src, alu_op);

    // 2. I-Type
    op_code=7'b0010011; #10;
    $display("I-type: reg_write=%b, alu_src=%b, alu_op=%b (Expected 1, 1, 10)", reg_write, alu_src, alu_op);

    // 3. Load
    op_code=7'b0000011; #10;
    $display("Load: reg_write=%b, mem_to_reg=%b, mem_read=%b (Expected 1, 1, 1)", reg_write, mem_to_reg, mem_read);

    // 4. Store
    op_code=7'b0100011; #10;
    $display("Store: mem_write=%b, alu_src=%b (Expected 1, 1)", mem_write, alu_src);

    // 5. Branch
    op_code=7'b1100011; #10;
    $display("Branch: branch=%b, alu_op=%b (Expected 1, 01)", branch, alu_op);

    // 6. JAL
    op_code=7'b1101111; #10;
    $display("JAL: reg_write=%b, jump=%b (Expected 1, 1)", reg_write, jump);

    $display("CONTROL UNIT TEST PASSED!");
    $finish;
end

endmodule
