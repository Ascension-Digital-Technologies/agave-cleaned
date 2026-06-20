@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Running nightly benchmarks
cargo +nightly bench --workspace %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
