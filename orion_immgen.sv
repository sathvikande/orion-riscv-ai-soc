//==================================================
// orion_immgen.sv
// Implements full RV32I immediate generation (I, S, B, U, J types)
//==================================================

module orion_immgen(
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);

    wire [6:0] opcode = instruction[6:0];

    wire [31:0] imm_i = {{20{instruction[31]}}, instruction[31:20]};
    wire [31:0] imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    wire [31:0] imm_b = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    wire [31:0] imm_u = {instruction[31:12], 12'b0};
    wire [31:0] imm_j = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};

    always_comb begin
        case(opcode)
            7'b0010011, 7'b0000011, 7'b1100111: imm_out = imm_i;
            7'b0100011:                         imm_out = imm_s;
            7'b1100011:                         imm_out = imm_b;
            7'b0110111, 7'b0010111:             imm_out = imm_u;
            7'b1101111:                         imm_out = imm_j;
            default:                            imm_out = imm_i;
        endcase
    end

endmodule
