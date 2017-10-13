@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim tb_sync_signal_generator_behav -key {Behavioral:sim_1:Functional:tb_sync_signal_generator} -tclbatch tb_sync_signal_generator.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
