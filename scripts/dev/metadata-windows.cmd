@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Running cargo metadata
cargo metadata --no-deps %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
