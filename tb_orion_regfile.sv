module tb_orion_regfile;

logic clk;
logic rst;
logic we;

logic [4:0] read_addr1;
logic [4:0] read_addr2;
logic [4:0] write_addr;

logic [31:0] write_data;

logic [31:0] read_data1;
logic [31:0] read_data2;

orion_regfile dut(

    .clk(clk),
    .rst(rst),
    .we(we),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),

    .write_data(write_data),

    .read_data1(read_data1),
    .read_data2(read_data2)

);

// Clock generation
always #5 clk = ~clk;

initial begin

    // Initial values
    clk         = 0;
    rst         = 1;
    we          = 0;

    read_addr1  = 5'b00000;
    read_addr2  = 5'b00000;
    write_addr  = 5'b00000;

    write_data  = 32'b0;

    // Hold reset
    #10;
    rst = 0;

    // Attempt to write 999 to x0 (should be ignored)
    we          = 1;
    write_addr  = 5'd0;
    write_data  = 32'd999;
    #10;

    // Write 15 into register 3
    we          = 1;
    write_addr  = 5'd3;
    write_data  = 32'd15;

    #10;

    // Write 25 into register 5
    write_addr  = 5'd5;
    write_data  = 32'd25;

    #10;

    // Disable write
    we = 0;

    // Read register 3 and 5
    read_addr1 = 5'd3;
    read_addr2 = 5'd5;
    #10;

    $display("x3 = %d (Expected 15), x5 = %d (Expected 25)", read_data1, read_data2);

    // Read register x0
    read_addr1 = 5'd0;
    #10;
    $display("x0 = %d (Expected 0)", read_data1);

    if (read_data1 == 0)
        $display("REGFILE TEST PASSED!");
    else
        $display("REGFILE TEST FAILED!");

    $finish;

end

endmodule
