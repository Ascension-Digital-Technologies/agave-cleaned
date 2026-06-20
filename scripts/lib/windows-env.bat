@echo off
rem Shared Windows GNU/MSYS2 Cargo environment.
rem Intentionally does not use setlocal so variables remain visible to callers.

if not defined MSYS2_ROOT set "MSYS2_ROOT=C:\msys64"

set "AGAVE_MINGW64_BIN=%MSYS2_ROOT%\mingw64\bin"
set "AGAVE_USR_BIN=%MSYS2_ROOT%\usr\bin"
set "AGAVE_UCRT64_BIN=%MSYS2_ROOT%\ucrt64\bin"
set "AGAVE_CLANG64_BIN=%MSYS2_ROOT%\clang64\bin"

if exist "%AGAVE_MINGW64_BIN%" set "PATH=%AGAVE_MINGW64_BIN%;%PATH%"
if exist "%AGAVE_USR_BIN%" set "PATH=%AGAVE_USR_BIN%;%PATH%"
if exist "%AGAVE_UCRT64_BIN%" set "PATH=%AGAVE_UCRT64_BIN%;%PATH%"
if exist "%AGAVE_CLANG64_BIN%" set "PATH=%AGAVE_CLANG64_BIN%;%PATH%"
if exist "C:\Program Files\LLVM\bin" set "PATH=C:\Program Files\LLVM\bin;%PATH%"

rem Prefer bare tool names. OpenSSL invokes them from an MSYS make/sh context;
rem absolute C:\... paths can be transformed into broken C:... strings.
set "CC_x86_64_pc_windows_gnu=gcc"
set "CC_x86_64-pc-windows-gnu=gcc"
set "CXX_x86_64_pc_windows_gnu=g++"
set "CXX_x86_64-pc-windows-gnu=g++"
set "AR_x86_64_pc_windows_gnu=ar"
set "AR_x86_64-pc-windows-gnu=ar"
set "RANLIB_x86_64_pc_windows_gnu=ranlib"
set "RANLIB_x86_64-pc-windows-gnu=ranlib"
set "MAKE=mingw32-make"
set "CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=gcc"

set "CXXFLAGS_x86_64_pc_windows_gnu=-include cstdint"
set "CXXFLAGS_x86_64-pc-windows-gnu=-include cstdint"
set "BINDGEN_EXTRA_CLANG_ARGS_x86_64_pc_windows_gnu=--target=x86_64-w64-windows-gnu"
set "BINDGEN_EXTRA_CLANG_ARGS_x86_64-pc-windows-gnu=--target=x86_64-w64-windows-gnu"

if not defined LIBCLANG_PATH (
  if exist "%AGAVE_MINGW64_BIN%\libclang.dll" set "LIBCLANG_PATH=%AGAVE_MINGW64_BIN%"
  if not defined LIBCLANG_PATH if exist "%AGAVE_UCRT64_BIN%\libclang.dll" set "LIBCLANG_PATH=%AGAVE_UCRT64_BIN%"
  if not defined LIBCLANG_PATH if exist "%AGAVE_CLANG64_BIN%\libclang.dll" set "LIBCLANG_PATH=%AGAVE_CLANG64_BIN%"
  if not defined LIBCLANG_PATH if exist "C:\Program Files\LLVM\bin\libclang.dll" set "LIBCLANG_PATH=C:\Program Files\LLVM\bin"
)
if not defined CLANG_PATH (
  if exist "%AGAVE_MINGW64_BIN%\clang.exe" set "CLANG_PATH=%AGAVE_MINGW64_BIN%\clang.exe"
  if not defined CLANG_PATH if exist "%AGAVE_UCRT64_BIN%\clang.exe" set "CLANG_PATH=%AGAVE_UCRT64_BIN%\clang.exe"
  if not defined CLANG_PATH if exist "%AGAVE_CLANG64_BIN%\clang.exe" set "CLANG_PATH=%AGAVE_CLANG64_BIN%\clang.exe"
  if not defined CLANG_PATH if exist "C:\Program Files\LLVM\bin\clang.exe" set "CLANG_PATH=C:\Program Files\LLVM\bin\clang.exe"
)

goto :eof
