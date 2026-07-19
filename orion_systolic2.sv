module orion_systolic2(

input logic clk,rst,

input logic [7:0] a0,b0,

output logic [15:0] acc0,acc1
);

logic [7:0] a_wire,b_wire;


orion_pe pe0(

.clk(clk),
.rst(rst),

.a_in(a0),
.b_in(b0),

.a_out(a_wire),
.b_out(b_wire),

.acc(acc0)

);

//PE1

orion_pe pe1(

.clk(clk),
.rst(rst),

.a_in(a_wire),
.b_in(b_wire),

.a_out(),
.b_out(),

.acc(acc1)

);

endmodule 


