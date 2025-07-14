# Go Compiler Backport for Windows 7

Modern Go (v1.21+) no longer officially supports Windows 7. This project provides build scripts and patches to create a Go compiler that maintains compatibility with Windows 7 - both the compiler itself runs on Windows 7 systems, and it produces Windows binaries that are compatible with Windows 7 environments.

Based on reverse engineering insights from [0x08.ru's technical article](https://blog.0x08.ru/backporting-golang-to-windows7).

## Building the Backport

### Prerequisites

- Windows 10/11 or Linux x86_64 host system
- `tar` and `patch` binaries available in `PATH`

### Build Process

The project provides platform-specific build scripts:

- Use `build.ps1` for Windows systems
- Use `build.sh` for Linux systems

Build scripts will:

- Download official Go source
- Apply compatibility patches
- Compile modified toolchain
- Output to `build/go` directory

## Usage

- Use `go` binary from `build/go/bin` on your machine.
- Set following env variables before build:
  - `GOOS=windows`
  - `GOARCH=amd64` or `GOARCH=386`
