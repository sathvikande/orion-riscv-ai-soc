module orion_matrix2x2 (

input logic [7:0] a00,
input logic [7:0] a01,
input logic [7:0] a10,
input logic [7:0] a11,


input logic [7:0] b00,
input logic [7:0] b01,
input logic [7:0] b10,
input logic [7:0] b11,

output logic [15:0] c00,
output logic [15:0] c01,
output logic [15:0] c10,
output logic [15:0] c11

);

always_comb begin
c00 = (a00 * b00) + (a01 * b10);
c01 = (a00 * b01) + (a01 * b11);
c10 = (a10 * b00) + (a11 * b10);
c11 = (a10 * b01) + (a11 * b11);
end 
endmodule 
