`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 16:25:33
// Design Name: 
// Module Name: test_debouncer
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


module test_debouncer();
logic clk;
logic btn_in;
logic btn_stable;

initial begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
        btn_in = 0;

        repeat(3) @(negedge clk);
    
        // simulam bouncing la apasare
        btn_in = 1;
        @(negedge clk);
        btn_in = 0;
        @(negedge clk);
        btn_in = 1;
        @(negedge clk);
        btn_in = 0;
        @(negedge clk);
        btn_in = 1;

        // acum butonul ramane stabil apasat
        repeat(8) @(negedge clk);

        // simulam bouncing la eliberare
        btn_in = 0;
        @(negedge clk);
        btn_in = 1;
        @(negedge clk);
        btn_in = 0;
        @(negedge clk);
        btn_in = 1;
        @(negedge clk);
        btn_in = 0;

        // acum butonul ramane stabil eliberat
        repeat(8) @(negedge clk);

        #20;
        $finish;
    
end

debouncer dut (
        .clk(clk),
        .btn_in(btn_in),
        .btn_stable(btn_stable)
    );

endmodule
