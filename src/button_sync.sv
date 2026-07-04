`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 14:03:52
// Design Name: 
// Module Name: button_sync
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


module button_sync(
    input logic clk,
    input logic btn_in,
    output logic btn_sync
    );
    
logic btn_meta = 0;

always_ff @(posedge clk) begin
        btn_meta <= btn_in;
        btn_sync <= btn_meta;
    end
    
endmodule
