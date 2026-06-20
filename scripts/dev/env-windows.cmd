@echo off
setlocal
cd /d "%~dp0\..\.."
call scripts\dev\lib\windows-cargo-env.cmd

echo ==^> Repository
cd
git branch --show-current 2>nul
if errorlevel 1 echo git branch unavailable

echo.
echo ==^> Tool versions
where python >nul 2>nul && python --version || echo missing: python
where git >nul 2>nul && git --version || echo missing: git
where rustup >nul 2>nul && rustup --version || echo missing: rustup
where cargo >nul 2>nul && cargo --version || echo missing: cargo
where rustc >nul 2>nul && rustc --version || echo missing: rustc
where cmake >nul 2>nul && cmake --version | more +0 || echo missing: cmake
where clang >nul 2>nul && clang --version | more +0 || echo missing: clang
where protoc >nul 2>nul && protoc --version || echo missing: protoc

echo.
echo ==^> Windows native build tools
if "%AGAVE_MSYS2_FOUND%"=="1" (
  echo MSYS2_ROOT=%MSYS2_ROOT%
) else (
  echo MSYS2 not found. Install to C:\msys64 or set MSYS2_ROOT.
)
where perl 2>nul
perl -V:osname 2>nul
where gcc 2>nul
where ar 2>nul
where ranlib 2>nul
where mingw32-make 2>nul

echo.
echo ==^> Rust toolchain
where rustup >nul 2>nul && rustup show active-toolchain

echo.
echo ==^> Workspace summary
python scripts\workspace-summary.py
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
