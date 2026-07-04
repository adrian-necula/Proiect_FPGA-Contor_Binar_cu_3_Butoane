`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 12:11:33
// Design Name: 
// Module Name: mux
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


module mux(
    input logic [3:0] digit0, digit1, digit2, digit3, digit4,
    input logic [2:0] sel,
    output logic [3:0] digit_out
    );
    
always_comb begin
    case (sel)
        0 : digit_out = digit0;
        1 : digit_out = digit1;
        2 : digit_out = digit2;
        3 : digit_out = digit3;
        4 : digit_out = digit4;
        default :  digit_out = 0;
    endcase
end

endmodule
