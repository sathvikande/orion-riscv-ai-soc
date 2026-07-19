module tb_orion_activation;
logic signed [15:0] x;
logic [1:0] act_sel;
logic signed [15:0] y;

orion_activation dut(
.x(x),
.act_sel(act_sel),
.y(y)

);

initial begin

x=-20;
act_sel=2'b00;
#10;

x=-20;
act_sel=2'b01;
#10;

x=-20;
act_sel=2'b01;
#10;

x=40;
act_sel=2'b01;
#10;

$finish;

end 
endmodule 

