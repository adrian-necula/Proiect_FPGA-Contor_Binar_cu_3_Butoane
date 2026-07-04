`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2026 11:02:33
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
    input logic clk,
    input logic signal_in,
    output logic pulse_out
    );
    
logic signal_old = 0;

always_ff @(posedge clk) begin
        pulse_out <= signal_in && !signal_old;
        signal_old <= signal_in;
    end
endmodule
