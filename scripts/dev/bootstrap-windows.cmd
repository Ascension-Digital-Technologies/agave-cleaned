@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Checking Windows developer environment
set MISSING=0
where python >nul 2>nul || (echo missing: python & set MISSING=1)
where git >nul 2>nul || (echo missing: git & set MISSING=1)
where rustup >nul 2>nul || (echo missing: rustup & set MISSING=1)
where cargo >nul 2>nul || (echo missing: cargo & set MISSING=1)
where cmake >nul 2>nul || echo optional missing: cmake
where clang >nul 2>nul || echo optional missing: clang
where protoc >nul 2>nul || echo optional missing: protoc

echo.
echo Recommended next commands:
echo   scripts\dev\env-windows.cmd
echo   scripts\dev\quick-check-windows.cmd
echo   scripts\dev\build-windows.cmd

echo.
if "%MISSING%"=="1" (
  echo Bootstrap check failed. Install the missing required tools first.
  pause
  exit /b 1
)
echo Bootstrap check complete.
pause
endlocal
