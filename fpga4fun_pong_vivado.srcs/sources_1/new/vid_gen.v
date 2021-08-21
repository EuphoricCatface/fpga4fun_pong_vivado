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
    wire CounterXmaxed = (CounterX==11'd1687);
    wire CounterYmaxed = (CounterY==11'd1065);

    always @(posedge CLK)
    begin
        if (RST)
            begin
                CounterX <= 0;
                CounterY <= 0;
            end
        else
            begin
                if(CounterXmaxed)
                    begin
                        CounterX <= 0;
                        if(CounterYmaxed)
                            CounterY <= 0;
                        else
                            CounterY <= CounterY + 1;
                    end
                else
                    CounterX <= CounterX + 1;
            end
    end
    reg vga_HS;
    reg vga_VS;
    always @(posedge CLK)
    begin
        vga_HS <= (CounterX[10:6]==0); // active for 64 clocks
        vga_VS <= (CounterY[10:2] == 0); // active for 4 lines
    end
    assign vga_h_sync = ~vga_HS;
    assign vga_v_sync = ~vga_VS;

    assign VGA_RED_3 = CounterY[3] | (CounterX == 256);
    assign VGA_GREEN_3 = (CounterX[5] ^ CounterX[6]) | (CounterX == 256);
    assign VGA_BLUE_3 = CounterX[4] | (CounterX == 256);

endmodule
