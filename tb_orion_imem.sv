//==================================================
// tb_orion_imem.sv
//==================================================

module tb_orion_imem;

logic [31:0] addr;
logic [31:0] instruction;

orion_imem dut(

    .addr(addr),
    .instruction(instruction)

);

initial begin

    // Instruction 0
    addr = 32'd0;
    #10;

    // Instruction 1
    addr = 32'd4;
    #10;

    // Instruction 2
    addr = 32'd8;
    #10;

    // Instruction 3
    addr = 32'd12;
    #10;

    // Instruction 4 (MAC)
    addr = 32'd16;
    #10;

    $finish;

end

endmodule
