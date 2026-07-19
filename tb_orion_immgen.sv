//==================================================
// tb_orion_immgen.sv
// Testbench for RISC-V Immediate Generator
//==================================================

module tb_orion_immgen;

logic [31:0] instruction;
logic [31:0] imm_out;

orion_immgen dut(
    .instruction(instruction),
    .imm_out(imm_out)
);

initial begin
    $display("--- Testing Immediate Generator ---");

    // 1. I-type: addi x1, x0, 10 -> 0x00A00093
    instruction = 32'h00A00093;
    #10;
    $display("I-type: Inst=0x%h, Imm=%d (Expected 10)", instruction, $signed(imm_out));

    // 2. S-type: sw x2, 8(x1) -> rs2=2, rs1=1, imm[11:5]=0, imm[4:0]=8, opcode=0100011 -> 0x00208423
    instruction = 32'h00208423;
    #10;
    $display("S-type: Inst=0x%h, Imm=%d (Expected 8)", instruction, $signed(imm_out));

    // 3. B-type: beq x1, x2, 16 -> offset 16 -> 0x00208863
    instruction = 32'h00208863;
    #10;
    $display("B-type: Inst=0x%h, Imm=%d (Expected 16)", instruction, $signed(imm_out));

    // 4. U-type: lui x1, 0x12345 -> 0x123450B7
    instruction = 32'h123450B7;
    #10;
    $display("U-type: Inst=0x%h, Imm=0x%h (Expected 0x12345000)", instruction, imm_out);

    // 5. J-type: jal x1, 100 -> offset 100 -> 0x064000EF
    instruction = 32'h064000EF;
    #10;
    $display("J-type: Inst=0x%h, Imm=%d (Expected 100)", instruction, $signed(imm_out));

    $display("IMMGEN TEST COMPLETED SUCCESSFULLY!");
    $finish;
end

endmodule
