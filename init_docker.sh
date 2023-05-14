# Set location of Npm installed globally
npm config set prefix /usr/local

# Install Rust and wasm-pack
curl --proto '=https' --tlsv1.3  https://sh.rustup.rs -sSf | sh -s -- -y
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh