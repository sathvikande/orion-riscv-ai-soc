//==================================================
// orion_alu.sv
// Complete 32-bit RISC-V ALU with MAC & SIMD support
//==================================================

module orion_alu(
    input  logic clk,
    input  logic reset,
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  alu_sel,
    output logic [31:0] y,
    output logic        zero
);

// 1. Internal registers for the pipeline MAC unit
logic [31:0] product;
logic [31:0] accumulator;

// 2. Sequential Logic: MAC Accumulator
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        product     <= 32'b0;
        accumulator <= 32'b0;
    end else begin
        product <= (a * b);
        if (alu_sel == 4'b0100) 
            accumulator <= accumulator + (a * b);
    end
end

// 3. Combinatorial Logic: Arithmetic, Logic, Shifts, Comparisons, SIMD
wire [4:0] shamt = b[4:0];
wire [7:0] simd0 = a[7:0]   + b[7:0];
wire [7:0] simd1 = a[15:8]  + b[15:8];
wire [7:0] simd2 = a[23:16] + b[23:16];
wire [7:0] simd3 = a[31:24] + b[31:24];

always_comb begin
    case(alu_sel)
        4'b0000: y = a + b;                                             // ADD
        4'b0001: y = a - b;                                             // SUB
        4'b0010: y = a | b;                                             // OR
        4'b0011: y = a & b;                                             // AND
        4'b0100: y = accumulator;                                       // MAC
        4'b0101: y = {simd3, simd2, simd1, simd0};                      // SIMD
        4'b0110: y = a ^ b;                                             // XOR
        4'b0111: y = a << shamt;                                        // SLL
        4'b1000: y = a >> shamt;                                        // SRL
        4'b1001: y = $signed(a) >>> shamt;                              // SRA
        4'b1010: y = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;         // SLT
        4'b1011: y = (a < b) ? 32'd1 : 32'd0;                           // SLTU
        4'b1100: y = b;                                                 // PASS-B (LUI)
        default: y = 32'b0;
    endcase
end

assign zero = (y == 32'b0);

endmodule
