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


module hvsync_gen(
    input CLK,
    input RST,

    output reg inDisplayArea,
    output reg [10:0] CounterX,
    output reg [10:0] CounterY,

    output vga_h_sync,
    output vga_v_sync
);
    // Timings are based on http://tinyvga.com/vga-timing/1280x1024@60Hz
    // The devices I have for testing do not support 640x480, 720x576 or 800x600 resolutions.
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
            begin
                CounterX <= 0;

                if(CounterYmaxed)
                    CounterY <= 0;
                else
                    CounterY <= CounterY + 1;
            end
        else
            CounterX <= CounterX + 1;

    reg vga_HS;
    reg vga_VS;
    always @(posedge CLK)
    begin
        // tweak the following values to move the display 
        vga_HS <= (CounterX[10:6] == (11'h540 >> 6)); // active for 64 clocks
        vga_VS <= (CounterY[10:2] == (11'h400 >> 2)); // active for 4 lines
    end

    always @(posedge CLK)
    if (inDisplayArea == 0)
        inDisplayArea <= (CounterXmaxed) && (CounterY < 1024);
    else
        inDisplayArea <= !(CounterX == 1279);

    assign vga_h_sync = ~vga_HS;
    assign vga_v_sync = ~vga_VS;

endmodule
