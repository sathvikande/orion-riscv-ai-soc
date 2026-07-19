//==================================================
// orion_soc.sv
// Integrated System-on-Chip (SoC)
// Combines RISC-V RV32 Processor Core + AI Accelerator Coprocessor
//==================================================

module orion_soc(
    input logic clk,
    input logic rst,
    
    // External status outputs
    output logic nn_done,
    output logic signed [15:0] nn_y0,
    output logic signed [15:0] nn_y1
);

    //==================================================
    // RISC-V RV32 Core Instantiation
    //==================================================
    orion_rv32 cpu_core(
        .clk(clk),
        .rst(rst)
    );

    // Memory-mapped interface signals
    logic signed [7:0] nn_x1;
    logic signed [7:0] nn_x2;
    logic start_infer;
    logic compute_done;
    logic clear_infer;
    logic compute_en;
    logic [1:0] act_sel;

    // Decode CPU memory writes to control the AI Coprocessor
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            nn_x1 <= 8'sd0;
            nn_x2 <= 8'sd0;
            start_infer <= 1'b0;
            compute_done <= 1'b0;
            clear_infer <= 1'b0;
        end else begin
            // Memory address 0x10 (word 4 in dmem): Load feature inputs x1, x2
            if (cpu_core.mem_write && cpu_core.alu_result == 32'h00000010) begin
                nn_x1 <= cpu_core.read_data2[7:0];
                nn_x2 <= cpu_core.read_data2[15:8];
            end
            
            // Memory address 0x14 (word 5 in dmem): Start trigger
            if (cpu_core.mem_write && cpu_core.alu_result == 32'h00000014) begin
                start_infer <= 1'b1;
            end else begin
                start_infer <= 1'b0;
            end

            // Automatically simulate 1-cycle compute delay for NN layer
            if (compute_en) begin
                compute_done <= 1'b1;
            end else begin
                compute_done <= 1'b0;
            end
        end
    end

    //==================================================
    // AI Accelerator Coprocessor Controller
    //==================================================
    orion_inference_controller infer_ctrl (
        .clk(clk),
        .rst(rst),
        .start(start_infer),
        .compute_done(compute_done),
        .clear(clear_infer),
        .compute_en(compute_en),
        .done(nn_done),
        .act_sel(act_sel)
    );

    //==================================================
    // Neural Network Layer (2 Neurons with weights & bias)
    //==================================================
    orion_nn_layer nn_layer_inst (
        .x1(nn_x1),
        .x2(nn_x2),
        .y0(nn_y0),
        .y1(nn_y1)
    );

endmodule
