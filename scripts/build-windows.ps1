param(
    [ValidateSet('Debug', 'ReleaseSafe')]
    [string]$Optimize = 'ReleaseSafe'
)

$ErrorActionPreference = 'Stop'

if ($env:OS -ne 'Windows_NT') {
    throw 'scripts/build-windows.ps1 must run on Windows.'
}

$zig = Get-Command zig -ErrorAction SilentlyContinue
if (-not $zig) {
    throw 'Zig 0.16.0 is required. Download it from https://ziglang.org/download/.'
}

$version = (& $zig.Source version).Trim()
if ($version -ne '0.16.0') {
    throw "Zig 0.16.0 is required; found $version."
}

& $zig.Source build "-Doptimize=$Optimize"
if ($LASTEXITCODE -ne 0) {
    throw "Windows build failed with exit code $LASTEXITCODE."
}

$binary = Join-Path $PSScriptRoot '..\zig-out\bin\fx.exe'
if (-not (Test-Path -LiteralPath $binary)) {
    throw "Build succeeded but fx.exe was not found at $binary."
}

& $binary --version
if ($LASTEXITCODE -ne 0) {
    throw 'fx.exe version smoke test failed.'
}

& $binary status --json
if ($LASTEXITCODE -ne 0) {
    throw 'fx.exe status smoke test failed.'
}

Write-Host "Windows build ready: $binary"
