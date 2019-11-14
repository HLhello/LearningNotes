start_gui
start_gui
start_gui

create_project test_bgm prj_path -part xc7vx690tffg1927-2
create_project test_vbram E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp -part xc7vx690tffg1927-3

open_project E:/working_files/test_vivado/test_rom.xpr

catch { config_ip_cache -export [get_ips -all Single_port_ram] }
catch { config_ip_cache -export [get_ips -all Single_port_ram] }

file mkdir prj_path/test_bgm.srcs/sources_1/new
file mkdir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/new
file mkdir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sim_1/new
file delete -force e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0
file delete -force E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files/ip/blk_mem_gen_0

close [ open prj_path/test_bgm.srcs/sources_1/new/test_rom.v w ]
close [ open E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/new/test_vbram.v w ]
close [ open E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sim_1/new/tb_test_vbram.v w ]

add_files prj_path/test_bgm.srcs/sources_1/new/test_rom.v
add_files E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/new/test_vbram.v
add_files -fileset sim_1 E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sim_1/new/tb_test_vbram.

remove_files  -fileset blk_mem_gen_0 e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.3 -module_name blk_mem_gen_0 -dir e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.3 -module_name Single_port_ram -dir e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip

set_property -dict [list CONFIG.Enable_A {Always_Enabled}] [get_ips blk_mem_gen_0]
set_property -dict [list CONFIG.Enable_A {Always_Enabled}] [get_ips Single_port_ram]
set_property SOURCE_SET sources_1 [get_filesets sim_1]

INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository 'D:/Vivado/Vivado/2016.4/data/ip'.
INFO: [IP_Flow 19-1686] Generating 'Instantiation Template' target for IP 'blk_mem_gen_0'...
INFO: [IP_Flow 19-1686] Generating 'Synthesis' target for IP 'blk_mem_gen_0'...
INFO: [IP_Flow 19-1686] Generating 'Simulation' target for IP 'blk_mem_gen_0'...
INFO: [IP_Flow 19-1686] Generating 'Miscellaneous' target for IP 'blk_mem_gen_0'...
INFO: [IP_Flow 19-1686] Generating 'Change Log' target for IP 'blk_mem_gen_0'...
INFO: [Project 1-386] Moving file 'e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci' from fileset 'blk_mem_gen_0' to fileset 'sources_1'.
INFO: [IP_Flow 19-1686] Generating 'Synthesis' target for IP 'Single_port_ram'...
INFO: [IP_Flow 19-1686] Generating 'Simulation' target for IP 'Single_port_ram'...
INFO: [IP_Flow 19-1686] Generating 'Miscellaneous' target for IP 'Single_port_ram'...
INFO: [IP_Flow 19-1686] Generating 'Change Log' target for IP 'Single_port_ram'...
INFO: [IP_Flow 19-1686] Generating 'Instantiation Template' target for IP 'Single_port_ram'...

[Thu Nov 14 15:32:36 2019] Launched blk_mem_gen_0_synth_1...
[Thu Nov 14 15:35:35 2019] Launched Single_port_ram_synth_1...
[Thu Nov 14 17:13:54 2019] Launched synth_1...

generate_target {instantiation_template} [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
generate_target all [get_files  e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
generate_target {instantiation_template} [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/Single_port_ram/Single_port_ram.xci]
generate_target all [get_files  e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/Single_port_ram/Single_port_ram.xci]

export_ip_user_files -of_objects [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci] -no_script -sync -force -quiet
export_ip_user_files -of_objects [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/Single_port_ram/Single_port_ram.xci] -no_script -sync -force -quiet

create_ip_run [get_files -of_objects [get_fileset sources_1] e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/Single_port_ram/Single_port_ram.xci]


launch_runs -jobs 2 blk_mem_gen_0_synth_1
launch_runs -jobs 2 Single_port_ram_synth_1
launch_runs synth_1 -jobs 2

Run output will be captured here: E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.runs/blk_mem_gen_0_synth_1/runme.log
Run output will be captured here: E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.runs/Single_port_ram_synth_1/runme.log

export_simulation -of_objects [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci] -directory E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files/sim_scripts -ip_user_files_dir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files -ipstatic_source_dir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files/ipstatic -lib_map_path [list {modelsim=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/modelsim} {questa=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/questa} {riviera=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/riviera} {activehdl=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
export_simulation -of_objects [get_files e:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.srcs/sources_1/ip/Single_port_ram/Single_port_ram.xci] -directory E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files/sim_scripts -ip_user_files_dir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files -ipstatic_source_dir E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.ip_user_files/ipstatic -lib_map_path [list {modelsim=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/modelsim} {questa=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/questa} {riviera=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/riviera} {activehdl=E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet



reset_run synth_1
launch_runs synth_1 -jobs 2
[Thu Nov 14 17:43:52 2019] Launched synth_1...
Run output will be captured here: E:/working_files/LearningNotes/FPGA_ip_core/1.call-vivado-bmg/imp/test_vbram.runs/synth_1/runme.log

