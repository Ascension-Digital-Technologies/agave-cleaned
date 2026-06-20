@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Building workspace
cargo build --workspace --locked %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
