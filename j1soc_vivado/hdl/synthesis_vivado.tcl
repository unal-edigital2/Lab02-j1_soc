## tcl para Vivado Di
# Autor Ferney Beltran 

set DESIGN [lindex $argv 0]
set SRC [split [lindex $argv 1]]
set DEVICE [lindex $argv 2]
set PINS [lindex $argv 3]


# Create Project
create_project -force -name $DESIGN -part $DEVICE
set_msg_config -id {Common 17-55} -new_severity {Warning}

# Add Sources

read_verilog $SRC

#read_verilog $DESIGN.v
#foreach file $SRC {
#  add_files $file
#}

# Add EDIFs


# Add IPs


# Add constraints

read_xdc $PINS
set_property PROCESSING_ORDER EARLY [get_files $DESIGN.xdc]

# Add pre-synthesis commands


# Synthesis

synth_design -directive default -top $DESIGN -part $DEVICE

# Synthesis report

report_timing_summary -file $DESIGN-timing_synth.rpt
report_utilization -hierarchical -file $DESIGN-utilization_hierarchical_synth.rpt
report_utilization -file $DESIGN-utilization_synth.rpt

# Optimize design

opt_design -directive default

# Add pre-placement commands


# Placement

place_design -directive default

# Placement report

report_utilization -hierarchical -file $DESIGN-utilization_hierarchical_place.rpt
report_utilization -file $DESIGN-utilization_place.rpt
report_io -file $DESIGN-io.rpt
report_control_sets -verbose -file $DESIGN-control_sets.rpt
report_clock_utilization -file $DESIGN-clock_utilization.rpt

# Add pre-routing commands


# Routing

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force $DESIGN-route.dcp

# Routing report

report_timing_summary -no_header -no_detailed_paths
report_route_status -file $DESIGN-route_status.rpt
report_drc -file $DESIGN-drc.rpt
report_timing_summary -datasheet -max_paths 10 -file $DESIGN-timing.rpt
report_power -file $DESIGN-power.rpt

# Bitstream generation

write_bitstream -force $DESIGN.bit 

# End

quit