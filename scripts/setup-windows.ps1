$ErrorActionPreference = "Stop"

# Windows GNU/MSYS2 setup for this cleaned Agave workspace.
# This script intentionally mirrors the proven PowerShell-driven setup pattern:
#   1. discover MSYS2/LLVM tools,
#   2. persist bindgen/libclang values into .cargo/config.toml,
#   3. generate .cargo/env-windows.ps1 and .cargo/env-windows.bat,
#   4. avoid absolute CC/CXX paths so OpenSSL's MSYS make shell does not mangle them.

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$config = Join-Path $root ".cargo\config.toml"
$msysRoot = $env:MSYS2_ROOT
if ([string]::IsNullOrWhiteSpace($msysRoot)) { $msysRoot = "C:\msys64" }

function Get-ToolDirs {
  $dirs = @(
    (Join-Path $msysRoot "mingw64\bin"),
    (Join-Path $msysRoot "ucrt64\bin"),
    (Join-Path $msysRoot "clang64\bin"),
    (Join-Path $msysRoot "usr\bin"),
    "C:\Program Files\LLVM\bin"
  )
  return $dirs | Where-Object { Test-Path $_ }
}

function Find-FirstFile($dirs, $patterns, $nameRegex = $null) {
  foreach ($dir in $dirs) {
    foreach ($pattern in $patterns) {
      $items = Get-ChildItem -Path $dir -Filter $pattern -ErrorAction SilentlyContinue
      foreach ($item in $items) {
        if ($null -eq $nameRegex -or $item.Name -match $nameRegex) {
          return $item.FullName
        }
      }
    }
  }
  return $null
}

$dirs = @(Get-ToolDirs)
if ($dirs.Count -eq 0) {
  throw "No MSYS2/LLVM tool directories found. Install MSYS2 or set MSYS2_ROOT."
}

$libclang = Find-FirstFile $dirs @("libclang*.dll")
$clangExe = Find-FirstFile $dirs @("clang*.exe") '^clang(-[0-9]+)?\.exe$'
$perlExe = Find-FirstFile @((Join-Path $msysRoot "usr\bin"), (Join-Path $msysRoot "mingw64\bin")) @("perl.exe")
$gccExe = Find-FirstFile @((Join-Path $msysRoot "mingw64\bin")) @("gcc.exe")
$makeExe = Find-FirstFile @((Join-Path $msysRoot "mingw64\bin")) @("mingw32-make.exe")

if (-not $libclang) {
  Write-Host "candidate tool directories:"
  $dirs | ForEach-Object { Write-Host "  $_" }
  $pacman = Join-Path $msysRoot "usr\bin\pacman.exe"
  if (Test-Path $pacman) {
    Write-Host "installed clang-related MSYS2 packages:"
    & $pacman -Qs clang | Out-String | Write-Host
  }
  throw "Unable to find libclang*.dll. Install an MSYS2 clang/libclang package or LLVM for Windows."
}
if (-not $perlExe) { throw "Unable to find MSYS2 perl.exe under $msysRoot. Install base-devel/perl in MSYS2." }
if (-not $gccExe) { throw "Unable to find mingw64 gcc.exe under $msysRoot. Install mingw-w64-x86_64-gcc/toolchain." }
if (-not $makeExe) { throw "Unable to find mingw32-make.exe under $msysRoot. Install mingw-w64-x86_64-make/toolchain." }

$libclangDir = Split-Path $libclang -Parent
$usrBin = Join-Path $msysRoot "usr\bin"
$mingwBin = Join-Path $msysRoot "mingw64\bin"
$ucrtBin = Join-Path $msysRoot "ucrt64\bin"
$clangBin = Join-Path $msysRoot "clang64\bin"

if (!(Test-Path (Split-Path $config))) { New-Item -ItemType Directory -Path (Split-Path $config) | Out-Null }
if (!(Test-Path $config)) { New-Item -ItemType File -Path $config | Out-Null }

$text = Get-Content $config -Raw
if ($text -notmatch '(?m)^\[env\]\s*$') {
  Add-Content $config ""
  Add-Content $config "[env]"
}

function TomlPath($p) { return ($p -replace '\\', '\\') }
function Add-Or-ReplaceConfigLine($key, $line) {
  $current = Get-Content $config -Raw
  $pattern = '(?m)^"?' + [regex]::Escape($key) + '"?\s*=.*$'
  if ($current -match $pattern) {
    $updated = [regex]::Replace($current, $pattern, $line)
    Set-Content $config $updated
  } else {
    Add-Content $config $line
  }
}

Add-Or-ReplaceConfigLine "LIBCLANG_PATH" ('"LIBCLANG_PATH" = { value = "' + (TomlPath $libclangDir) + '", force = false }')
if ($clangExe) { Add-Or-ReplaceConfigLine "CLANG_PATH" ('"CLANG_PATH" = { value = "' + (TomlPath $clangExe) + '", force = false }') }
Add-Or-ReplaceConfigLine "BINDGEN_EXTRA_CLANG_ARGS_x86_64_pc_windows_gnu" '"BINDGEN_EXTRA_CLANG_ARGS_x86_64_pc_windows_gnu" = { value = "--target=x86_64-w64-windows-gnu", force = false }'
Add-Or-ReplaceConfigLine "BINDGEN_EXTRA_CLANG_ARGS_x86_64-pc-windows-gnu" '"BINDGEN_EXTRA_CLANG_ARGS_x86_64-pc-windows-gnu" = { value = "--target=x86_64-w64-windows-gnu", force = false }'
Add-Or-ReplaceConfigLine "CXXFLAGS_x86_64_pc_windows_gnu" '"CXXFLAGS_x86_64_pc_windows_gnu" = { value = "-include cstdint", force = false }'
Add-Or-ReplaceConfigLine "CXXFLAGS_x86_64-pc-windows-gnu" '"CXXFLAGS_x86_64-pc-windows-gnu" = { value = "-include cstdint", force = false }'

