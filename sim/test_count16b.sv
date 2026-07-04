`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2026 16:12:22
// Design Name: 
// Module Name: test_count16b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_count16b();
    logic clk; 
    logic rst;
    logic inc; 
    logic dec;
    logic [15:0] count;
initial begin 
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
    rst = 1;
    inc = 0;
    dec = 0;

    @(posedge clk);
    @(posedge clk);

    @(negedge clk);
    rst = 0;

    // incrementare: count = 1
    @(negedge clk);
    inc = 1;
    @(negedge clk);
    inc = 0;

    // incrementare: count = 2
    @(negedge clk);
    inc = 1;
    @(negedge clk);
    inc = 0;

    // incrementare: count = 3
    @(negedge clk);
    inc = 1;
    @(negedge clk);
    inc = 0;

    // decrementare: count = 2
    @(negedge clk);
    dec = 1;
    @(negedge clk);
    dec = 0;

    // inc si dec simultan: count = 2
    @(negedge clk);
    inc = 1;
    dec = 1;
    @(negedge clk);
    inc = 0;
    dec = 0;

    // reset: count = 0
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;

    // incrementare: count = 1
    @(negedge clk);
    inc = 1;
    @(negedge clk);
    inc = 0;

    #20;
    $finish;
end

counter16b dut(
    .clk(clk),
    .rst(rst),
    .inc(inc),
    .dec(dec),
    .count(count)
);
endmodule
