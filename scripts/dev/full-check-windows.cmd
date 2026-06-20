@echo off
setlocal
cd /d "%~dp0\..\.."
set AGAVE_NO_PAUSE=1
set AGAVE_NO_PAUSE_PARENT=1
call scripts\dev\github-ready-windows.cmd || goto :fail
call scripts\dev\metadata-windows.cmd || goto :fail
call scripts\dev\fmt-windows.cmd || goto :fail
call scripts\dev\clippy-windows.cmd || goto :fail
call scripts\dev\test-windows.cmd || goto :fail
echo Full local gate passed.
pause
exit /b 0
:fail
echo Full local gate failed.
pause
exit /b 1
