//==================================================
// tb_orion_alu.sv
// Testbench for RISC-V 32-bit ALU
//==================================================

module tb_orion_alu;

logic clk;
logic reset;
logic [31:0] a;
logic [31:0] b;
logic [3:0] alu_sel;
logic [31:0] y;
logic zero;

orion_alu dut(
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .alu_sel(alu_sel),
    .y(y),
    .zero(zero)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    a = 32'd10;
    b = 32'd5;
    alu_sel = 4'b0000;
    #10;
    reset = 0;

    $display("--- Testing ALU ---");

    // 1. ADD: 10 + 5 = 15
    alu_sel = 4'b0000; #10;
    $display("ADD: 10 + 5 = %d, zero=%b (Expected 15, 0)", y, zero);

    // 2. SUB: 10 - 5 = 5
    alu_sel = 4'b0001; #10;
    $display("SUB: 10 - 5 = %d, zero=%b (Expected 5, 0)", y, zero);

    // 3. SUB equal: 10 - 10 = 0 -> zero=1
    b = 32'd10; alu_sel = 4'b0001; #10;
    $display("SUB Equal: 10 - 10 = %d, zero=%b (Expected 0, 1)", y, zero);

    // 4. OR: 10 | 5
    b = 32'd5; alu_sel = 4'b0010; #10;
    $display("OR: 10 | 5 = %d (Expected 15)", y);

    // 5. AND: 10 & 5
    alu_sel = 4'b0011; #10;
    $display("AND: 10 & 5 = %d (Expected 0)", y);

    // 6. XOR: 10 ^ 5
    alu_sel = 4'b0110; #10;
    $display("XOR: 10 ^ 5 = %d (Expected 15)", y);

    // 7. SIMD: [1,2,3,4] + [5,6,7,8]
    a = 32'h04030201; b = 32'h08070605; alu_sel = 4'b0101; #10;
    $display("SIMD: 0x%h + 0x%h = 0x%h (Expected 0x0c0a0806)", a, b, y);

    $display("ALU TEST COMPLETED!");
    $finish;
end

endmodule
