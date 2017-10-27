@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 317363e0b2b04bd589e31380fc1f5318 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot clock_divider_behav xil_defaultlib.clock_divider -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
