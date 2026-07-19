module tb_orion_mac;
logic clk;
logic rst;
logic [31:0] a;
logic [31:0] b;
logic mac_en;
logic [31:0] y;

orion_mac dut(
.clk(clk),
.rst(rst),
.a(a),
.b(b),
.mac_en(mac_en),
.y(y)
);

always #5 clk= ~clk;

initial begin 
clk=0;
rst=1;
#10;
rst=0;

mac_en=1;

a=5;
b=2;

#10;

a=3;
b=4;

#10;

a=2;
b=10;

#10;

$finish;

end 
endmodule



