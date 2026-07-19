//==================================================
// orion_imem.sv
// Instruction Memory with RV32I + MAC/SIMD Test Suite
//==================================================

module orion_imem(
    input  logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] mem [0:15];
    wire [3:0] idx = addr[5:2];

    initial begin
        // 0: ADDI x1, x0, 10      (x1 = 10)
        mem[0]  = 32'h00A00093;

        // 4: ADDI x2, x0, 5       (x2 = 5)
        mem[1]  = 32'h00500113;

        // 8: ADD x3, x1, x2       (x3 = 10 + 5 = 15)
        mem[2]  = 32'h002081B3;

        // 12: SUB x4, x1, x2      (x4 = 10 - 5 = 5)
        mem[3]  = 32'h40208233;

        // 16: SW x3, 0(x0)        (Mem[0] = 15)
        mem[4]  = 32'h00302023;

        // 20: LW x5, 0(x0)        (x5 = Mem[0] = 15)
        mem[5]  = 32'h00002283;

        // 24: BEQ x3, x5, +8      (Branch to offset 8 if x3 == x5 -> skips mem[7])
        mem[6]  = 32'h00518463;

        // 28: ADDI x6, x0, 99     (Skipped if branch taken)
        mem[7]  = 32'h06300313;

        // 32: ADDI x7, x0, 42     (Branch target: x7 = 42)
        mem[8]  = 32'h02A00393;

        // 36: NOP / HALT
        mem[9]  = 32'h00000013;
        mem[10] = 32'h00000013;
        mem[11] = 32'h00000013;
        mem[12] = 32'h00000013;
        mem[13] = 32'h00000013;
        mem[14] = 32'h00000013;
        mem[15] = 32'h00000013;
    end

    assign instruction = mem[idx];

endmodule
