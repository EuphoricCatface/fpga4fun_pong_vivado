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
    input BTNL,
    input BTNR,

    output reg VGA_RED_3, VGA_BLUE_3, VGA_GREEN_3,

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

    // 103.00Hz clock
    reg [20:0] cnt;
    always @(posedge CLK_108)
    begin
        if (RST)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end

    //PS/2 mouse control to be implemented later
    reg [10:0] PaddlePosition;
    always @(posedge cnt[18])
    // NOTE: Image update might happen mid-frame
    begin
        if (RST)
            PaddlePosition <= (1280 / 2);
        else
            begin
                if (BTNL && !BTNR)
                    if (PaddlePosition) // make sure the value doesn't underflow
                        PaddlePosition <= PaddlePosition - 1;
                if (!BTNL && BTNR)
                    if (~&PaddlePosition) // make sure the value doesn't overflow
                        PaddlePosition <= PaddlePosition + 1;
            end
    end

    wire border = (CounterX[10:3] == 0) || (CounterX[10:3] == ((11'h500 >> 3) - 1))
    || (CounterY[10:3] == 0) || (CounterY[10:3] == ((11'h400 >> 3) - 1));
    wire paddle = (CounterX >= PaddlePosition + 8) && (CounterX <= PaddlePosition+120) && (CounterY[10:4] == (10'h3FF >> 4) - 3);
    wire BouncingObject = border | paddle; //active if the border or paddle is redrawing itself

    reg [10:0] ballX;
    reg [10:0] ballY;
    reg ball_inX, ball_inY;

    always @(posedge CLK_108)
    if (ball_inX == 0)
        ball_inX <= (CounterX == ballX) & ball_inY;
    else
        ball_inX <= !(CounterX == ballX + 16);

    always @(posedge CLK_108)
    if (ball_inY == 0)
        ball_inY <= (CounterY == ballY);
    else
        ball_inY <= !(CounterY == ballY+16);

    wire ball = ball_inX & ball_inY;

    reg ResetCollision;     // active only once for every video frame
    always @(posedge CLK_108) ResetCollision <= (CounterY == 1024) & (CounterX == 0);

    reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;
    always @(posedge CLK_108)
    begin
        if (ResetCollision)
            CollisionX1 <= 0;
        else if (BouncingObject & (CounterX == ballX) & (CounterY == ballY + 8))
            CollisionX1 <= 1;
        if (ResetCollision)
            CollisionX2 <= 0;
        else if (BouncingObject & (CounterX == ballX + 16) & (CounterY == ballY + 8))
            CollisionX2 <= 1;
        if (ResetCollision)
            CollisionY1 <= 0;
        else if (BouncingObject & (CounterX == ballX + 8) & (CounterY == ballY))
            CollisionY1 <= 1;
        if (ResetCollision)
            CollisionY2 <= 0;
        else if (BouncingObject & (CounterX == ballX+8) & (CounterY == ballY + 16))
            CollisionY2 <= 1;
    end

    wire UpdateBallPosition = ResetCollision;

    reg ball_dirX, ball_dirY;
    always @(posedge CLK_108)
    if (RST)
    begin
        ballX = (1280 / 2);
        ballY = (1024 / 2);
    end
    else if (UpdateBallPosition)
    begin
        if(~(CollisionX1 & CollisionX2))
        begin
            ballX <= ballX + (ball_dirX ? -1 : 1);
            if (CollisionX2) ball_dirX <= 1; else if (CollisionX1) ball_dirX <= 0;
        end

        if(~(CollisionY1 & CollisionY2))
        begin
            ballY <= ballY + (ball_dirY ? -1 : 1);
            if (CollisionY2) ball_dirY <= 1; else if (CollisionY1) ball_dirY <= 0;
        end
    end

    wire R = BouncingObject | (CounterX[3] | CounterY[3]) | ball;
    wire G = BouncingObject | ball;
    wire B = BouncingObject | ball;

    always @(posedge CLK_108)
    begin
        VGA_RED_3  <= R & inDisplayArea;
        VGA_BLUE_3 <= B & inDisplayArea;
        VGA_GREEN_3 <= G & inDisplayArea;
    end


endmodule
