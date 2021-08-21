//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Sat Aug 21 20:49:14 2021
//Host        : syparkzen running 64-bit unknown
//Command     : generate_target clk_108mhz_wrapper.bd
//Design      : clk_108mhz_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clk_108mhz_wrapper
   (clk_in1_0,
    clk_out1_0,
    reset_0);
  input clk_in1_0;
  output clk_out1_0;
  input reset_0;

  wire clk_in1_0;
  wire clk_out1_0;
  wire reset_0;

  clk_108mhz clk_108mhz_i
       (.clk_in1_0(clk_in1_0),
        .clk_out1_0(clk_out1_0),
        .reset_0(reset_0));
endmodule
