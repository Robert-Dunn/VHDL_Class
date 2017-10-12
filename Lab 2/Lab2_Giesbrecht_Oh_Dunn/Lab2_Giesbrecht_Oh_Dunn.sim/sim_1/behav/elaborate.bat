@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto b39768d68b774900aab9b0d0f13056d4 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_digital_clock_behav xil_defaultlib.tb_digital_clock -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0