`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 11:19:21
// Design Name: 
// Module Name: 7seg_decoder
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


module transcodor_7seg(
    input logic [3:0] digit,
    output logic [7:0] seg
    );

always_comb begin
    case (digit)
        0 : seg = 8'b00000011;
        1 : seg = 8'b10011111;
        2 : seg = 8'b00100101;
        3 : seg = 8'b00001101;
        4 : seg = 8'b10011001;
        5 : seg = 8'b01001001;
        6 : seg = 8'b01000001;
        7 : seg = 8'b00011111;
        8 : seg = 8'b00000001;
        9 : seg = 8'b00001001;
        default: seg = 8'b11111101;
    endcase
end

endmodule
