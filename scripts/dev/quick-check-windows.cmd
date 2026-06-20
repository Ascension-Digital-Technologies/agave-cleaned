@echo off
setlocal
cd /d "%~dp0\..\.."
set AGAVE_NO_PAUSE=1
set AGAVE_NO_PAUSE_PARENT=1
call scripts\dev\github-ready-windows.cmd || goto :fail
call scripts\dev\metadata-windows.cmd || goto :fail
echo Quick check passed.
pause
exit /b 0
:fail
echo Quick check failed.
pause
exit /b 1
