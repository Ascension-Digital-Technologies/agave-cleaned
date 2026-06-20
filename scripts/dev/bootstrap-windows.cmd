@echo off
setlocal
cd /d "%~dp0\..\.."
call scripts\dev\lib\windows-cargo-env.cmd

echo ==^> Checking Windows developer environment
set MISSING=0
where python >nul 2>nul || (echo missing: python & set MISSING=1)
where git >nul 2>nul || (echo missing: git & set MISSING=1)
where rustup >nul 2>nul || (echo missing: rustup & set MISSING=1)
where cargo >nul 2>nul || (echo missing: cargo & set MISSING=1)
where cmake >nul 2>nul || echo optional missing: cmake
where clang >nul 2>nul || echo optional missing: clang
where protoc >nul 2>nul || echo optional missing: protoc

if "%AGAVE_MSYS2_FOUND%"=="1" (
  echo found: MSYS2 at %MSYS2_ROOT%
) else (
  echo missing: MSYS2 Perl/MinGW environment
  echo   Install MSYS2 to C:\msys64 or set MSYS2_ROOT to your msys64 folder.
  echo   Then install packages with:
  echo     pacman -S --needed base-devel perl mingw-w64-x86_64-toolchain mingw-w64-x86_64-perl mingw-w64-x86_64-clang mingw-w64-x86_64-pkgconf
  set MISSING=1
)

echo.
echo Native toolchain resolution after wrapper setup:
where perl 2>nul
perl -V:osname 2>nul
where gcc 2>nul
where ar 2>nul
where ranlib 2>nul

for /f "tokens=*" %%O in ('perl -V:osname 2^>nul') do set "PERL_OSNAME=%%O"
echo %PERL_OSNAME% | findstr /I "MSWin32" >nul 2>nul
if not errorlevel 1 (
  echo.
  echo warning: perl still resolves to a native Windows Perl.
  echo Vendored OpenSSL will fail for x86_64-pc-windows-gnu until MSYS2 usr\bin Perl is first on PATH.
  set MISSING=1
)

echo.
echo Recommended next commands:
echo   scripts\dev\diagnose-windows-build.cmd
echo   scripts\dev\env-windows.cmd
echo   scripts\dev\quick-check-windows.cmd
echo   scripts\dev\build-windows.cmd

echo.
if "%MISSING%"=="1" (
  echo Bootstrap check found missing or mismatched tools.
  if not "%AGAVE_NO_PAUSE%"=="1" pause
  exit /b 1
)
echo Bootstrap check complete.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
