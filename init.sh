#!/bin/sh
#!/bin/bash

# packages lists
AptPackages=("wget" "git" "nano" "curl" "tar" "jq" "grep" "vim" "sudo" "bash-completion" "7zip" "uname")

# Install APT packages
apt update
apt upgrade -y
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
for i in "${AptPackages[@]}"
do
  apt install -y "$i"
done

yes | unminimize

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs
npm i -g yarn

# npm packages
NpmPackages=("ts-node" "tslib" "typescript")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done
