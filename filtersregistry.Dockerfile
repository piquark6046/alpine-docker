FROM ghcr.io/piquark6046/ubuntu-docker:latest

USER root

# Install packages with root
WORKDIR /
USER container
RUN cd /home/container && git clone https://github.com/AdguardTeam/FiltersRegistry
RUN cd /home/container/FiltersRegistry && git maintenance run --task=commit-graph --task=prefetch --task=loose-objects --task=incremental-repack --task=pack-refs