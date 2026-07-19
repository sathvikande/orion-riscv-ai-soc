module tb_orion_saturation_quantizer;

logic signed [15:0] in_data;
logic signed [7:0] out_data;

orion_saturation_quantizer dut (

.in_data(in_data),
.out_data(out_data)
);


initial begin

in_data=50;

#10;

in_data=200;

#10;


in_data=300;
#10;

in_data=-150;
#10;

in_data=-40;
#10;

$finish;

end
endmodule 

