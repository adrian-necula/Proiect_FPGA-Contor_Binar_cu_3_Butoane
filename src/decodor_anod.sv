`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 12:45:42
// Design Name: 
// Module Name: decodor_anod
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


module decodor_anod(
    input logic [2:0] sel,
    output logic [7:0] an
    );
    
always_comb begin
    case (sel)
        0 : an = 8'b11111110;
        1 : an = 8'b11111101;
        2 : an = 8'b11111011;
        3 : an = 8'b11110111;
        4 : an = 8'b11101111;
        default : an = 8'b11111111;
    endcase
end

endmodule
