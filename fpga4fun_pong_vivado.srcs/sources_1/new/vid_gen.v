`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2021 11:11:11 AM
// Design Name: 
// Module Name: vid_gen
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


module vid_gen(
    input CLK,
    input RST,

    output VGA_RED_3,
    output VGA_BLUE_3,
    output VGA_GREEN_3,

    output vga_h_sync,
    output vga_v_sync
);
    // Timings are based on http://tinyvga.com/vga-timing/1280x1024@60Hz
    // The devices I have for testing do not support 640x480, 720x576 or 800x600 resolutions.
    reg[10:0] CounterX;
    reg[10:0] CounterY;
    wire CounterXmaxed = (CounterX==11'h697);
    wire CounterYmaxed = (CounterY==11'h429);

    always @(posedge CLK)
    if (RST)
        begin
            CounterX <= 0;
            CounterY <= 0;
        end
    else
        if(CounterXmaxed)
            CounterX <= 0;
        else
            CounterX <= CounterX + 1;

    always @(posedge CounterXmaxed)
        if(CounterYmaxed)
            CounterY <= 0;
        else
            CounterY <= CounterY + 1;

    reg vga_HS;
    reg vga_VS;
    always @(posedge CLK)
    begin
        // tweak the following values to move the display 
        vga_HS <= (CounterX[10:6] == 5'h34); // active for 64 clocks
        vga_VS <= (CounterY[10:2] == 9'h10a); // active for 4 lines
    end
    assign vga_h_sync = ~vga_HS;
    assign vga_v_sync = ~vga_VS;

    assign VGA_RED_3 = CounterY[3] | (CounterX == 256);
    assign VGA_GREEN_3 = (CounterX[5] ^ CounterX[6]) | (CounterX == 256);
    assign VGA_BLUE_3 = CounterX[4] | (CounterX == 256);

endmodule
