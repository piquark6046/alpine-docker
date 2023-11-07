#!/bin/sh
#!/bin/bash

# packages lists
AptPackages=("wget" "man" "git" "nano" "curl" "tar" "jq" "grep" "vim" "sudo" "bash-completion" "7zip" "uname" "ca-certificates" "gnupg" "uidmap" "man" "mercurial" "subversion")

# Install APT packages
apt update
apt upgrade -y
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
for i in "${AptPackages[@]}"
do
  apt install -y "$i"
done

AptPackagesNonRecommeded=("autoconf" "automake" "bzip2" "dpkg-dev" "file" "g++" "gcc" "imagemagick" "libbz2-dev" "libc6-dev" "libcurl4-openssl-dev" "libdb-dev" "libevent-dev" "libffi-dev" "libgdbm-dev" "libglib2.0-dev" "libgmp-dev" "libjpeg-dev" "libkrb5-dev" "liblzma-dev" "libmagickcore-dev" "libmagickwand-dev" "libmaxminddb-dev" "libncurses5-dev" "libncursesw5-dev" "libpng-dev" "libpq-dev" "libreadline-dev" "libsqlite3-dev" "libssl-dev" "libtool" "libwebp-dev" "libxml2-dev" "libxslt-dev" "libyaml-dev" "make" "patch" "unzip" "xz-utils" "zlib1g-dev")

for i in "${AptPackagesNonRecommeded[@]}"
do
  apt install -y "$i"
done

rm -rf /var/lib/apt/lists/*

# Unminimize
yes | unminimize

# NodeJS
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs -y
sudo apt install gcc g++ make
npm update -g npm
npm i -g yarn

# Dotnet
wget -qO https://dot.net/v1/dotnet-install.sh | bash

# npm packages
NpmPackages=("ts-node" "tslib" "typescript")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done

# Install Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 