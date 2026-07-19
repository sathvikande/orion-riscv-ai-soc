//==================================================
// orion_dmem.sv
// Data Memory Module
//==================================================

module orion_dmem(
    input  logic clk,
    input  logic we,
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

    logic [31:0] mem [0:15];
    wire [3:0] idx = addr[5:2];

    always_ff @(posedge clk) begin
        if(we)
            mem[idx] <= write_data;
    end

    assign read_data = mem[idx];

endmodule
