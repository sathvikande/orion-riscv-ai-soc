//==================================================
// orion_branch.sv
// Branch Decision Unit for RV32I (BEQ, BNE, BLT, BGE, BLTU, BGEU)
//==================================================

module orion_branch(
    input  logic branch,
    input  logic [2:0] funct3,
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic pc_src
);

    logic take_branch;

    always_comb begin
        case (funct3)
            3'b000: take_branch = (a == b);                        // BEQ
            3'b001: take_branch = (a != b);                        // BNE
            3'b100: take_branch = ($signed(a) < $signed(b));       // BLT
            3'b101: take_branch = ($signed(a) >= $signed(b));      // BGE
            3'b110: take_branch = (a < b);                         // BLTU
            3'b111: take_branch = (a >= b);                        // BGEU
            default: take_branch = 1'b0;
        endcase
    end

    assign pc_src = branch & take_branch;

endmodule
