module tb_orion_quantizer;

logic [15:0] in_data;
logic [7:0] out_data;

orion_quantizer dut(

.in_data(in_data),
.out_data(out_data)

);

initial begin 

in_data=8'd2;
#10;

in_data=8'd220;
#10;

in_data=8'd256;
#10;

$finish;

end
endmodule 
