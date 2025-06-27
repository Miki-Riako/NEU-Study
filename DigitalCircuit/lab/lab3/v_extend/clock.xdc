# 50MHz main clock
create_clock -period 20.000 -name clk -waveform {0.000 10.000} [get_ports clk]
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports clk] ;# 50MHz main clock in

set_property -dict {PACKAGE_PIN B24 IOSTANDARD LVCMOS33} [get_ports {running}]
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {mode_flag}]
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports {led_blink}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports start] ;#BTN1
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports stop] ;#BTN2
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports mode_btn] ;#BTN3
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports rst] ;#BTN6

set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {value[0]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {value[1]}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {value[2]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {value[3]}]
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {value[4]}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {value[5]}]

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
