`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2021 05:10:40 PM
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
    input CLK,
    input RST,

    output VGA_RED_3,
    output VGA_BLUE_3,
    output VGA_GREEN_3,

    output vga_h_sync,
    output vga_v_sync
    );
    wire CLK_108;
    wire inDisplayArea;
    wire [10:0] CounterX;
    wire [10:0] CounterY;
    
    clk_108mhz clk_108mhz_i0
       (.clk_in1_0(CLK),
        .clk_out1_0(CLK_108),
        .reset_0(1'b0));

    hvsync_gen hvsync_gen_i0
        (.CLK(CLK_108),
        .RST(RST),

        .inDisplayArea(inDisplayArea),
        .CounterX(CounterX),
        .CounterY(CounterY),
    
        .vga_h_sync(vga_h_sync),
        .vga_v_sync(vga_v_sync)
        );
endmodule
