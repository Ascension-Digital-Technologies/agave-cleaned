@echo off
setlocal
cd /d "%~dp0\..\.."
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
echo ==^> Rust toolchain
where rustup >nul 2>nul && rustup show active-toolchain

echo.
echo ==^> Workspace summary
python scripts\workspace-summary.py
if not "%AGAVE_NO_PAUSE%"=="1" pause
endlocal
