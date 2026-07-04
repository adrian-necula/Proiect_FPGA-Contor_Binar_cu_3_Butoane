`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2026 11:43:50
// Design Name: 
// Module Name: test_edge_detector
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


module test_edge_detector();
logic clk;
logic signal_in;
logic pulse_out;

initial begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
    signal_in = 0;
    @(negedge clk);
    @(negedge clk);
    
    signal_in = 1;
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    
    signal_in = 0;
    @(negedge clk);
    @(negedge clk);
    
    signal_in = 1;
    @(negedge clk);
    @(negedge clk);
    
    signal_in = 0;
    @(negedge clk);
    @(negedge clk);
    
    #20;
    $finish;
        
end

edge_detector dut(
                .clk(clk),
                .signal_in(signal_in),
                .pulse_out(pulse_out)
                );
endmodule
