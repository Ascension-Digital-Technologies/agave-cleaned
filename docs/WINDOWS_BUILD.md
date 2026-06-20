# Windows build notes

This cleaned Agave workspace has Windows wrappers under `scripts/dev/`. They are designed to make local Windows builds easier without changing Agave source behavior.

## The most common Windows GNU failure

When building the `x86_64-pc-windows-gnu` target, the `openssl-sys` crate may build vendored OpenSSL. OpenSSL's configure step needs a Unix-like MSYS2 Perl. If Cargo resolves Strawberry Perl, ActivePerl, or another native Windows Perl first, OpenSSL fails with:

```text
Failure! Makefile wasn't produced.
This perl implementation doesn't produce Unix like paths.
This Perl version: ... MSWin32 ...
```

The Windows Cargo wrappers in this repository prepare the MSYS2/MinGW environment before running Cargo so `perl` resolves from `C:\msys64\usr\bin` and compiler tools resolve from `C:/msys64/mingw64/bin`. The forward-slash compiler paths are intentional: OpenSSL's generated Makefile runs commands through MSYS `sh`, which strips backslashes from `C:\...` paths and turns them into invalid commands like `C:msys64mingw64bingcc.exe`.

## Recommended setup

Install MSYS2 to the default location:

```text
C:\msys64
```

From an MSYS2 shell, install the required native tools:

```bash
pacman -Syu
pacman -S --needed \
  base-devel perl \
  mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-perl \
  mingw-w64-x86_64-clang \
  mingw-w64-x86_64-pkgconf
```

Then open a new PowerShell or Command Prompt in the repo root and run:

```cmd
scripts\dev\bootstrap-windows.cmd
scripts\dev\diagnose-windows-build.cmd
scripts\build.bat
```

If you already hit an OpenSSL build failure before updating the wrappers, clear the stale OpenSSL build directory and rebuild with:

```cmd
scripts\dev\repair-windows-openssl.cmd
```

If MSYS2 is installed somewhere else, set `MSYS2_ROOT` before running the wrappers:

```cmd
set MSYS2_ROOT=D:\tools\msys64
scripts\build.bat
```

## What the wrappers do

The Cargo-taking Windows wrappers call `scripts/dev/lib/windows-cargo-env.cmd` before running Cargo. That helper:

- finds MSYS2 from `MSYS2_ROOT`, `C:\msys64`, or a few common install locations;
- prepends `usr\bin` and `mingw64\bin` to the current process `PATH`;
- makes MSYS2 Perl win over native Windows Perl for OpenSSL configure;
- sets GNU-target-specific `CC`, `CXX`, `AR`, and `RANLIB` variables using `C:/...` paths, not `C:\...` paths;
- sets `MAKE` to `mingw32-make.exe` using a `C:/...` path;
- points bindgen/clang users at the MSYS2 MinGW clang installation when available.

These changes are process-local. They do not permanently modify your system PATH.

## Useful commands

| Command | Purpose |
| --- | --- |
| `scripts\dev\bootstrap-windows.cmd` | Check required Windows tools and MSYS2 discovery. |
| `scripts\dev\diagnose-windows-build.cmd` | Print Rust, Perl, GCC, AR, RANLIB, Make, and bindgen diagnostics. |
| `scripts\dev\env-windows.cmd` | Print environment and workspace summary. |
| `scripts\dev\metadata-windows.cmd` | Run `cargo metadata --no-deps`. |
| `scripts\build.bat` | Run `cargo build --workspace --locked`. |
| `scripts\dev\repair-windows-openssl.cmd` | Remove stale `openssl-sys` build directories, then rebuild. |
| `scripts\dev\quick-check-windows.cmd` | Run GitHub hygiene checks plus Cargo metadata. |
| `scripts\dev\check-windows.cmd` | Run the standard local gate. |
| `scripts\dev\full-check-windows.cmd` | Run the full local gate including tests. |
| `scripts\dev\enter-windows-cargo-env.cmd` | Open a new `cmd.exe` with the MSYS2/MinGW Cargo environment already prepared. |

## Confirming the OpenSSL fix

Run:

```cmd
scripts\dev\diagnose-windows-build.cmd
```

The `Perl resolution` section should show MSYS2 Perl first, and `perl -V:osname` should not print `MSWin32`. The Cargo native tool section should show compiler paths with forward slashes, for example `C:/msys64/mingw64/bin/gcc.exe`, not `C:\msys64\mingw64\bin\gcc.exe`.

Good sign:

```text
C:\msys64\usr\bin\perl.exe
osname='msys'
```

Bad sign:

```text
...\Strawberry\perl\bin\perl.exe
osname='MSWin32'
```

If you still see `MSWin32`, either install MSYS2 to `C:\msys64` or set `MSYS2_ROOT` to your MSYS2 install before running the wrapper.

## Running plain Cargo commands

For this workspace on Windows GNU, prefer the wrappers:

```cmd
scripts\build.bat
```

If you want a shell where plain Cargo commands inherit the same environment, run:

```cmd
scripts\dev\enter-windows-cargo-env.cmd
```

Then in the new shell:

```cmd
cargo build --workspace --locked
```

## Other common native-tool failures

### Missing compiler tools

If the diagnostic script cannot find `gcc`, `ar`, `ranlib`, or `mingw32-make`, install or repair MSYS2 MinGW packages:

```bash
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
```

### libclang / bindgen failures

If a build reaches a bindgen-based crate and fails because `libclang` cannot be found, install MSYS2 clang:

```bash
pacman -S --needed mingw-w64-x86_64-clang
```

The wrappers set:

```text
LIBCLANG_PATH=C:/msys64/mingw64/lib
CLANG_PATH=C:/msys64/mingw64/bin/clang.exe
BINDGEN_EXTRA_CLANG_ARGS=--target=x86_64-w64-mingw32
```

when those paths exist.

## Source policy

These Windows helpers only prepare local build tooling. They do not modify validator, runtime, SVM, networking, consensus, or program source behavior.


## Windows GNU build entrypoint

Use the top-level scripts entrypoint, not a root batch file:

```cmd
scripts\build.bat
```

The build script runs `scripts\setup-windows.ps1`, generates `.cargo\env-windows.ps1` and `.cargo\env-windows.bat`, then builds the workspace. The generated environment uses bare GNU tool names like `gcc`, `g++`, `ar`, `ranlib`, and `mingw32-make` instead of absolute `C:\...` compiler paths so vendored OpenSSL does not get broken by MSYS shell path conversion.


## Windows GNU jemalloc note

For Windows GNU builds, see [`WINDOWS_GNU_BUILD_PATCH.md`](WINDOWS_GNU_BUILD_PATCH.md).
