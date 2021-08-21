vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu -sv "+incdir+../../../../fpga4fun_pong_vivado.gen/sources_1/bd/clk_108mhz/ipshared/6dcf" \
"/opt/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/opt/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu "+incdir+../../../../fpga4fun_pong_vivado.gen/sources_1/bd/clk_108mhz/ipshared/6dcf" \
"../../../bd/clk_108mhz/ip/clk_108mhz_clk_wiz_0_0/clk_108mhz_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/clk_108mhz/ip/clk_108mhz_clk_wiz_0_0/clk_108mhz_clk_wiz_0_0.v" \
"../../../bd/clk_108mhz/sim/clk_108mhz.v" \

vlog -work xil_defaultlib \
"glbl.v"

