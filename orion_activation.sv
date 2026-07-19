module orion_activation (

input logic signed [15:0] x,
input logic [1:0] act_sel,

output logic signed [15:0] y
);

always_comb begin

case(act_sel)
2'b00:

y=x;

2'b01: begin

if(x<0)
y=16'd0;
else
y=x;
end

2'b10: begin
if(x<0)
y= x>>>3;

else
y=x;
end

default y=x;

endcase
end
endmodule


