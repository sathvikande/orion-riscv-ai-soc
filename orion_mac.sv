module orion_mac(
input logic clk,
input logic rst,

input logic [31:0] a,
input logic [31:0] b,

input logic mac_en,

output logic [31:0] y

);

always_ff @(posedge clk) begin

if(rst)
y<=32'b0;

else if (mac_en)
y<=y+(a*b);

end
endmodule 

