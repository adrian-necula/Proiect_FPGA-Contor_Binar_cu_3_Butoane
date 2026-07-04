`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 15:42:06
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input logic clk,
    input logic btn_in,
    output logic btn_stable
    );
    
localparam int max_count = 1_000_000;
logic [19:0] counter = 0;

always_ff @(posedge clk) begin
        if (btn_in == btn_stable) begin
            counter <= 0;
        end
            
        else begin
            if (counter == max_count - 1) begin
                btn_stable <= btn_in;
                counter <= 0;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
