# 50MHz main clock
create_clock -period 20.000 -name clk -waveform {0.000 10.000} [get_ports clk]
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports clk] ;# 50MHz main clock in

set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports rst] ;#BTN6

set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {AS1}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {AS2}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {BS1}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {BS2}]

#LEDS
set_property -dict {PACKAGE_PIN B24 IOSTANDARD LVCMOS33} [get_ports {lights[0]}] ;# 主道绿灯（AG）
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {lights[1]}] ;# 主道黄灯（AY）
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports {lights[2]}] ;# 主道红灯（AR）
set_property -dict {PACKAGE_PIN D23 IOSTANDARD LVCMOS33} [get_ports {lights[3]}] ;# 支道绿灯（BG）
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports {lights[4]}] ;# 支道黄灯（BY）
set_property -dict {PACKAGE_PIN C21 IOSTANDARD LVCMOS33} [get_ports {lights[5]}] ;# 支道红灯（BR）

#DPY0
set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33} [get_ports {seg_ones[0]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {seg_ones[1]}]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports {seg_ones[2]}]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports {seg_ones[3]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {seg_ones[4]}]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports {seg_ones[5]}]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {seg_ones[6]}]
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {seg_ones[7]}]

#DPY1
set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {seg_tens[0]}]
set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports {seg_tens[1]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {seg_tens[2]}]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports {seg_tens[3]}]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {seg_tens[4]}]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {seg_tens[5]}]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports {seg_tens[6]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {seg_tens[7]}]
