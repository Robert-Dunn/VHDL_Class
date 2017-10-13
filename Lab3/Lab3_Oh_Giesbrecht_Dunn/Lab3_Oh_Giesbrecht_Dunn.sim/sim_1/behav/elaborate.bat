@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 00e315f3c04e4c0e933e8595547c4992 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_sync_signal_generator_behav xil_defaultlib.tb_sync_signal_generator -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
