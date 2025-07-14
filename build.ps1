#Requires -Version 4.0

# set version to build if not already set
if (-not $env:gosrc_ver) { $env:gosrc_ver = "1.24.5" }

$script_dir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$build_dir = Join-Path $script_dir "build"

# create build directory
if (Test-Path $build_dir) { Remove-Item $build_dir -Recurse -Force }
New-Item -ItemType Directory -Path $build_dir -Force | Out-Null
Set-Location $build_dir


# download archive with bootstrap go lang compiler
Write-Host "Downloading Go binaries for bootstrap"
$bootstrapUrl = "https://go.dev/dl/go1.22.12.windows-amd64.zip"
$bootstrapFile = Join-Path $build_dir "go1.22.12.windows-amd64.zip"
(New-Object System.Net.WebClient).DownloadFile($bootstrapUrl, $bootstrapFile)

# extract bootstrap
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($bootstrapFile, $build_dir)
Rename-Item -Path (Join-Path $build_dir "go") -NewName "go_bootstrap"

# download golang sources
Write-Host "Downloading Go sources"
$srcUrl = "https://go.dev/dl/go$($env:gosrc_ver).src.tar.gz"
$srcFile = Join-Path $build_dir "go$($env:gosrc_ver).src.tar.gz"
(New-Object System.Net.WebClient).DownloadFile($srcUrl, $srcFile)

# extract sources
& tar xf $srcFile

# apply patch
Set-Location (Join-Path $build_dir "go")
Write-Host "Patching sources"
$patchFile = Join-Path $script_dir "patches\go-$($env:gosrc_ver).patch"
& patch -p1 -i $patchFile

# build golang
Set-Location (Join-Path $build_dir "go\src")
Write-Host "Starting build"
$env:GOROOT_BOOTSTRAP = Join-Path $build_dir "go_bootstrap"
$env:GOOS = "windows"
$env:GOARCH = "386"

& .\make.bat