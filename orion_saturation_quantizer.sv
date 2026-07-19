module orion_saturation_quantizer(

input logic signed [15:0] in_data,
output logic signed [7:0] out_data

);

always_comb begin

if(in_data > 127)

out_data=8'sd127;

else if (in_data < -128)

out_data=-8'sd128;

else

out_data=in_data[7:0];

end
endmodule 


