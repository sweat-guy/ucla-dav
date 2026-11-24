# Maps calculator_top's ports to Basys3 pins. Buses listed MSB first.

# op1 = switches 15-12
set_property PACKAGE_PIN R2 [get_ports {op1[3]}]
set_property PACKAGE_PIN T1 [get_ports {op1[2]}]
set_property PACKAGE_PIN U1 [get_ports {op1[1]}]
set_property PACKAGE_PIN W2 [get_ports {op1[0]}]

# 100 MHz clock
set_property PACKAGE_PIN W5 [get_ports clk]

# operation = switch 11, sign = switch 10
set_property PACKAGE_PIN R3 [get_ports operation]
set_property PACKAGE_PIN T2 [get_ports sign]

# op2 = switches 9-6
set_property PACKAGE_PIN T3 [get_ports {op2[3]}]
set_property PACKAGE_PIN V2 [get_ports {op2[2]}]
set_property PACKAGE_PIN W13 [get_ports {op2[1]}]
set_property PACKAGE_PIN W14 [get_ports {op2[0]}]

# segBits[0..6] = segments A..G
set_property PACKAGE_PIN W7 [get_ports {segBits[0]}]
set_property PACKAGE_PIN W6 [get_ports {segBits[1]}]
set_property PACKAGE_PIN U8 [get_ports {segBits[2]}]
set_property PACKAGE_PIN V8 [get_ports {segBits[3]}]
set_property PACKAGE_PIN U5 [get_ports {segBits[4]}]
set_property PACKAGE_PIN V5 [get_ports {segBits[5]}]
set_property PACKAGE_PIN U7 [get_ports {segBits[6]}]

# trigger = display enables; trigger[0] (U2) = rightmost = ones digit.
# Reverse these if numbers appear backwards.
set_property PACKAGE_PIN W4 [get_ports {trigger[3]}]
set_property PACKAGE_PIN V4 [get_ports {trigger[2]}]
set_property PACKAGE_PIN U4 [get_ports {trigger[1]}]
set_property PACKAGE_PIN U2 [get_ports {trigger[0]}]

# 3.3 V I/O (required; unset = bitstream error NSTD-1). [*] = all bits.
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports operation]
set_property IOSTANDARD LVCMOS33 [get_ports sign]
set_property IOSTANDARD LVCMOS33 [get_ports {op1[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {op2[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segBits[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {trigger[*]}]

# 100 MHz = 10 ns period (for timing analysis; optional)
create_clock -period 10.000 -name sys_clk [get_ports clk]
