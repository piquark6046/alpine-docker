# Set location of Npm installed globally
npm config set prefix /usr/local
curl --proto '=https' https://sh.rustup.rs -sSf | sh -s -- -y

# Configure Git maintenance
git config --global maintenance.strategy incremental
git config --global pack.packSizeLimit 128m

# Install docker rootless
dockerd-rootless-setuptool.sh install
echo 'export PATH=/usr/bin:$PATH' > /home/container/.bashrc
echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' > /home/container/.bashrc