set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {work.axi_pwm_custom_if_tb} -autoloadwcfg -tclbatch {xsim_gui_cmd.tcl}
