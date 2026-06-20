@echo off
setlocal
cd /d "%~dp0\..\.."
call scripts\dev\lib\windows-cargo-env.cmd
if not "%AGAVE_MSYS2_FOUND%"=="1" (
  echo MSYS2 was not found. Install MSYS2 to C:\msys64 or set MSYS2_ROOT.
  pause
  exit /b 1
)

echo Prepared Agave Windows Cargo environment.
echo.
echo MSYS2_ROOT=%MSYS2_ROOT%
echo Perl should resolve to MSYS2 usr\bin:
where perl
perl -V:osname

echo.
echo Opening a new cmd.exe in this prepared environment.
echo Run cargo commands from the new shell, for example:
echo   cargo build --workspace --locked
cmd /k
endlocal
