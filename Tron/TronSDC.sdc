# Main clock being inputted into the CPU and code. (50Mhz)
create_clock -name "clk" -period 20.000ns [get_ports {clk}]

# Derive clock uncertainties for both clocks
derive_pll_clocks
derive_clock_uncertainty
