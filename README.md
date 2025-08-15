# Go Compiler Backport for Windows 7

Modern Go (v1.21+) no longer officially supports Windows 7. This project provides build scripts and patches to create a Go compiler that maintains compatibility with Windows 7 - both the compiler itself runs on Windows 7 systems, and it produces Windows binaries that are compatible with Windows 7.

## Project Status Notice

This project is maintained in my spare time primarily to support my own needs for running limited set of applications on legacy Windows 7 systems. While I aim to keep it functional, I cannot guarantee:

- Full compatibility with all use cases
- Long-term stability
- Timely updates to match new Go releases

There are other GoLang Windows 7 ports exists, consider to use them instead of this project, example of a good port: <https://github.com/thongtech/go-legacy-win7>

This port exists primarily for the sole purpose of running some of my own applications on legacy systems. It may contain any quick and dirty changes to achieve that goal, cutting corners where necessary and accidentally breaking compatibility with anything else.

Future maintenance is uncertain - there may come a point where updates cease entirely. The feasibility of backporting newer Go versions depends on technical complexity and available time. Pre-built binaries for the latest supported version are available in the [Releases](https://github.com/DarkCaster/Go-For-Win7-Target/releases) section.

This project based on reverse engineering insights from [0x08.ru's technical article](https://blog.0x08.ru/backporting-golang-to-windows7) and [go-legacy-win7 project by thongtech](https://github.com/thongtech/go-legacy-win7)

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
  - `GOROOT=<dir>` - directory of this Go compiler instance: `build/go`, or directory where downloaded binary archive was extracted
  - `GOPATH=<dir>` - base directory for various go downloads and caches
  - `GOTOOLCHAIN=local` - force the build system to use this specific compiler and not download compiler binaries for the corresponding `toolchain` line in `go.mod`
  - `GOOS=windows` - set target platform for which it will compile binaries, when compiling for windows it will use patched runtime that should work with Windows 7
  - `GOARCH=amd64` or `GOARCH=386` - architecture, both should work. **NOTE:** `arm` and `arm64` may work but untested (and also makes no sense for Windows 7)
