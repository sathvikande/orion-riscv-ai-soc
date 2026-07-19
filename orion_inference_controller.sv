module orion_inference_controller(
input logic clk,rst,start,compute_done,clear,
output logic compute_en,done,

output logic [1:0] act_sel

);

typedef enum logic [1:0] {
IDLE,
COMPUTE,
DONE
} state_t;

state_t current_state;
state_t next_state;

always_ff @(posedge clk) begin

if(rst)

current_state <= IDLE;

else

current_state <= next_state;

end

always_comb begin 
case(current_state)

IDLE : begin
if(start)

next_state = COMPUTE;

else

next_state = IDLE;

end

COMPUTE : begin

if(compute_done)
next_state = DONE;

else

next_state = COMPUTE;

end

DONE : begin

if(clear)

next_state = IDLE;

else

next_state = DONE;

end

default : next_state = IDLE;

endcase
end 

//output logic 

always_comb begin
compute_en=0;
done=0;
act_sel=2'b01;

case(current_state)

IDLE: begin
compute_en=0;
done=0;

end

COMPUTE: begin

compute_en=1;
done=0;

end

DONE : begin

compute_en=0;
done =1;

end

endcase

end 

endmodule 

