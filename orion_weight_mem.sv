module orion_weight_mem(
input logic [1:0] addr,
output logic signed [7:0] data
);

always_comb begin

case(addr)

2'b00 : data=8'd4;
2'b01 : data=8'd5;

2'b10 : data=-8'd2;

default : data=8'd0;

endcase

end
endmodule

