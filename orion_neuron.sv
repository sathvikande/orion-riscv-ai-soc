module orion_neuron(
input logic signed [7:0] x1,
input logic signed [7:0] x2,
input logic signed [7:0] w1,
input logic signed [7:0] w2,

input logic signed [7:0] bias,

output logic signed [15:0] y
);

logic signed [15:0] sum;

always_comb begin

sum = (x1*w1) + (x2*w2) +bias;

if(sum<0)
y=16'd0;
else
y=sum;

end 
endmodule 

