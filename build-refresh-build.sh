#!/usr/bin/env bash
set -eux

cargo check

echo "Building once"
bazel build //...

echo "Removing required dependency, rebuild should fail"
sed "/anyhow/d" Cargo.toml > Cargo.toml
bazel build //...

echo "Removing Cargo.toml and Cargo.lock, rebuild should absolutely fail :D"
mv Cargo.toml Cargo.toml.bak
rm Cargo.lock
bazel build //...

echo "Restoring Cargo.toml for further testing"
git checkout Cargo.toml
