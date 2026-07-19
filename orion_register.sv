module orion_register(
input logic clk,reset,
input logic [3:0] d,
output logic [3:0] q
);

always_ff @(posedge clk) begin

if(reset)
q<=4'b0000;
else
q<=d;

end 
endmodule 

