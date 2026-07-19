module tb_orion_relu;
logic [31:0] x;
logic [31:0] y;

orion_relu dut(
.x(x),
.y(y)
);

initial begin 
x=-10;
#10;

x=-2;
#10;

x=25;
#10;

x=30;
#10;

$finish;

end 
endmodule 


