`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2026 15:57:35
// Design Name: 
// Module Name: counter16b
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


module counter16b(
    input logic clk,
    input logic rst,
    input logic inc,
    input logic dec,
    output logic [15:0] count
    );
    
    always_ff @(posedge clk) begin
        if (rst) begin
            count <= 0;
            end
            else if (inc && !dec) begin
                count <= count + 1;
                end
            else if (dec && !inc) begin
                count <= count - 1;
                end
    end
endmodule
