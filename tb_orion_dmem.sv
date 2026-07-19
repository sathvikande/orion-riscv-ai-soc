module tb_orion_dmem;
logic clk,we;
logic [31:0] addr,write_data;
logic [31:0] read_data;

orion_dmem dut(
.clk(clk),
.we(we),
.addr(addr),
.write_data(write_data),
.read_data(read_data)

);

always #5 clk=~clk;

initial begin

clk=0;
addr=32'd0;
we=0;
write_data=32'd0;


#10;
we=1;
addr=32'd5;
write_data=32'd54;

#10
we=0;
addr=32'd5;
#10;

$finish;

end
endmodule

