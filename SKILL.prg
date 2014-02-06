set talk off
set echo off
clear
use skill
store "000000" to 編號
do while .not. eof()
if 舊編號 < 編號
  disp 
endif
編號 = 舊編號
skip
enddo