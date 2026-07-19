module orion_nn_layer(
input logic signed [7:0] x1,
input logic signed [7:0] x2,

output logic signed [15:0] y0,
output logic signed [15:0] y1
);

orion_neuron neuron0(
.x1(x1),
.x2(x2),

.w1(8'd4),
.w2(8'd5),

.bias(-8'd2),

.y(y0)

);

orion_neuron neuron1(
.x1(x1),
.x2(x2),

.w1(8'd1),
.w2(8'd2),

.bias(8'd1),

.y(y1)

);

endmodule 

