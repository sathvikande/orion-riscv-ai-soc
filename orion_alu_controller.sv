//==================================================
// orion_alu_controller.sv
// Decodes ALU control signals for RV32I & custom operations
//==================================================

module orion_alu_controller(
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_sel
);

    always_comb begin
        case (alu_op)
            2'b00: alu_sel = 4'b0000; // ADD (Load / Store / AUIPC)
            2'b01: alu_sel = 4'b0001; // SUB (Branch comparison)
            2'b11: alu_sel = 4'b1100; // PASS-B (LUI)
            2'b10: begin // R-type / I-type instructions
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_sel = 4'b0001; // SUB
                        else
                            alu_sel = 4'b0000; // ADD / ADDI
                    end
                    3'b001: alu_sel = 4'b0111; // SLL / SLLI
                    3'b010: alu_sel = 4'b1010; // SLT / SLTI
                    3'b011: alu_sel = 4'b1011; // SLTU / SLTIU
                    3'b100: alu_sel = 4'b0110; // XOR / XORI
                    3'b101: begin
                        if (funct7 == 7'b0100000)
                            alu_sel = 4'b1001; // SRA / SRAI
                        else if (funct7 == 7'b0000001)
                            alu_sel = 4'b0100; // MAC custom operation
                        else
                            alu_sel = 4'b1000; // SRL / SRLI
                    end
                    3'b110: alu_sel = 4'b0010; // OR / ORI
                    3'b111: begin
                        if (funct7 == 7'b0000001)
                            alu_sel = 4'b0101; // SIMD custom operation
                        else
                            alu_sel = 4'b0011; // AND / ANDI
                    end
                    default: alu_sel = 4'b0000;
                endcase
            end
            default: alu_sel = 4'b0000;
        endcase
    end

endmodule
