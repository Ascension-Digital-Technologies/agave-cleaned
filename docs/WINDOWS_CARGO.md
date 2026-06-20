# Windows Cargo helper guide

Use the Windows wrappers in `scripts/dev/` instead of plain Cargo commands when building this workspace with the GNU Windows target.

## Recommended commands

```cmd
scripts\dev\bootstrap-windows.cmd
scripts\dev\diagnose-windows-build.cmd
scripts\dev\quick-check-windows.cmd
scripts\build.bat
```

## Why the wrappers matter

Large Rust workspaces often compile native dependencies. In this repository, `openssl-sys` may build vendored OpenSSL. On `x86_64-pc-windows-gnu`, that configure step needs MSYS2 Perl, not native Windows Perl.

The wrappers call:

```cmd
scripts\dev\lib\windows-cargo-env.cmd
```

before Cargo runs. That helper makes MSYS2/MinGW tools available for the current process only. It also exports compiler paths as `C:/...` instead of `C:\...` because OpenSSL runs its Makefile commands through MSYS `sh`, where backslashes are consumed as escapes.

## Open a prepared shell

To run direct Cargo commands safely, open a prepared shell:

```cmd
scripts\dev\enter-windows-cargo-env.cmd
```

Then run normal Cargo commands from the new shell:

```cmd
cargo metadata --no-deps
cargo build --workspace --locked
cargo test --workspace --locked
```

## Diagnosing problems

Run:

```cmd
scripts\dev\diagnose-windows-build.cmd
```

If `perl -V:osname` reports `MSWin32`, Cargo is still seeing native Windows Perl and OpenSSL will likely fail. Install MSYS2 to `C:\msys64` or set `MSYS2_ROOT` to your install path before running the wrappers.


## Repair stale OpenSSL build state

If an earlier run failed inside `openssl-sys`, Cargo may leave a partial build directory under `target`. Use the repair wrapper to clear only the OpenSSL build directories and retry with the corrected environment:

```cmd
scripts\dev\repair-windows-openssl.cmd
```

The specific error this fixes looks like:

```text
/usr/bin/sh: line 1: C:msys64mingw64bingcc.exe: command not found
```

That means the compiler path reached MSYS `sh` with backslashes. The v20 wrapper exports `C:/msys64/mingw64/bin/gcc.exe` instead.


## Windows GNU build entrypoint

Use the top-level scripts entrypoint, not a root batch file:

```cmd
scripts\build.bat
```

The build script runs `scripts\setup-windows.ps1`, generates `.cargo\env-windows.ps1` and `.cargo\env-windows.bat`, then builds the workspace. The generated environment uses bare GNU tool names like `gcc`, `g++`, `ar`, `ranlib`, and `mingw32-make` instead of absolute `C:\...` compiler paths so vendored OpenSSL does not get broken by MSYS shell path conversion.
