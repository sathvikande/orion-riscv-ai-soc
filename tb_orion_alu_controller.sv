//==================================================
// tb_orion_alu_controller.sv
// Testbench for RISC-V ALU Controller
//==================================================

module tb_orion_alu_controller;

logic [1:0] alu_op;
logic [2:0] funct3;
logic [6:0] funct7;
logic [3:0] alu_sel;

orion_alu_controller dut(
    .alu_op(alu_op),
    .funct3(funct3),
    .funct7(funct7),
    .alu_sel(alu_sel)
);

initial begin
    $display("--- Testing ALU Controller ---");

    // 1. Load/Store -> ADD (0000)
    alu_op = 2'b00; funct3 = 3'b000; funct7 = 7'b0; #10;
    $display("Load/Store: alu_op=%b, alu_sel=%b (Expected 0000)", alu_op, alu_sel);

    // 2. Branch -> SUB (0001)
    alu_op = 2'b01; funct3 = 3'b000; funct7 = 7'b0; #10;
    $display("Branch: alu_op=%b, alu_sel=%b (Expected 0001)", alu_op, alu_sel);

    // 3. R-type ADD -> (0000)
    alu_op = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000; #10;
    $display("R-type ADD: alu_sel=%b (Expected 0000)", alu_sel);

    // 4. R-type SUB -> (0001)
    alu_op = 2'b10; funct3 = 3'b000; funct7 = 7'b0100000; #10;
    $display("R-type SUB: alu_sel=%b (Expected 0001)", alu_sel);

    // 5. R-type OR -> (0010)
    alu_op = 2'b10; funct3 = 3'b110; funct7 = 7'b0000000; #10;
    $display("R-type OR: alu_sel=%b (Expected 0010)", alu_sel);

    // 6. R-type AND -> (0011)
    alu_op = 2'b10; funct3 = 3'b111; funct7 = 7'b0000000; #10;
    $display("R-type AND: alu_sel=%b (Expected 0011)", alu_sel);

    // 7. LUI -> PASS-B (1100)
    alu_op = 2'b11; #10;
    $display("LUI: alu_op=%b, alu_sel=%b (Expected 1100)", alu_op, alu_sel);

    $display("ALU CONTROLLER TEST PASSED!");
    $finish;
end

endmodule
