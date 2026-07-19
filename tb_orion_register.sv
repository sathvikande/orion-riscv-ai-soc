module tb_orion_register;
logic clk,reset;
logic [3:0] d;
logic [3:0] q;

orion_register dut(
.clk(clk),.reset(reset),.d(d),.q(q)
);

always #5 clk=~clk;

initial begin 

clk=0;
reset=1;
d=4'b0000;

#10;
reset=0;

d=4'b1010;
#10;

d=4'b0101;
#10;

d=4'b1111;
#10;

$finish;

end 
endmodule 

