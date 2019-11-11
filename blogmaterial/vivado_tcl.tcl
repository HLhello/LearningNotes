set prj_path "E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp"
start_gui
create_project test_bgm prj_path -part xc7vx690tffg1927-2
file mkdir prj_path/test_bgm.srcs/sources_1/new
close [ open prj_path/test_bgm.srcs/sources_1/new/test_rom.v w ]
add_files prj_path/test_bgm.srcs/sources_1/new/test_rom.v


start_gui
open_project E:/working_files/test_vivado/test_rom.xpr
