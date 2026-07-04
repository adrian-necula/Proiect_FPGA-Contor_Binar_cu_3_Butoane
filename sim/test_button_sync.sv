`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 14:24:24
// Design Name: 
// Module Name: test_button_sync
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


module test_button_sync();
    logic clk;
    logic btn_in;
    logic btn_sync;
    
initial begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
    btn_in = 0;
    
    @(negedge clk);
    btn_in = 1;
    
    @(posedge clk);
    @(posedge clk);
    btn_in = 0;
    
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    
    $finish;
end

button_sync dut(
            .clk(clk),
            .btn_in(btn_in),
            .btn_sync(btn_sync)
            );
endmodule
