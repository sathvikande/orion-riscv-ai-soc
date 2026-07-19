module orion_quantizer(
input logic [15:0] in_data,
output logic [7:0] out_data

);

always_comb begin

out_data=in_data[7:0];

end
endmodule

