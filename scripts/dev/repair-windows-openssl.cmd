@echo off
setlocal
cd /d "%~dp0\..\.."

echo ==^> Repairing Windows vendored OpenSSL build state
call scripts\dev\lib\windows-cargo-env.cmd
if errorlevel 1 (
  set STATUS=%ERRORLEVEL%
  if not "%AGAVE_NO_PAUSE%"=="1" pause
  exit /b %STATUS%
)

echo.
echo Build environment:
echo MSYS2_ROOT=%MSYS2_ROOT%
echo CC_x86_64_pc_windows_gnu=%CC_x86_64_pc_windows_gnu%
echo MAKE=%MAKE%
echo LIBCLANG_PATH=%LIBCLANG_PATH%

echo.
echo Removing stale openssl-sys build directories...
for /d %%D in ("target\debug\build\openssl-sys-*" "target\release\build\openssl-sys-*") do (
  if exist "%%~D" (
    echo   deleting %%~D
    rmdir /s /q "%%~D"
  )
)

echo.
echo ==^> Rebuilding workspace
cargo build --workspace --locked %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
