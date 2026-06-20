# Windows build notes

This workspace builds a very large Rust dependency graph. On Windows, the most
common failures are:

1. Cargo git-cache symlink materialization.
2. Native C library toolchain mismatch.
3. Missing MSYS2/MinGW tools for the `x86_64-pc-windows-gnu` Rust toolchain.

The wrapper scripts in `scripts/` check and repair these cases.

## Recommended first-time setup

From normal PowerShell in the repo root:

```powershell
scripts\windows\bootstrap-msys2.cmd
scripts\cargo-check-windows-clean-native.cmd
```

Or run both in one shot:

```powershell
scripts\cargo-check-windows-bootstrap.cmd
```

`pacman` is not a normal PowerShell command until MSYS2 exists and its `usr\bin`
directory is on PATH. The bootstrap script avoids that problem by invoking
`pacman` through MSYS2's own `bash.exe`.

## Recommended check command after MSYS2 exists

From the repo root on Windows:

```powershell
scripts\cargo-check-windows-clean-native.cmd
```

For fetch-only/non-native dependency retries you can still use
`scripts\cargo-check-windows.cmd`, but the clean-native wrapper is the safest
default on Windows GNU.

## Diagnose the native toolchain

```powershell
scripts\diagnose-windows-build.cmd
```

This prints Rust/Cargo, Perl, GCC, make, ar, ranlib, and PATH entries related to
MSYS2/MinGW/Perl.

## x86_64-pc-windows-gnu and OpenSSL

For `x86_64-pc-windows-gnu`, vendored OpenSSL must be configured by a Unix-like
MSYS2 Perl. Strawberry/ActivePerl reports `MSWin32` and produces Windows-style
paths, which makes OpenSSL fail with:

```text
Failure! Makefile wasn't produced.
This perl implementation doesn't produce Unix like paths.
This Perl version: ... MSWin32 ...
```

If the bootstrap script cannot install MSYS2 automatically, install MSYS2
manually. Prefer the default install location:

```text
C:\msys64
```

Then from an MSYS2 shell run:

```bash
pacman -Syu
pacman -S --needed base-devel perl mingw-w64-x86_64-toolchain mingw-w64-x86_64-perl
```

Then open a new PowerShell in the repo and run:

```powershell
scripts\cargo-check-windows-clean-native.cmd
```

The wrapper prepends `C:\msys64\usr\bin` and `C:\msys64\mingw64\bin` for the
current PowerShell process only, so OpenSSL sees the right Perl and MinGW tools
without permanently changing your system PATH.

If MSYS2 is installed somewhere else, set:

```powershell
$env:MSYS2_ROOT = "D:\path\to\msys64"
scripts\cargo-check-windows-clean-native.cmd
```

## Cargo git symlink repair

On Windows, Git/Cargo can sometimes materialize symlinks in Cargo's git cache as
tiny text files instead of real symlinks. When that happens, `cargo check` can
fail inside Cargo's cache with an error similar to:

```text
error: expected item, found `.`
...\.cargo\git\checkouts\crossbeam-*\crossbeam-epoch\no_atomic.rs:1:1
1 | ./no_atomic.rs
```

Repair only:

```powershell
scripts\windows\fix-cargo-git-symlinks.ps1
```

Clean the broken Crossbeam cache completely:

```powershell
scripts\windows\fix-cargo-git-symlinks.ps1 -CleanCrossbeamCache
scripts\cargo-check-windows-clean-native.cmd
```

The clean step only removes Cargo's cached Crossbeam git checkout/database. It
does not modify workspace source files.

## v7 note: PowerShell pacman confusion

If PowerShell says `pacman : The term 'pacman' is not recognized`, MSYS2 is not
installed or not on PATH. Do not keep running `pacman` directly in PowerShell.
Run:

```powershell
scripts\windows\bootstrap-msys2.cmd
```

The bootstrap script finds or installs MSYS2, then runs `pacman` through MSYS2
`bash.exe`.

## v6 note: missing drive-safe MSYS2 probing

