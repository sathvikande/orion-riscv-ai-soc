module tb_orion_pc;
logic clk,rst;
logic [31:0] pc_next;
logic [31:0] pc;

orion_pc dut(
.clk(clk),.rst(rst),
.pc_next(pc_next),
.pc(pc)
);



always #5 clk=~clk;

initial begin

clk=0;
rst=1;
pc_next=32'b0;

#10;
rst=0;

pc_next=32'd4;
#10;

pc_next=32'd8;
#10;

pc_next=32'd12;
#10;

$finish;
end 
endmodule 



