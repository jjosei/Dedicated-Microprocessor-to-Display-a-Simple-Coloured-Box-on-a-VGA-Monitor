
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name VGA_ADAPTER_PROJECT -dir "/home/jesse/VGA_ADAPTER_PROJECT/planAhead_run_1" -part xc3s200ft256-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "VGA_TOP.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {VGA PROJECT/V_FSM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VGA PROJECT/H_FSM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VGA PROJECT/VGA_TOP.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top VGA_TOP $srcset
add_files [list {VGA_TOP.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s200ft256-4
