@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Formatting Rust workspace
cargo fmt --all %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
