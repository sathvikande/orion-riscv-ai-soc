module tb_orion_weight_mem;

logic [1:0] addr;
logic signed [7:0] data;

orion_weight_mem uut( 
.addr(addr),
.data(data)
);


initial begin

addr=2'b00;
#10;
addr=2'b01;
#10;

addr=2'b10;
#10;

$finish;

end
endmodule 

