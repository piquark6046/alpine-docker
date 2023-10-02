#!/bin/sh
#!/bin/bash

# packages lists
ApkPackages=("wget" "git" "nano" "curl" "tar" "jq" "grep" "vim" "sudo" "bash-completion" "7zip" "uname" "ca-certificates" "gnupg" "nodejs" "npm" "ruby" "gcompat" "flatpak")

# Install app packages
apk update
apk upgrade
for i in "${ApkPackages[@]}"
do
  apk add "$i"
done
apk cache clean
rm -rf /var/cache/apk/*

# Dotnet
wget -qO https://dot.net/v1/dotnet-install.sh | sh

# npm packages
NpmPackages=("ts-node" "tslib" "typescript" "n")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done