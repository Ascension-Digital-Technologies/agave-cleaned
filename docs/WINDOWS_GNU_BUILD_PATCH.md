# Windows GNU build compatibility

This cleaned workspace includes one Windows-only build compatibility patch for the `x86_64-pc-windows-gnu` target.

## Why this exists

The upstream Agave workspace enables `tikv-jemallocator` for targets that are not MSVC and not FreeBSD. That includes the Windows GNU target. On this workspace, `cargo build --workspace --locked` under Windows GNU reached the native allocator step and failed with:

```text
error: could not find native static library `jemalloc`, perhaps an -L flag is missing?
```

The Windows build scripts now correctly prepare MSYS2, Perl, OpenSSL, bindgen, libclang, GCC, and Make. The remaining failure is specific to the `tikv-jemalloc-sys` native static library on Windows GNU.

## What changed

For Windows targets only, this workspace uses Rust's default system allocator instead of `tikv-jemallocator`.

The affected `cfg` boundary was changed from:

```rust
#[cfg(not(any(target_env = "msvc", target_os = "freebsd")))]
```

to:

```rust
#[cfg(not(any(target_os = "windows", target_os = "freebsd")))]
```

The matching Cargo target dependency sections were updated the same way.

## Scope

This does not alter Linux validator behavior. Linux builds still use jemalloc where upstream enables it.

This does not change consensus, runtime, SVM, networking, RPC, account storage, ledger, or protocol behavior.

It only prevents Windows GNU builds from attempting to compile/link the unsupported native jemalloc static library.

## Build command

Use:

```cmd
scripts\build.bat
```

That script prepares the Windows GNU/MSYS2 Cargo environment and then runs:

```cmd
cargo build --workspace --locked
```
