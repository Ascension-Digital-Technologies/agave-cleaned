@echo off
setlocal
cd /d "%~dp0\..\.."
call scripts\dev\lib\windows-cargo-env.cmd
echo ==^> Running tests
cargo nextest --version >nul 2>nul
if errorlevel 1 (
  echo cargo-nextest not installed; falling back to cargo test.
  cargo test --workspace --locked %*
) else (
  cargo nextest run --profile ci --cargo-profile ci --config-file .config\nextest.toml %*
)
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
