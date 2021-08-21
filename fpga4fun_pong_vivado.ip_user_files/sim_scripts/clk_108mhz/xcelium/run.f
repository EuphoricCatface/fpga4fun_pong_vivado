-makelib xcelium_lib/xpm -sv \
  "/opt/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/opt/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/clk_108mhz/ip/clk_108mhz_clk_wiz_0_0/clk_108mhz_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/clk_108mhz/ip/clk_108mhz_clk_wiz_0_0/clk_108mhz_clk_wiz_0_0.v" \
  "../../../bd/clk_108mhz/sim/clk_108mhz.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