If PowerShell reports `Join-Path : Cannot find drive` while probing `D:\msys64`
or another default MSYS2 location, update to v6 or newer. The v6+ script checks
whether a drive exists before testing default MSYS2 roots, so missing drives are
skipped cleanly.


## Troubleshooting: `nix::ifaddrs` on Windows

If `cargo check` fails with:

```text
error[E0432]: unresolved import `nix::ifaddrs`
```

use v8 or newer of this cleanup package. The streamer crate now gates `nix::ifaddrs` behind `cfg(unix)` and uses a Windows fallback for local IPv4 interface discovery. AF_XDP remains Linux-only; the Windows fallback only disables the local-destination optimization used by the XDP-backed QUIC sender.

## v9 note: direct `cargo check` still sees native Windows Perl

If plain `cargo check` fails at `openssl-sys` with:

```text
This perl implementation doesn't produce Unix like paths
This Perl version: ... MSWin32 ...
```

then Cargo is still seeing Strawberry/ActivePerl or another native Windows Perl.
The professional wrapper fixes that for the current run:

```powershell
scripts\cargo-check-windows-clean-native.cmd
```

If you want a PowerShell window where direct Cargo commands work, open one with:

```powershell
scripts\windows\enter-msys2-cargo-env.cmd
```

Then run:

```powershell
cargo check
```

If you specifically want plain `cargo check` to work in normal PowerShell without
using the wrapper, generate a local Cargo environment block:

```powershell
scripts\windows\write-msys2-cargo-env.cmd
cargo check
```

That command writes absolute MSYS2 tool paths into `.cargo/config.toml` and keeps
a timestamped backup. This is convenient for a local Windows GNU workstation, but
less portable than the wrapper script, so do not use it for cross-machine release
archives unless everyone uses the same MSYS2 path.


## libclang / RocksDB bindgen failure

If `cargo check` reaches `librocksdb-sys` and fails with something like:

```text
cannot find -lclang.dll
```

then bindgen/clang-sys found a raw `libclang.dll` from a native Windows LLVM
install, usually `C:\Program Files\LLVM\bin`, but the MinGW linker needs the
MSYS2 MinGW import library directory instead.

Run:

```powershell
scripts\windows\bootstrap-msys2.cmd
scripts\cargo-check-windows-clean-native.cmd
```

The bootstrap now installs `mingw-w64-x86_64-clang`, and the cargo wrapper sets:

- `LIBCLANG_PATH=C:\msys64\mingw64\lib`
- `CLANG_PATH=C:\msys64\mingw64\bin\clang.exe`
- `BINDGEN_EXTRA_CLANG_ARGS=--target=x86_64-w64-mingw32`

Avoid plain `cargo check` unless you first run:

```powershell
scripts\windows\enter-msys2-cargo-env.cmd
```

or write the local Cargo env block:

```powershell
scripts\windows\write-msys2-cargo-env.cmd
```

## v11 note: OpenSSL configures but `make build_libs` cannot find Perl

If OpenSSL gets past Configure and then fails during `make build_libs` with:

```text
/bin/sh: line 1: C:msys64usrbinperl.exe: command not found
make: *** [Makefile:2936: builddata.pm] Error 127
```

then OpenSSL successfully found MSYS2 Perl, but its generated Makefile captured
that Perl as a Windows absolute path such as `C:\msys64\usr\bin\perl.exe`.
MSYS `/bin/sh` treats backslashes as escape characters and strips them, producing
`C:msys64usrbinperl.exe`.

Use v11 or newer. The wrapper now sets shell-sensitive tools as command names
(`PERL=perl`, `CC=gcc`, `MAKE=make`) after putting MSYS2 first on PATH. Clean the
stale generated OpenSSL build directory once, then rerun the check:

```powershell
scripts\cargo-check-windows-clean-native.cmd
```

If you are inside a prepared shell from `enter-msys2-cargo-env.cmd`, clean first:

```powershell
scripts\windows\clean-native-build-cache.ps1
cargo check
```
