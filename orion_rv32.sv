//==================================================
// orion_rv32.sv
// Complete 32-bit Single-Cycle RISC-V CPU Core
// Supports RV32I Base Instruction Set + MAC & SIMD
//==================================================

module orion_rv32(
    input logic clk,
    input logic rst
);

//==========================
// PC Signals
//==========================
logic [31:0] pc;
logic [31:0] pc_next;
logic [31:0] pc_plus4;
logic [31:0] pc_branch;
logic [31:0] pc_jump;

//==========================
// Instruction Signal
//==========================
logic [31:0] instruction;

//==========================
// Control Signals
//==========================
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
logic pc_src;

//==========================
// Register File Signals
//==========================
logic [31:0] read_data1;
logic [31:0] read_data2;

//==========================
// Immediate Generator
//==========================
logic [31:0] imm_out;

//==========================
// ALU Control & Signals
//==========================
logic [3:0] alu_sel;
logic [31:0] alu_in2;
logic [31:0] alu_result;
logic zero;

//==========================
// Data Memory Signals
//==========================
logic [31:0] mem_read_data;

//==========================
// Writeback Signal
//==========================
logic [31:0] write_back_data;
logic [31:0] wb_temp;

//==========================
// Program Counter
//==========================
orion_pc pc_inst(
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(pc)
);

//==========================
// PC Adder & Next PC Logic
//==========================
assign pc_plus4  = pc + 32'd4;
assign pc_branch = pc + imm_out;
assign pc_jump   = jalr ? (read_data1 + imm_out) : (pc + imm_out);
assign pc_next   = (jump | jalr) ? pc_jump : (pc_src ? pc_branch : pc_plus4);

//==========================
// Instruction Memory
//==========================
orion_imem imem_inst(
    .addr(pc),
    .instruction(instruction)
);

//==========================
// Main Control Unit
//==========================
orion_control control_inst(
    .op_code(instruction[6:0]),
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

//==========================
// Register File
//==========================
orion_regfile regfile_inst(
    .clk(clk),
    .rst(rst),
    .we(reg_write),
    .read_addr1(instruction[19:15]),
    .read_addr2(instruction[24:20]),
    .write_addr(instruction[11:7]),
    .write_data(write_back_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

//==========================
// Immediate Generator
//==========================
orion_immgen immgen_inst(
    .instruction(instruction),
    .imm_out(imm_out)
);

//==========================
// ALU Controller
//==========================
orion_alu_controller alu_control_inst(
    .alu_op(alu_op),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .alu_sel(alu_sel)
);

//==========================
// ALU Input MUX
//==========================
assign alu_in2 = (alu_src) ? imm_out : read_data2;

//==========================
// ALU
//==========================
orion_alu alu_inst(
    .clk(clk),
    .reset(rst),
    .a(read_data1),
    .b(alu_in2),
    .alu_sel(alu_sel),
    .y(alu_result),
    .zero(zero)
);

//==========================
// Branch Evaluation Unit
//==========================
orion_branch branch_inst(
    .branch(branch),
    .funct3(instruction[14:12]),
    .a(read_data1),
    .b(read_data2),
    .pc_src(pc_src)
);

//==========================
// Data Memory
//==========================
orion_dmem dmem_inst(
    .clk(clk),
    .we(mem_write),
    .addr(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

//==========================
// Writeback MUX
//==========================
assign wb_temp         = (mem_to_reg) ? mem_read_data : alu_result;
assign write_back_data = (jump | jalr) ? pc_plus4 : (lui ? imm_out : wb_temp);

endmodule
