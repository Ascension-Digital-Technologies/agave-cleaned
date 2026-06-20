@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Running clippy
cargo clippy --workspace --all-targets --locked %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
