@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Checking Rust formatting
cargo fmt --all -- --check %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
