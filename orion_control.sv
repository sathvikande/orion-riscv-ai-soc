//==================================================
// orion_control.sv
// Main Control Unit for RV32I Core
//==================================================

module orion_control(
    input  logic [6:0] op_code,

    output logic reg_write,
    output logic mem_write,
    output logic mem_read,
    output logic alu_src,
    output logic mem_to_reg,
    output logic [1:0] alu_op,
    output logic branch,
    output logic jump,
    output logic jalr,
    output logic lui
);

always_comb begin
    reg_write  = 0;
    mem_write  = 0;
    mem_read   = 0;
    alu_src    = 0;
    mem_to_reg = 0;
    alu_op     = 2'b00;
    branch     = 0;
    jump       = 0;
    jalr       = 0;
    lui        = 0;

    case(op_code)
        // R-type (ADD, SUB, OR, AND, XOR, SLL, SRL, SRA, SLT, SLTU, MAC, SIMD)
        7'b0110011: begin
            reg_write = 1;
            alu_src   = 0;
            alu_op    = 2'b10;
        end

        // I-type ALU (ADDI, ORI, ANDI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU)
        7'b0010011: begin
            reg_write = 1;
            alu_src   = 1;
            alu_op    = 2'b10;
        end

        // LOAD (LW, LH, LB, LHU, LBU)
        7'b0000011: begin
            reg_write  = 1;
            alu_src    = 1;
            mem_to_reg = 1;
            mem_read   = 1;
            alu_op     = 2'b00;
        end

        // STORE (SW, SH, SB)
        7'b0100011: begin
            mem_write = 1;
            alu_src   = 1;
            alu_op    = 2'b00;
        end

        // BRANCH (BEQ, BNE, BLT, BGE, BLTU, BGEU)
        7'b1100011: begin
            branch = 1;
            alu_src = 0;
            alu_op  = 2'b01;
        end

        // JAL
        7'b1101111: begin
            reg_write = 1;
            jump      = 1;
        end

        // JALR
        7'b1100111: begin
            reg_write = 1;
            jalr      = 1;
            alu_src   = 1;
            alu_op    = 2'b00;
        end

        // LUI
        7'b0110111: begin
            reg_write = 1;
            alu_src   = 1;
            lui       = 1;
            alu_op    = 2'b11;
        end

        // AUIPC
        7'b0010111: begin
            reg_write = 1;
            alu_src   = 1;
            alu_op    = 2'b00;
        end

        default: ;
    endcase
end

endmodule
