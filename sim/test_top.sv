`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2026 17:05:05
// Design Name: 
// Module Name: test_top
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


module test_top();
logic clk;
logic btn_inc;
logic btn_dec;
logic btn_rst;
logic [15:0] led;
logic [7:0] seg;
logic [7:0] an;

initial begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
        btn_inc = 0;
        btn_dec = 0;
        btn_rst = 0;

        repeat(5) @(negedge clk);

        // reset initial
        btn_rst = 1;
        repeat(10) @(negedge clk);
        btn_rst = 0;
        repeat(10) @(negedge clk);

        // incrementare
        btn_inc = 1;
        repeat(10) @(negedge clk);
        btn_inc = 0;
        repeat(10) @(negedge clk);

        // incrementare
        btn_inc = 1;
        repeat(10) @(negedge clk);
        btn_inc = 0;
        repeat(10) @(negedge clk);

        // decrementare
        btn_dec = 1;
        repeat(10) @(negedge clk);
        btn_dec = 0;
        repeat(10) @(negedge clk);

        // reset final
        btn_rst = 1;
        repeat(10) @(negedge clk);
        btn_rst = 0;
        repeat(10) @(negedge clk);

        #20;
        $finish;
end

top dut(
        .clk(clk),
        .btn_inc(btn_inc),
        .btn_dec(btn_dec),
        .btn_rst(btn_rst),
        .led(led),
        .seg(seg),
        .an(an)
        );
endmodule