$envFile = Join-Path $root ".cargo\env-windows.ps1"
Set-Content $envFile @"
# Dot-source this file before running direct Cargo commands on Windows GNU:
#   . .\.cargo\env-windows.ps1
# The wrapper scripts load the same environment automatically.
`$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace(`$env:MSYS2_ROOT)) { `$env:MSYS2_ROOT = "$msysRoot" }

`$candidateDirs = @(
  (Join-Path `$env:MSYS2_ROOT "mingw64\bin"),
  (Join-Path `$env:MSYS2_ROOT "ucrt64\bin"),
  (Join-Path `$env:MSYS2_ROOT "clang64\bin"),
  (Join-Path `$env:MSYS2_ROOT "usr\bin"),
  "C:\Program Files\LLVM\bin"
) | Where-Object { Test-Path `$_ }

`$libclang = `$null
foreach (`$dir in `$candidateDirs) {
  `$hit = Get-ChildItem -Path `$dir -Filter "libclang*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1
  if (`$hit) { `$libclang = `$hit.FullName; break }
}
if (-not `$libclang) { throw "Unable to find libclang*.dll. Run scripts\setup-windows.bat or install MSYS2 clang/libclang." }

`$clang = `$null
foreach (`$dir in `$candidateDirs) {
  `$hit = Get-ChildItem -Path `$dir -Filter "clang*.exe" -ErrorAction SilentlyContinue | Where-Object { `$_.Name -match '^clang(-[0-9]+)?\.exe$' } | Select-Object -First 1
  if (`$hit) { `$clang = `$hit.FullName; break }
}

`$libclangDir = Split-Path `$libclang -Parent
`$mingwBin = Join-Path `$env:MSYS2_ROOT "mingw64\bin"
`$usrBin = Join-Path `$env:MSYS2_ROOT "usr\bin"
`$ucrtBin = Join-Path `$env:MSYS2_ROOT "ucrt64\bin"
`$clangBin = Join-Path `$env:MSYS2_ROOT "clang64\bin"

`$env:LIBCLANG_PATH = `$libclangDir
if (`$clang) { `$env:CLANG_PATH = `$clang }

# Use bare tool names instead of absolute C:\... paths. OpenSSL builds through
# MSYS sh/mingw32-make, and absolute Windows paths can be mangled by the shell.
`$env:CC_x86_64_pc_windows_gnu = "gcc"
Set-Item -Path Env:"CC_x86_64-pc-windows-gnu" -Value "gcc"
`$env:CXX_x86_64_pc_windows_gnu = "g++"
Set-Item -Path Env:"CXX_x86_64-pc-windows-gnu" -Value "g++"
`$env:AR_x86_64_pc_windows_gnu = "ar"
Set-Item -Path Env:"AR_x86_64-pc-windows-gnu" -Value "ar"
`$env:RANLIB_x86_64_pc_windows_gnu = "ranlib"
Set-Item -Path Env:"RANLIB_x86_64-pc-windows-gnu" -Value "ranlib"
`$env:MAKE = "mingw32-make"
`$env:CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER = "gcc"

`$env:CXXFLAGS_x86_64_pc_windows_gnu = "-include cstdint"
Set-Item -Path Env:"CXXFLAGS_x86_64-pc-windows-gnu" -Value "-include cstdint"
`$env:BINDGEN_EXTRA_CLANG_ARGS_x86_64_pc_windows_gnu = "--target=x86_64-w64-windows-gnu"
Set-Item -Path Env:"BINDGEN_EXTRA_CLANG_ARGS_x86_64-pc-windows-gnu" -Value "--target=x86_64-w64-windows-gnu"

`$prepend = @(`$mingwBin, `$usrBin, `$ucrtBin, `$clangBin, `$libclangDir) | Where-Object { Test-Path `$_ }
`$parts = @(`$env:Path -split ';')
`$orderedPrepend = @(`$prepend)
[array]::Reverse(`$orderedPrepend)
foreach (`$dir in `$orderedPrepend) {
  if (`$parts -notcontains `$dir) { `$env:Path = "`$dir;`$env:Path" }
}

Write-Host "Windows Cargo environment loaded."
Write-Host "MSYS2_ROOT=`$env:MSYS2_ROOT"
Write-Host "LIBCLANG_PATH=`$env:LIBCLANG_PATH"
if (`$env:CLANG_PATH) { Write-Host "CLANG_PATH=`$env:CLANG_PATH" }
Write-Host "CC_x86_64_pc_windows_gnu=`$env:CC_x86_64_pc_windows_gnu"
Write-Host "MAKE=`$env:MAKE"
"@

$envBat = Join-Path $root ".cargo\env-windows.bat"
Set-Content $envBat @"
@echo off
call "%~dp0..\scripts\lib\windows-env.bat"
"@

Write-Host "windows bindgen/libclang/MSYS2 repair applied"
Write-Host "libclang: $libclang"
if ($clangExe) { Write-Host "clang:    $clangExe" } else { Write-Host "clang:    not found; bindgen will use libclang directly" }
Write-Host "perl:     $perlExe"
Write-Host "gcc:      $gccExe"
Write-Host "make:     $makeExe"
Write-Host ""
Write-Host "For direct cargo commands in this PowerShell session, run:"
Write-Host "  . .\.cargo\env-windows.ps1"
