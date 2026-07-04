`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2026 12:05:56
// Design Name: 
// Module Name: top
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


module top(
    input  logic clk,
    input  logic btn_inc,
    input  logic btn_dec,
    input  logic btn_rst,
    output logic [15:0] led,
    output logic [7:0] seg,
    output logic [7:0] an
    );
    
// semnale dupa sincronizare
logic btn_inc_sync;
logic btn_dec_sync;
logic btn_rst_sync;

// semnale dupa debounce
logic btn_inc_stable;
logic btn_dec_stable;
logic btn_rst_stable;

// impulsuri de un ciclu pentru contor
logic inc_pulse;
logic dec_pulse;
logic rst_pulse;

// valoarea interna a contorului
logic [15:0] count;

// semnale pentru afisarea pe 7 segmente
logic [3:0] digit0;
logic [3:0] digit1;
logic [3:0] digit2;
logic [3:0] digit3;
logic [3:0] digit4;

logic [3:0] digit_out;

logic [19:0] count_refresh;
logic [2:0] sel;


// contorul principal
counter16b c1(
    .clk(clk),
    .rst(rst_pulse),
    .inc(inc_pulse),
    .dec(dec_pulse),
    .count(count)
);


// sincronizare buton incrementare
button_sync c2(
    .clk(clk),
    .btn_in(btn_inc),
    .btn_sync(btn_inc_sync)
);

// debounce buton incrementare
debouncer c3(
    .clk(clk),
    .btn_in(btn_inc_sync),
    .btn_stable(btn_inc_stable)
);

// detectare front buton incrementare
edge_detector c4(
    .clk(clk),
    .signal_in(btn_inc_stable),
    .pulse_out(inc_pulse)
);


// sincronizare buton decrementare
button_sync c5(
    .clk(clk),
    .btn_in(btn_dec),
    .btn_sync(btn_dec_sync)
);

// debounce buton decrementare
debouncer c6(
    .clk(clk),
    .btn_in(btn_dec_sync),
    .btn_stable(btn_dec_stable)
);

// detectare front buton decrementare
edge_detector c7(
    .clk(clk),
    .signal_in(btn_dec_stable),
    .pulse_out(dec_pulse)
);


// sincronizare buton reset
button_sync c8(
    .clk(clk),
    .btn_in(btn_rst),
    .btn_sync(btn_rst_sync)
);

// debounce buton reset
debouncer c9(
    .clk(clk),
    .btn_in(btn_rst_sync),
    .btn_stable(btn_rst_stable)
);

// detectare front buton reset
edge_detector c10(
    .clk(clk),
    .signal_in(btn_rst_stable),
    .pulse_out(rst_pulse)
);


// afisarea valorii contorului pe LED-uri
assign led = count;


// conversie din valoarea binara a contorului in cifre zecimale
binary_to_decimal c11(
    .binary(count),
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .digit4(digit4)
);


// numarator pentru refresh-ul afisajului
num c12(
    .rst(rst_pulse),
    .clk(clk),
    .count(count_refresh)
);


// selectia cifrei active
assign sel = count_refresh[18:16];


// alegerea cifrei care va fi afisata
mux c13(
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .digit4(digit4),
    .sel(sel),
    .digit_out(digit_out)
);


// transformarea cifrei in semnale pentru 7 segmente
transcodor_7seg c14(
    .digit(digit_out),
    .seg(seg)
);


// selectarea anodului activ
decodor_anod c15(
    .sel(sel),
    .an(an)
);

endmodule