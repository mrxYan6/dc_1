set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E3} [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk]

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V5} [get_ports {EN0}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T4} [get_ports {h[4]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V6} [get_ports {h[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T5} [get_ports {h[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T6} [get_ports {h[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V7} [get_ports {h[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN R8} [get_ports {m[5]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN U9} [get_ports {m[4]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T9} [get_ports {m[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V10} [get_ports {m[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN R10} [get_ports {m[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN U11} [get_ports {m[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN R11} [get_ports {s[5]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN U12} [get_ports {s[4]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T13} [get_ports {s[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V14} [get_ports {s[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T14} [get_ports {s[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN V15} [get_ports {s[0]}]

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN U16} [get_ports {LD0}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LD0]

#HCS-A01�忨�ϵ�ʵ�������
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C9} [get_ports {AN[7]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C10} [get_ports {AN[6]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN D10} [get_ports {AN[5]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C11} [get_ports {AN[4]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M17} [get_ports {AN[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J14} [get_ports {AN[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN K13} [get_ports {AN[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN P14} [get_ports {AN[0]}]

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN F14 } [get_ports {seg[7]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N14 } [get_ports {seg[6]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J13 } [get_ports {seg[5]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G13 } [get_ports {seg[4]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN F13 } [get_ports {seg[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G14 } [get_ports {seg[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M13 } [get_ports {seg[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN H14 } [get_ports {seg[0]}]