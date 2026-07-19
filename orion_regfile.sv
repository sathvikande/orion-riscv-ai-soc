//==================================================
// orion_regfile.sv
//==================================================

module orion_regfile(

input logic clk,
input logic rst,
input logic we,

input logic [4:0] read_addr1,
input logic [4:0] read_addr2,
input logic [4:0] write_addr,

input logic [31:0] write_data,

output logic [31:0] read_data1,
output logic [31:0] read_data2

);

logic [31:0] regfile [31:0];

integer i;

always_ff @(posedge clk) begin

    if(rst) begin

        for(i=0; i<32; i=i+1)
            regfile[i] <= 32'b0;

    end

    else if(we && (write_addr != 5'd0)) begin

        regfile[write_addr] <= write_data;

    end

end

always_comb begin

    read_data1 = (read_addr1 == 5'd0) ? 32'b0 : regfile[read_addr1];
    read_data2 = (read_addr2 == 5'd0) ? 32'b0 : regfile[read_addr2];

end

endmodule
