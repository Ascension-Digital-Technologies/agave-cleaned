@echo off
setlocal
cd /d "%~dp0\..\.."
call scripts\dev\lib\windows-cargo-env.cmd

echo ==^> Windows native build diagnostics

echo.
echo Repository:
cd

echo.
echo MSYS2:
if "%AGAVE_MSYS2_FOUND%"=="1" (
  echo MSYS2_ROOT=%MSYS2_ROOT%
echo MSYS2_ROOT_FWD=%MSYS2_ROOT_FWD%
) else (
  echo MSYS2 was not found. Set MSYS2_ROOT or install to C:\msys64.
)

echo.
echo Rust target/toolchain:
where rustup 2>nul
where cargo 2>nul
where rustc 2>nul
rustup show active-toolchain 2>nul
rustc -vV 2>nul

echo.
echo Perl resolution:
where perl 2>nul
perl -V:osname 2>nul
perl -V:version 2>nul

echo.
echo MinGW tool resolution:
where gcc 2>nul
where g++ 2>nul
where ar 2>nul
where ranlib 2>nul
where mingw32-make 2>nul
where make 2>nul

echo.
echo Cargo native tool environment:
echo CC_x86_64_pc_windows_gnu=%CC_x86_64_pc_windows_gnu%
echo CC_x86_64-pc-windows-gnu=%CC_x86_64-pc-windows-gnu%
echo AR_x86_64_pc_windows_gnu=%AR_x86_64_pc_windows_gnu%
echo AR_x86_64-pc-windows-gnu=%AR_x86_64-pc-windows-gnu%
echo RANLIB_x86_64_pc_windows_gnu=%RANLIB_x86_64_pc_windows_gnu%
echo RANLIB_x86_64-pc-windows-gnu=%RANLIB_x86_64-pc-windows-gnu%
echo MAKE=%MAKE%
echo LIBCLANG_PATH=%LIBCLANG_PATH%
echo CLANG_PATH=%CLANG_PATH%
echo BINDGEN_EXTRA_CLANG_ARGS=%BINDGEN_EXTRA_CLANG_ARGS%

echo.
echo MSYS shell compiler-path canary:
if "%AGAVE_MSYS2_FOUND%"=="1" (
  "%MSYS2_ROOT%\usr\bin\sh.exe" -lc '"%MSYS2_ROOT_FWD%/mingw64/bin/gcc.exe" --version | head -n 1' 2>nul
)

echo.
echo OpenSSL hint:
echo If perl -V:osname prints MSWin32, vendored OpenSSL will fail for the GNU target.
echo The wrapper must resolve perl from MSYS2 usr\bin before Strawberry/ActivePerl.
echo The wrapper must also export compiler paths as C:/... not C:\... because MSYS sh strips backslashes.

if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
