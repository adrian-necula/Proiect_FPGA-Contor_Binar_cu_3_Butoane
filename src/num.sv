`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 12:31:00
// Design Name: 
// Module Name: num
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


module num(
    input logic rst,
    input logic clk,
    output logic [19:0] count
    );
    
always_ff @(posedge clk) begin
    if (rst) count <= 0;
    else count <= count + 1;
end

endmodule
