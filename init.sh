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

# Unminimize
yes | unminimize

# NodeJS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt install -y nodejs
sudo apt install gcc g++ make
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
npm update -g npm

# Dotnet
wget -qO https://dot.net/v1/dotnet-install.sh | bash

# npm packages
NpmPackages=("ts-node" "tslib" "typescript")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done
