# Set location of Npm installed globally
npm config set prefix /usr/local
curl --proto '=https' https://sh.rustup.rs -sSf | sh -s -- -y

# Configure Git maintenance
git config --global maintenance.strategy incremental
git config --global pack.packSizeLimit 128m
