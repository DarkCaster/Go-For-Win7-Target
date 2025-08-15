#!/bin/bash

set -e

# set version to build if not already set
[[ -z $gosrc_ver ]] && gosrc_ver="1.25.0"

script_dir="$(cd "$(dirname "$0")" && pwd)"
build_dir="$script_dir/build"

# create build directory
rm -rf "$build_dir"
mkdir -p "$build_dir"
cd "$build_dir"

# download archive with bootstrap go lang compiler
echo "Downloading Go binaries for bootstrap"
wget -q "https://go.dev/dl/go1.22.12.linux-amd64.tar.gz"
tar xf "go1.22.12.linux-amd64.tar.gz"
mv go go_bootstrap

# download golang sources
echo "Downloading Go sources"
wget -q "https://go.dev/dl/go${gosrc_ver}.src.tar.gz"
tar xf "go${gosrc_ver}.src.tar.gz"

# apply patch
cd go
echo "Patching sources"
patch -p1 -i "$script_dir/patches/go-${gosrc_ver}.patch"

# build golang
cd src
echo "Starting build"
export GOROOT_BOOTSTRAP="$build_dir/go_bootstrap"
chmod 755 ./make.bash
./make.bash
