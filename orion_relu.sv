module orion_relu(
input logic signed [31:0] x,
output logic signed [31:0] y
);

always_comb begin
if(x<0)
y=32'd0;
else
y=x;

end 
endmodule 




