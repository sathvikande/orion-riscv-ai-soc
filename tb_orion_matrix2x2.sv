module tb_orion_matrix2x2;

logic [7:0] a00;
logic [7:0] a01;
logic [7:0] a10;
logic [7:0] a11;

logic [7:0] b00;
logic [7:0] b01;
logic [7:0] b10;
logic [7:0] b11;

logic [15:0] c00;
logic [15:0] c01;
logic [15:0] c10;
logic [15:0] c11;

orion_matrix2x2 dut(

.a00(a00),
.a01(a01),
.a10(a10),
.a11(a11),

.b00(b00),
.b01(b01),
.b10(b10),
.b11(b11),

.c00(c00),
.c01(c01),
.c10(c10),
.c11(c11)

);


initial begin

a00=1;
a01=2;
a10=3;
a11=4;

b00=5;
b01=6;
b10=7;
b11=8;

#10;
$display("Matrix Multiplication Result:");
$display("[%d %d] * [%d %d] = [%d %d]", a00, a01, b00, b01, c00, c01);
$display("[%d %d]   [%d %d]   [%d %d]", a10, a11, b10, b11, c10, c11);

if (c00 == 19 && c01 == 22 && c10 == 43 && c11 == 50)
    $display("TEST PASSED!");
else
    $display("TEST FAILED! Expected [19 22; 43 50]");

$finish;

end 
endmodule 

