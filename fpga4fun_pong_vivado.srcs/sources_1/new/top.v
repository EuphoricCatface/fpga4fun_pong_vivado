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

    wire border = (CounterX[10:3] == 0) || (CounterX[10:3] == ((11'h500 >> 3) - 1))
                    || (CounterY[10:3] == 0) || (CounterY[10:3] == ((11'h400 >> 3) - 1));
    wire R = border;
    wire G = border;
    wire B = border;

    reg VGA_RED_3, VGA_GREEN_3, VGA_BLUE_3;
    always @(posedge CLK_108)
    begin
        VGA_RED_3  <= R & inDisplayArea;
        VGA_BLUE_3 <= B & inDisplayArea;
        VGA_GREEN_3 <= G & inDisplayArea;
    end

endmodule
