@echo off
setlocal
cd /d "%~dp0\.."

echo ==^> Preparing Windows GNU/MSYS2 Cargo environment
powershell -NoProfile -ExecutionPolicy Bypass -File "%CD%\scripts\setup-windows.ps1"
if errorlevel 1 (
  set STATUS=%ERRORLEVEL%
  if not "%AGAVE_NO_PAUSE%"=="1" pause
  exit /b %STATUS%
)

call "%CD%\.cargo\env-windows.bat"

echo.
echo ==^> Build environment
echo MSYS2_ROOT=%MSYS2_ROOT%
echo LIBCLANG_PATH=%LIBCLANG_PATH%
echo CLANG_PATH=%CLANG_PATH%
echo CC_x86_64_pc_windows_gnu=%CC_x86_64_pc_windows_gnu%
echo MAKE=%MAKE%
echo.

echo ==^> Building workspace
cargo build --workspace --locked %*
set STATUS=%ERRORLEVEL%
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b %STATUS%
