@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Checking Windows developer environment
where python >nul 2>nul || echo missing: python
where git >nul 2>nul || echo missing: git
where rustup >nul 2>nul || echo missing: rustup
where cargo >nul 2>nul || echo missing: cargo
echo.
echo Recommended next commands:
echo   scripts\dev\layout-windows.cmd
echo   scripts\dev\check-windows.cmd
echo.
pause
endlocal
