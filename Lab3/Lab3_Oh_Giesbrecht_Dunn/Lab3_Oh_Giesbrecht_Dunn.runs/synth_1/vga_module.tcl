# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/Lab3_Oh_Giesbrecht_Dunn/Lab3_Oh_Giesbrecht_Dunn.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/Lab3_Oh_Giesbrecht_Dunn/Lab3_Oh_Giesbrecht_Dunn.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {c:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/Lab3_Oh_Giesbrecht_Dunn/Lab3_Oh_Giesbrecht_Dunn.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/clock_divider1.vhd}
  {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/debouncer.vhd}
  {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/up_down_counter.vhd}
  {C:/Users/Rob Dunn/Documents/School/ENEL 453/VHDL_Class/Lab3/vga_module.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}

synth_design -top vga_module -part xc7a35tcpg236-1


write_checkpoint -force -noxdef vga_module.dcp

catch { report_utilization -file vga_module_utilization_synth.rpt -pb vga_module_utilization_synth.pb }
